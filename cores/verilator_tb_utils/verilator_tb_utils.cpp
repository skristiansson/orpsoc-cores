#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <argp.h>
#include <elf-loader/elf-loader.h>
#include "verilator_tb_utils.h"

#define VCD_DEFAULT_NAME "../sim.vcd"

VerilatorTbUtils::VerilatorTbUtils(int argc, char **argv, uint32_t *mem)
  : mem(mem), t(0), timeout(0), vcdDump(false), vcdDumpStart(0), vcdDumpStop(0),
    vcdFileName((char *)VCD_DEFAULT_NAME), elfFileName(0), binFileName(0),
    rspServerEnable(false), rspServerPort(0) {
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

#define TIMEOUT_OPT 512
#define ELFLOAD_OPT 513
#define BINLOAD_OPT 514

int VerilatorTbUtils::parseOpts(int key, char *arg, struct argp_state *state) {
  VerilatorTbUtils *tbUtils = static_cast<VerilatorTbUtils *>(state->input);

  switch (key) {
  case TIMEOUT_OPT:
    tbUtils->timeout = strtol(arg, NULL, 10);
    break;

  case ELFLOAD_OPT:
    tbUtils->elfFileName = arg;
    break;

  case BINLOAD_OPT:
    tbUtils->binFileName = arg;
    break;

  case 'v':
    tbUtils->vcdDump = true;
    if (arg)
      tbUtils->vcdFileName = arg;
    break;

  case 's':
    tbUtils->vcdDumpStart = strtol(arg, NULL, 10);
    break;

  case 't':
    tbUtils->vcdDumpStop = strtol(arg, NULL, 10);
    break;

  case 'r':
      tbUtils->rspServerEnable = true;
      if (arg)
        tbUtils->rspServerPort = atoi(arg);
    break;
  }

  return 0;
}

int VerilatorTbUtils::parseArgs(int argc, char **argv) {
  struct argp_option options[] = {
    { 0, 0, 0, 0, "Simulation control:", 1 },
    { "timeout", TIMEOUT_OPT, "VAL", 0, "Stop the sim at VAL" },
    { "elf-load", ELFLOAD_OPT, "FILE", 0, "Load program from ELF FILE" },
    { "bin-load", BINLOAD_OPT, "FILE", 0, "Load program from binary FILE" },
    { 0, 0, 0, 0, "VCD generation:", 2 },
    { "vcd", 'v', "FILE", OPTION_ARG_OPTIONAL, "Enable and save VCD to FILE" },
    { "vcdstart", 's', "VAL", 0, "Delay VCD generation until VAL" },
    { "vcdstop", 't', "VAL", 0, "Terminate VCD generation at VAL" },
    { 0, 0, 0, 0, "Remote debugging:", 3 },
    { "rsp", 'r', "PORT", OPTION_ARG_OPTIONAL, "Enable RSP debugging server, opt. specify PORT" },
    { 0 },
  };

  struct argp argp = {options, parseOpts, 0};

  return argp_parse(&argp, argc, argv, 0, 0, this);
}
