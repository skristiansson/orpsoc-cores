#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <elf-loader/elf-loader.h>
#include "verilator_tb_utils.h"

#define VCD_DEFAULT_NAME	"../sim.vcd"

VerilatorTbUtils::VerilatorTbUtils(int argc, char **argv, uint32_t *mem)
  : mem(mem), t(0), timeout(0), vcdDump(false), vcdDumpStart(0), vcdDumpStop(0),
    vcdFileName(0), elfFileName(0), binFileName(0), rspServerEnable(false),
    rspServerPort(0) {
  tfp = new VerilatedVcdC;

  Verilated::commandArgs(argc, argv);
  parseArgs(argc, argv);

  if (elfFileName)
    loadElf();
  else if (binFileName)
    loadBin();

  Verilated::traceEverOn(true);
}

VerilatorTbUtils::~VerilatorTbUtils() {
  free(vcdFileName);
}

bool VerilatorTbUtils::doCycle() {
  if (vcdDumpStop && t >= vcdDumpStop) {
    if (vcdDumping) {
      printf("VCD dump stopped (%lu)\n", t);
      tfp->close();
    }
    vcdDumping = false;
  } else if (vcdDump && t >= vcdDumpStart) {
    if (!vcdDumping) {
      printf("VCD dump started (%lu)\n", t);
      tfp->open(vcdFileName);
    }
    vcdDumping = true;
  }

  if (vcdDumping)
    tfp->dump(t);

  if(timeout && t >= timeout) {
    printf("Timeout reached\n");
    return false;
  }

  if (Verilated::gotFinish()) {
    printf("Caught $finish()\n");
    return false;
  }

  t++;
  return true;
}

bool VerilatorTbUtils::loadElf() {
  uint8_t *bin_data;
  int size;

  printf("Loading %s\n",this->elfFileName);
  bin_data = load_elf_file(this->elfFileName, &size);
  if (bin_data == NULL) {
    printf("Error loading elf file\n");
    return false;
  }

  for (int i = 0; i < size; i += 4)
    this->mem[i/4] = read_32(bin_data, i);

  free(bin_data);

  return true;
}

bool VerilatorTbUtils::loadBin() {
  uint8_t *bin_data;
  int size;
  FILE *bin_file = fopen(this->binFileName, "rb");

  printf("Loading %s\n", this->binFileName);

  if (bin_file == NULL) {
    printf("Error opening bin file\n");
    return false;
  }
  fseek(bin_file, 0, SEEK_END);
  size = ftell(bin_file);
  rewind(bin_file);
  bin_data = (uint8_t *)malloc(size);
  if (fread(bin_data, 1, size, bin_file) != size) {
    printf("Error reading bin file\n");
    return false;
  }

  for (int i=0; i < size; i+=4)
    this->mem[i/4] = read_32(bin_data, i);

  free(bin_data);

  return true;
}

void VerilatorTbUtils::parseArgs(int argc, char **argv) {
  int i = 1;

  while (i < argc) {
    if (strcmp(argv[i], "--timeout") == 0) {
      this->timeout = strtol(argv[++i], NULL, 10);
    } else if (strcmp(argv[i], "--elf-load") == 0) {
      this->elfFileName = argv[++i];
    } else if (strcmp(argv[i], "--bin-load") == 0) {
      this->binFileName = argv[++i];
    } else if ((strcmp(argv[i], "-v") == 0) ||
               (strcmp(argv[i], "--vcd") == 0)) {
      this->vcdDump = true;
      if (((i + 1) < argc) && (argv[i+1][0] != '-'))
        this->vcdFileName = strdup(argv[++i]);
      else
        this->vcdFileName = strdup(VCD_DEFAULT_NAME);
    } else if ((strcmp(argv[i], "-s") == 0) ||
               (strcmp(argv[i], "--vcdstart") == 0)) {
      this->vcdDumpStart = strtol(argv[++i], NULL, 10);
    } else if ((strcmp(argv[i], "-t") == 0) ||
               (strcmp(argv[i], "--vcdstop") == 0)) {
      this->vcdDumpStop = strtol(argv[++i], NULL, 10);
#ifdef JTAG_DEBUG
    } else if ((strcmp(argv[i], "-r") == 0) ||
               (strcmp(argv[i], "--rsp") == 0)) {
      this->rspServerEnable = true;
      if (++i < argc)
        if (argv[i][0] != '-') {
          this->rspServerPort = atoi(argv[i]);
        }
#endif
    } else if ((strcmp(argv[i], "-h") == 0) ||
               (strcmp(argv[i], "--help") == 0)) {
      printf("Usage: %s [options]\n", argv[0]);
      printf("\n  or1200-generic cycle accurate model\n");
      printf("Options:\n");
      printf("  -h, --help\t\tPrint this help message\n");
      printf("\nSimulation control:\n");
      printf("  --elf-load <file> \tLoad program from ELF <file>\n");
      printf("  --bin-load <file> \tLoad program from binary <file>\n");
      printf("  --timeout <val> \tStop the sim at <val> ns\n");
      printf("\nVCD generation:\n");
      printf("  -v, --vcdon\t\tEnable VCD generation\n");
      printf("  -d, --vcdfile <file>\tEnable and save VCD to <file>\n");
      printf("  -s, --vcdstart <val>\tEnable and delay VCD generation until <val> ns\n");
      printf("  -t, --vcdstop <val> \tEnable and terminate VCD generation at <val> ns\n");
#ifdef JTAG_DEBUG
      printf("\nRemote debugging:\n");
      printf("  -r, --rsp [<port>]\tEnable RSP debugging server, opt. specify <port>\n");
#endif
      printf("\n");
      exit(0);
    }
    i++;
  }

}
