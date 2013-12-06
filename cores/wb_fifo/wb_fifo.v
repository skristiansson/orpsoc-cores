/*
 * Copyright (c) 2013, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
 * All rights reserved.
 *
 * Redistribution and use in source and non-source forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in non-source form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 * THIS WORK IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * WORK, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

module wb_fifo #(
	parameter AW = 32,
	parameter DW = 32
)(
	input 		 clk,
	input 		 rst,

	output 		 irq_o,

	// Wishbone slave interface
	input [AW-1:0] 	 wb_adr_i,
	input [DW-1:0] 	 wb_dat_i,
	input [DW/8-1:0] wb_sel_i,
	input 		 wb_we_i,
	input 		 wb_cyc_i,
	input 		 wb_stb_i,
	input [2:0] 	 wb_cti_i,
	input [1:0] 	 wb_bte_i,
	output [DW-1:0]  wb_dat_o,
	output reg 	 wb_ack_o,
	output 		 wb_err_o,
	output 		 wb_rty_o
);

//
// FIFO with wishbone interface and irq indication when FIFO is not empty
//

reg fifo_data_avail;
reg [DW-1:0] fifo_reg;
wire [DW-1:0] status;

// Ack generation
always @(posedge clk)
	wb_ack_o <= wb_cyc_i & wb_stb_i & !wb_ack_o;

// TODO: make this a fifo with more than one entry...
// Writes generate an interrupt, reads clear the interrupt
wire fifo_ce = (wb_adr_i[AW-1:$clog2(DW/8)] == 0);
always @(posedge clk)
	if (fifo_ce & wb_ack_o) begin
		if (wb_we_i) begin
			fifo_data_avail <= 1;
			fifo_reg <= wb_dat_i;
		end else begin
			fifo_data_avail <= 0;
		end
	end

wire status_ce = (wb_adr_i[AW-1:$clog2(DW/8)] == 1);
// Status reg
// [DW-1:2] Reserved
//      [1] FIFO full
//      [0] FIFO empty
assign status[1] = fifo_data_avail;
assign status[0] = !fifo_data_avail;

assign irq_o = fifo_data_avail;
assign wb_dat_o = fifo_ce ? fifo_reg : status;

endmodule