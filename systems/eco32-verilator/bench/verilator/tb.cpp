#include <signal.h>
#include "Vorpsoc_top__Syms.h"

#include "verilated.h"
#include "verilated_vcd_c.h"
extern "C" uint8_t* load_elf_file(char* elf_file_name, int *size);
extern "C" unsigned int read_32(uint8_t *bin_file, unsigned int address);

static bool done = false;

void INThandler(int signal)
{
	printf("\nCaught ctrl-c\n");
	done = true;
}

void parseArgs(int argc, char **argv);

int timeout = 0;
char *elf_file_name = NULL;
char *bin_file_name = NULL;
int vcd;
int vcd_start;
int vcd_stop;

int main(int argc, char **argv, char **env)
{
	Verilated::commandArgs(argc, argv);

	Vorpsoc_top* top = new Vorpsoc_top;
	int vcd_dump = 0;

	signal(SIGINT, INThandler);

	if(argc > 1)
		parseArgs(argc, argv);
	uint32_t insn = 0;
	uint32_t ex_pc = 0;
	int t = 0;
	int size;

	if (elf_file_name) {
		printf("Loading %s\n",elf_file_name);
		uint8_t *bin_data = load_elf_file(elf_file_name, &size);
		if (bin_data == NULL) {
			printf("Error loading elf file\n");
			exit(1);
		}
		for (int i=0; i <size;i+=4) {
			top->v->wb_bfm_memory0->mem[i/4] = read_32(bin_data, i);
		}
	}

	if (bin_file_name) {
		printf("Loading %s\n", bin_file_name);
		uint8_t *bin_data;
		FILE *bin_file = fopen(bin_file_name, "rb");

		if (bin_file == NULL) {
			printf("Error opening bin file\n");
			exit(1);
		}
		fseek(bin_file, 0, SEEK_END);
		size = ftell(bin_file);
		rewind(bin_file);
		bin_data = (uint8_t *)malloc(size);
		if (fread(bin_data, 1, size, bin_file) != size) {
			printf("Error reading bin file\n");
			exit(1);
		}

		for (int i=0; i <size;i+=4) {
			top->v->wb_bfm_memory0->mem[i/4] = read_32(bin_data, i);
		}
	}

	top->wb_clk_i = 0;
	top->wb_rst_i = 1;

	Verilated::traceEverOn(true);
	VerilatedVcdC* tfp = new VerilatedVcdC;
	top->trace (tfp, 99);
	tfp->open ("simx.vcd");
	while (!done) {
		if (vcd_dump)
			tfp->dump(t);
		top->eval();
		if(t>2) top->wb_rst_i = 0;
		top->wb_clk_i = !top->wb_clk_i;
		ex_pc = top->v->eco32_0->pc;

		if (vcd && t >= vcd_start) {
			if (!vcd_dump)
				printf("VCD dump started\n");
			vcd_dump = 1;
		}

		if (vcd_stop && t >= vcd_stop) {
			if (vcd_dump)
				printf("VCD dump stopped\n");
			vcd_dump = 0;
		}

		if(timeout && t>timeout) {
			printf("Timeout reached\n");
			done = true;
		}

		if (Verilated::gotFinish()) {
			printf("Caught $finish()\n");
			done = true;
		}
		t++;
	}
	printf("Simulation ended at PC = %08x, t = %d\n", ex_pc, t);
	tfp->close();
	exit(0);
}

void parseArgs(int argc, char **argv)
{
	int i = 1;
	while (i < argc) {
		if (strcmp(argv[i], "--timeout") == 0) {
			i++;
			timeout = strtod(argv[i], 0);
		} else if (strcmp(argv[i], "--elf-load") == 0) {
			i++;
			elf_file_name = argv[i];
		} else if (strcmp(argv[i], "--bin-load") == 0) {
			i++;
			bin_file_name = argv[i];
		} else if (strcmp(argv[i], "--vcd") == 0) {
			vcd = 1;
		} else if (strcmp(argv[i], "--vcd-start") == 0) {
			i++;
			vcd_start = strtol(argv[i], 0, 10);
		} else if (strcmp(argv[i], "--vcd-stop") == 0) {
			i++;
			vcd_stop = strtol(argv[i], 0, 10);
		} else if ((strcmp(argv[i], "-h") == 0) ||
			 (strcmp(argv[i], "--help") == 0)) {
			printf("Usage: %s [options]\n", argv[0]);
			printf("\n  eco32 cycle accurate model\n");
			printf("\n");
			printf("Options:\n");
			printf("  -h, --help\t\tPrint this help message\n");
			printf("\nSimulation control:\n");
			printf("  --elf-load <file> \tLoad program from ELF <file>\n");
			printf("  --bin-load <file> \tLoad program from binary <file>\n");
			printf("  --timeout <val> \tStop the sim at <val> ns\n");
			printf("\nVCD generation:\n");
			printf("  --vcd\t\tEnable VCD generation\n");
			printf("  --vcd-start <val>\tEnable and delay VCD generation until <val> cycles\n");
			printf("  --vcd-stop <val> \tEnable and terminate VCD generation at <val> cycles\n");
			printf("\n");
			exit(0);
		}
		i++;
	}
}
