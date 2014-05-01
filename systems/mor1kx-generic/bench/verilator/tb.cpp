/*
 * mor1kx-generic system Verilator testbench
 *
 * Author: Olof Kindgren <olof.kindgren@gmail.com>
 * Author: Franck Jullien <franck.jullien@gmail.com>
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 *
 */

#include <stdint.h>
#include <signal.h>
#include <argp.h>
#include <verilator_tb_utils.h>

#include "Vorpsoc_top__Syms.h"

static bool done;

#define NOP_NOP			0x0000      /* Normal nop instruction */
#define NOP_EXIT		0x0001      /* End of simulation */
#define NOP_REPORT		0x0002      /* Simple report */
#define NOP_PUTC		0x0004      /* Simputc instruction */
#define NOP_CNT_RESET		0x0005      /* Reset statistics counters */
#define NOP_GET_TICKS		0x0006      /* Get # ticks running */
#define NOP_GET_PS		0x0007      /* Get picosecs/cycle */
#define NOP_TRACE_ON		0x0008      /* Turn on tracing */
#define NOP_TRACE_OFF		0x0009      /* Turn off tracing */
#define NOP_RANDOM		0x000a      /* Return 4 random bytes */
#define NOP_OR1KSIM		0x000b      /* Return non-zero if this is Or1ksim */
#define NOP_EXIT_SILENT		0x000c      /* End of simulation, quiet version */

#define RESET_TIME		2

int exit_code;

void INThandler(int signal)
{
	printf("\nCaught ctrl-c\n");
	done = true;
}

static int parse_opt(int key, char *arg, struct argp_state *state)
{
	switch (key) {
	case ARGP_KEY_INIT:
		state->child_inputs[0] = state->input;
		break;
	// Add parsing of custom options here
	}

	return 0;
}

static int parse_args(int argc, char **argv, VerilatorTbUtils* tbUtils)
{
	struct argp_option options[] = {
		// Add custom options here
		{ 0 }
	};
	struct argp_child child_parsers[] = {
		{ &verilator_tb_utils_argp, 0, "", 0 },
		{ 0 }
	};
	struct argp argp = { options, parse_opt, 0, 0, child_parsers };

	return argp_parse(&argp, argc, argv, 0, 0, tbUtils);
}

bool mor1kx_monitor(Vorpsoc_top* top)
{
	uint32_t insn = top->v->mor1kx0->mor1kx_cpu->monitor_execute_insn;
	bool stall = !top->v->mor1kx0->mor1kx_cpu->monitor_execute_advance;
	uint32_t r3;

	if (stall)
		return false;

	if ((insn & 0xff000000) != 0x15000000)
		return false;

	r3 = top->v->mor1kx0->mor1kx_cpu->cappuccino__DOT__mor1kx_cpu->
		get_gpr(3);

	switch (insn & 0xffff) {
	case NOP_EXIT:
		exit_code = r3;
		printf("exit(%u)\n", exit_code);
		return true;

	case NOP_REPORT:
		printf("report(0x%08x)\n", r3);
		return false;

	default:
		return false;
	}

	return false;
}

int main(int argc, char **argv, char **env)
{
	uint32_t ex_pc = 0;
	uint32_t last_pc = 0;
	uint32_t cnt = 0;

	exit_code = 0;

	Verilated::commandArgs(argc, argv);

	Vorpsoc_top* top = new Vorpsoc_top;
	VerilatorTbUtils* tbUtils =
		new VerilatorTbUtils(top->v->wb_bfm_memory0->mem);

	parse_args(argc, argv, tbUtils);

	signal(SIGINT, INThandler);

	top->wb_clk_i = 0;
	top->wb_rst_i = 1;

	top->trace(tbUtils->tfp, 99);

	while (tbUtils->doCycle() && !done) {
		if (tbUtils->getTime() > RESET_TIME)
			top->wb_rst_i = 0;

		top->eval();

		top->wb_clk_i = !top->wb_clk_i;

		if (top->wb_clk_i && mor1kx_monitor(top))
			done = true;

		ex_pc = top->v->mor1kx0->mor1kx_cpu->monitor_execute_pc;
/*
		if (ex_pc == 0xc0003c7c)
			printf("ex_pc = %x (%lu)\n", ex_pc, tbUtils->getTime());
		if (last_pc == ex_pc && ex_pc == 0xc0003c7c)
			cnt++;
		else
			cnt = 0;
		if (cnt > 200)
			done = true;
		last_pc = ex_pc;
*/
	}

	ex_pc = top->v->mor1kx0->mor1kx_cpu->monitor_execute_pc;
	printf("Simulation ended at PC = %08x (%lu)\n",
	       ex_pc, tbUtils->getTime());

	delete tbUtils;
	exit(exit_code);
}
