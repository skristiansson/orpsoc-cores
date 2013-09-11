//////////////////////////////////////////////////////////////////////
//
// clkgen
//
// Handles clock and reset generation for rest of design
//
//
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009, 2010 Authors and OPENCORES.ORG           ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

`include "timescale.v"
`include "orpsoc-defines.v"

module clkgen
(
	// Main clocks in, depending on board
	input	sys_clk_pad_i,
	// Asynchronous, active low reset in
	input	rst_n_pad_i,
	// Input reset - through a buffer, asynchronous
	output	async_rst_o,

`ifdef SIM
	// JTAG clock
	input	tck_pad_i,
	output	dbg_tck_o,
`endif

	// Wishbone clock and reset out
	output	wb_clk_o,
	output	wb_rst_o
);

// First, deal with the asychronous reset
wire	async_rst;
wire	async_rst_n;

assign	async_rst_n  = rst_n_pad_i;
assign	async_rst  = ~async_rst_n;

// Everyone likes active-high reset signals...
assign	async_rst_o = ~async_rst_n;

`ifdef SIM
assign	dbg_tck_o = tck_pad_i;
`endif

//
// Declare synchronous reset wires here
//

// An active-low synchronous reset signal (usually a PLL lock signal)
wire   sync_rst_n;

wire   pll0_lock;

`ifndef SIM
wire   pll0_clk0;
wire   pll0_clk1;

assign wb_clk_o = pll0_clk0;

altera_pll #(
	.fractional_vco_multiplier("false"),
	.reference_clock_frequency("50.0 MHz"),
	.operation_mode("normal"),
	.number_of_clocks(2),
	.output_clock_frequency0("50.0 MHz"),
	.phase_shift0("0 ps"),
	.duty_cycle0(50),
	.output_clock_frequency1("100.0 MHz"),
	.phase_shift1("0 ps"),
	.duty_cycle1(50),
	.output_clock_frequency2("0 MHz"),
	.phase_shift2("0 ps"),
	.duty_cycle2(50),
	.output_clock_frequency3("0 MHz"),
	.phase_shift3("0 ps"),
	.duty_cycle3(50),
	.output_clock_frequency4("0 MHz"),
	.phase_shift4("0 ps"),
	.duty_cycle4(50),
	.output_clock_frequency5("0 MHz"),
	.phase_shift5("0 ps"),
	.duty_cycle5(50),
	.output_clock_frequency6("0 MHz"),
	.phase_shift6("0 ps"),
	.duty_cycle6(50),
	.output_clock_frequency7("0 MHz"),
	.phase_shift7("0 ps"),
	.duty_cycle7(50),
	.output_clock_frequency8("0 MHz"),
	.phase_shift8("0 ps"),
	.duty_cycle8(50),
	.output_clock_frequency9("0 MHz"),
	.phase_shift9("0 ps"),
	.duty_cycle9(50),
	.output_clock_frequency10("0 MHz"),
	.phase_shift10("0 ps"),
	.duty_cycle10(50),
	.output_clock_frequency11("0 MHz"),
	.phase_shift11("0 ps"),
	.duty_cycle11(50),
	.output_clock_frequency12("0 MHz"),
	.phase_shift12("0 ps"),
	.duty_cycle12(50),
	.output_clock_frequency13("0 MHz"),
	.phase_shift13("0 ps"),
	.duty_cycle13(50),
	.output_clock_frequency14("0 MHz"),
	.phase_shift14("0 ps"),
	.duty_cycle14(50),
	.output_clock_frequency15("0 MHz"),
	.phase_shift15("0 ps"),
	.duty_cycle15(50),
	.output_clock_frequency16("0 MHz"),
	.phase_shift16("0 ps"),
	.duty_cycle16(50),
	.output_clock_frequency17("0 MHz"),
	.phase_shift17("0 ps"),
	.duty_cycle17(50),
	.pll_type("General"),
	.pll_subtype("General")
) pll0 (
	.outclk	({pll0_clk1, pll0_clk0}),
	.locked	(pll0_lock),
	.fboutclk	( ),
	.fbclk	(1'b0),
	.rst	(async_rst),
	.refclk	(sys_clk_pad_i)
);

`else

assign wb_clk_o = sys_clk_pad_i;
assign pll0_lock = 1'b1;

`endif

assign sync_rst_n = pll0_lock;

//
// Reset generation
//
//

// Reset generation for wishbone
reg [15:0]	wb_rst_shr;

always @(posedge wb_clk_o or posedge async_rst)
	if (async_rst)
		wb_rst_shr <= 16'hffff;
	else
		wb_rst_shr <= {wb_rst_shr[14:0], ~(sync_rst_n)};

assign wb_rst_o = wb_rst_shr[15];

endmodule // clkgen
