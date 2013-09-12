//////////////////////////////////////////////////////////////////////
///                                                               ////
/// ORPSoC top for SoCKit board                                   ////
///                                                               ////
/// Instantiates modules, depending on ORPSoC defines file        ////
///                                                               ////
/// Copyright (C) 2013 Stefan Kristiansson                        ////
///  <stefan.kristiansson@saunalahti.fi                           ////
///                                                               ////
//////////////////////////////////////////////////////////////////////
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

`include "orpsoc-defines.v"

module orpsoc_top (
	input 		   sys_clk_pad_i,
	input 		   rst_n_pad_i,

`ifdef SIM
	output 		   tdo_pad_o,
	input 		   tms_pad_i,
	input 		   tck_pad_i,
	input 		   tdi_pad_i,
`endif

	inout [7:0] 	   gpio0_io,

	//
	// HPS I/O ports
	//

	// DDR3
	output wire [14:0] memory_mem_a,
	output wire [2:0]  memory_mem_ba,
	output wire 	   memory_mem_ck,
	output wire 	   memory_mem_ck_n,
	output wire 	   memory_mem_cke,
	output wire 	   memory_mem_cs_n,
	output wire 	   memory_mem_ras_n,
	output wire 	   memory_mem_cas_n,
	output wire 	   memory_mem_we_n,
	output wire 	   memory_mem_reset_n,
	inout wire [31:0]  memory_mem_dq,
	inout wire [3:0]   memory_mem_dqs,
	inout wire [3:0]   memory_mem_dqs_n,
	output wire 	   memory_mem_odt,
	output wire [3:0]  memory_mem_dm,
	input wire 	   memory_oct_rzqin,

	// Ethernet
	output wire 	   hps_io_hps_io_emac1_inst_TX_CLK,
	output wire 	   hps_io_hps_io_emac1_inst_TXD0,
	output wire 	   hps_io_hps_io_emac1_inst_TXD1,
	output wire 	   hps_io_hps_io_emac1_inst_TXD2,
	output wire 	   hps_io_hps_io_emac1_inst_TXD3,
	input wire 	   hps_io_hps_io_emac1_inst_RXD0,
	inout wire 	   hps_io_hps_io_emac1_inst_MDIO,
	output wire 	   hps_io_hps_io_emac1_inst_MDC,
	input wire 	   hps_io_hps_io_emac1_inst_RX_CTL,
	output wire 	   hps_io_hps_io_emac1_inst_TX_CTL,
	input wire 	   hps_io_hps_io_emac1_inst_RX_CLK,
	input wire 	   hps_io_hps_io_emac1_inst_RXD1,
	input wire 	   hps_io_hps_io_emac1_inst_RXD2,
	input wire 	   hps_io_hps_io_emac1_inst_RXD3,

	// Quad SPI
	inout wire 	   hps_io_hps_io_qspi_inst_IO0,
	inout wire 	   hps_io_hps_io_qspi_inst_IO1,
	inout wire 	   hps_io_hps_io_qspi_inst_IO2,
	inout wire 	   hps_io_hps_io_qspi_inst_IO3,
	output wire 	   hps_io_hps_io_qspi_inst_SS0,
	output wire 	   hps_io_hps_io_qspi_inst_CLK,

	// SD card, mmc
	inout wire 	   hps_io_hps_io_sdio_inst_CMD,
	inout wire 	   hps_io_hps_io_sdio_inst_D0,
	inout wire 	   hps_io_hps_io_sdio_inst_D1,
	output wire 	   hps_io_hps_io_sdio_inst_CLK,
	inout wire 	   hps_io_hps_io_sdio_inst_D2,
	inout wire 	   hps_io_hps_io_sdio_inst_D3,

	// USB
	inout wire 	   hps_io_hps_io_usb1_inst_D0,
	inout wire 	   hps_io_hps_io_usb1_inst_D1,
	inout wire 	   hps_io_hps_io_usb1_inst_D2,
	inout wire 	   hps_io_hps_io_usb1_inst_D3,
	inout wire 	   hps_io_hps_io_usb1_inst_D4,
	inout wire 	   hps_io_hps_io_usb1_inst_D5,
	inout wire 	   hps_io_hps_io_usb1_inst_D6,
	inout wire 	   hps_io_hps_io_usb1_inst_D7,
	input wire 	   hps_io_hps_io_usb1_inst_CLK,
	output wire 	   hps_io_hps_io_usb1_inst_STP,
	input wire 	   hps_io_hps_io_usb1_inst_DIR,
	input wire 	   hps_io_hps_io_usb1_inst_NXT,

	// SPI Master
	output wire 	   hps_io_hps_io_spim0_inst_CLK,
	output wire 	   hps_io_hps_io_spim0_inst_MOSI,
	input wire 	   hps_io_hps_io_spim0_inst_MISO,
	output wire 	   hps_io_hps_io_spim0_inst_SS0,
	output wire 	   hps_io_hps_io_spim1_inst_CLK,
	output wire 	   hps_io_hps_io_spim1_inst_MOSI,
	input wire 	   hps_io_hps_io_spim1_inst_MISO,
	output wire 	   hps_io_hps_io_spim1_inst_SS0,

	// UART
	input wire 	   hps_io_hps_io_uart0_inst_RX,
	output wire 	   hps_io_hps_io_uart0_inst_TX,

	// I2C
	inout wire 	   hps_io_hps_io_i2c1_inst_SDA,
	inout wire 	   hps_io_hps_io_i2c1_inst_SCL,

	// GPIO
	inout wire 	   hps_io_hps_io_gpio_inst_GPIO00,
	inout wire 	   hps_io_hps_io_gpio_inst_GPIO09,
	inout wire 	   hps_io_hps_io_gpio_inst_GPIO35,
	inout wire 	   hps_io_hps_io_gpio_inst_GPIO48,
	inout wire 	   hps_io_hps_io_gpio_inst_GPIO53,
	inout wire 	   hps_io_hps_io_gpio_inst_GPIO54,
	inout wire 	   hps_io_hps_io_gpio_inst_GPIO55,
	inout wire 	   hps_io_hps_io_gpio_inst_GPIO56,
	inout wire 	   hps_io_hps_io_gpio_inst_GPIO61,
	inout wire 	   hps_io_hps_io_gpio_inst_GPIO62
);

`include "orpsoc-params.v"

parameter	IDCODE_VALUE=32'h14951185;


////////////////////////////////////////////////////////////////////////
//
// Clock and reset generation module
//
////////////////////////////////////////////////////////////////////////

wire	async_rst;
wire	wb_clk, wb_rst;
wire	dbg_tck;

clkgen clkgen0 (
	.sys_clk_pad_i	(sys_clk_pad_i),
	.rst_n_pad_i	(rst_n_pad_i),
	.async_rst_o	(async_rst),
`ifdef SIM
	.tck_pad_i	(tck_pad_i),
	.dbg_tck_o	(dbg_tck),
`endif
	.wb_clk_o	(wb_clk),
	.wb_rst_o	(wb_rst)
);

////////////////////////////////////////////////////////////////////////
//
// Modules interconnections
//
////////////////////////////////////////////////////////////////////////

wire 			uart0_txd;
wire 			uart0_rxd;

wire [31:0]		wb_m2s_gpio0_adr;
wire [1:0]		wb_m2s_gpio0_bte;
wire [2:0]		wb_m2s_gpio0_cti;
wire			wb_m2s_gpio0_cyc;
wire [31:0]		wb_m2s_gpio0_dat;
wire [3:0]		wb_m2s_gpio0_sel;
wire			wb_m2s_gpio0_stb;
wire			wb_m2s_gpio0_we;
wire [31:0] 		wb_s2m_gpio0_dat;
wire			wb_s2m_gpio0_ack;
wire			wb_s2m_gpio0_err;
wire			wb_s2m_gpio0_rty;

wire [31:0]		wb_m2s_mem0_d_adr;
wire [1:0]		wb_m2s_mem0_d_bte;
wire [2:0]		wb_m2s_mem0_d_cti;
wire			wb_m2s_mem0_d_cyc;
wire [31:0]		wb_m2s_mem0_d_dat;
wire [3:0]		wb_m2s_mem0_d_sel;
wire			wb_m2s_mem0_d_stb;
wire			wb_m2s_mem0_d_we;
wire [31:0]		wb_s2m_mem0_d_dat;
wire			wb_s2m_mem0_d_ack;
wire			wb_s2m_mem0_d_err;
wire			wb_s2m_mem0_d_rty;


wire [31:0]		wb_m2s_mem0_i_adr;
wire [1:0]		wb_m2s_mem0_i_bte;
wire [2:0]		wb_m2s_mem0_i_cti;
wire			wb_m2s_mem0_i_cyc;
wire [31:0]		wb_m2s_mem0_i_dat;
wire [3:0]		wb_m2s_mem0_i_sel;
wire			wb_m2s_mem0_i_stb;
wire			wb_m2s_mem0_i_we;
wire [31:0]		wb_s2m_mem0_i_dat;
wire			wb_s2m_mem0_i_ack;
wire			wb_s2m_mem0_i_err;
wire			wb_s2m_mem0_i_rty;


wire [31:0]		wb_m2s_rom0_adr;
wire [1:0]		wb_m2s_rom0_bte;
wire [2:0]		wb_m2s_rom0_cti;
wire			wb_m2s_rom0_cyc;
wire [31:0]		wb_m2s_rom0_dat;
wire [3:0]		wb_m2s_rom0_sel;
wire			wb_m2s_rom0_stb;
wire			wb_m2s_rom0_we;
wire [31:0]		wb_s2m_rom0_dat;
wire			wb_s2m_rom0_ack;
wire			wb_s2m_rom0_err;
wire			wb_s2m_rom0_rty;


wire [31:0]		wb_m2s_uart0_adr;
wire [1:0]		wb_m2s_uart0_bte;
wire [2:0]		wb_m2s_uart0_cti;
wire			wb_m2s_uart0_cyc;
wire [31:0]		wb_m2s_uart0_dat;
wire [3:0]		wb_m2s_uart0_sel;
wire			wb_m2s_uart0_stb;
wire			wb_m2s_uart0_we;
wire [31:0] 		wb_s2m_uart0_dat;
wire			wb_s2m_uart0_ack;
wire			wb_s2m_uart0_err;
wire			wb_s2m_uart0_rty;


wire [31:0]		wb_m2s_dbg_adr;
wire [31:0]		wb_m2s_dbg_dat;
wire [3:0]		wb_m2s_dbg_sel;
wire			wb_m2s_dbg_we;
wire			wb_m2s_dbg_cyc;
wire			wb_m2s_dbg_stb;
wire [2:0]		wb_m2s_dbg_cti;
wire [1:0]		wb_m2s_dbg_bte;
wire			wb_s2m_dbg_ack;
wire [31:0]		wb_s2m_dbg_dat;
wire			wb_s2m_dbg_err;
wire			wb_s2m_dbg_rty;

wire [31:0]		wb_m2s_or1k_d_adr;
wire [31:0]		wb_m2s_or1k_d_dat;
wire [3:0]		wb_m2s_or1k_d_sel;
wire			wb_m2s_or1k_d_we;
wire			wb_m2s_or1k_d_cyc;
wire			wb_m2s_or1k_d_stb;
wire [2:0]		wb_m2s_or1k_d_cti;
wire [1:0]		wb_m2s_or1k_d_bte;
wire			wb_s2m_or1k_d_ack;
wire [31:0]		wb_s2m_or1k_d_dat;
wire			wb_s2m_or1k_d_err;
wire			wb_s2m_or1k_d_rty;

wire [31:0]		wb_m2s_or1k_i_adr;
wire [31:0]		wb_m2s_or1k_i_dat;
wire [3:0]		wb_m2s_or1k_i_sel;
wire			wb_m2s_or1k_i_we;
wire			wb_m2s_or1k_i_cyc;
wire			wb_m2s_or1k_i_stb;
wire [2:0]		wb_m2s_or1k_i_cti;
wire [1:0]		wb_m2s_or1k_i_bte;
wire			wb_s2m_or1k_i_ack;
wire [31:0]		wb_s2m_or1k_i_dat;
wire			wb_s2m_or1k_i_err;
wire			wb_s2m_or1k_i_rty;

/* wb_intercon AUTO_TEMPLATE (
	.wb_clk_i			(wb_clk),
	.wb_rst_i			(wb_rst),
);*/
wb_intercon wb_intercon0 (
	/*AUTOINST*/
	// Outputs
	.wb_s2m_or1k_i_dat		(wb_s2m_or1k_i_dat[31:0]),
	.wb_s2m_or1k_i_ack		(wb_s2m_or1k_i_ack),
	.wb_s2m_or1k_i_err		(wb_s2m_or1k_i_err),
	.wb_s2m_or1k_i_rty		(wb_s2m_or1k_i_rty),
	.wb_s2m_or1k_d_dat		(wb_s2m_or1k_d_dat[31:0]),
	.wb_s2m_or1k_d_ack		(wb_s2m_or1k_d_ack),
	.wb_s2m_or1k_d_err		(wb_s2m_or1k_d_err),
	.wb_s2m_or1k_d_rty		(wb_s2m_or1k_d_rty),
	.wb_s2m_dbg_dat			(wb_s2m_dbg_dat[31:0]),
	.wb_s2m_dbg_ack			(wb_s2m_dbg_ack),
	.wb_s2m_dbg_err			(wb_s2m_dbg_err),
	.wb_s2m_dbg_rty			(wb_s2m_dbg_rty),
	.wb_m2s_uart0_adr		(wb_m2s_uart0_adr[31:0]),
	.wb_m2s_uart0_dat		(wb_m2s_uart0_dat[31:0]),
	.wb_m2s_uart0_sel		(wb_m2s_uart0_sel[3:0]),
	.wb_m2s_uart0_we		(wb_m2s_uart0_we),
	.wb_m2s_uart0_cyc		(wb_m2s_uart0_cyc),
	.wb_m2s_uart0_stb		(wb_m2s_uart0_stb),
	.wb_m2s_uart0_cti		(wb_m2s_uart0_cti[2:0]),
	.wb_m2s_uart0_bte		(wb_m2s_uart0_bte[1:0]),
	.wb_m2s_gpio0_adr		(wb_m2s_gpio0_adr[31:0]),
	.wb_m2s_gpio0_dat		(wb_m2s_gpio0_dat[31:0]),
	.wb_m2s_gpio0_sel		(wb_m2s_gpio0_sel[3:0]),
	.wb_m2s_gpio0_we		(wb_m2s_gpio0_we),
	.wb_m2s_gpio0_cyc		(wb_m2s_gpio0_cyc),
	.wb_m2s_gpio0_stb		(wb_m2s_gpio0_stb),
	.wb_m2s_gpio0_cti		(wb_m2s_gpio0_cti[2:0]),
	.wb_m2s_gpio0_bte		(wb_m2s_gpio0_bte[1:0]),
	.wb_m2s_mem0_i_adr		(wb_m2s_mem0_i_adr[31:0]),
	.wb_m2s_mem0_i_dat		(wb_m2s_mem0_i_dat[31:0]),
	.wb_m2s_mem0_i_sel		(wb_m2s_mem0_i_sel[3:0]),
	.wb_m2s_mem0_i_we		(wb_m2s_mem0_i_we),
	.wb_m2s_mem0_i_cyc		(wb_m2s_mem0_i_cyc),
	.wb_m2s_mem0_i_stb		(wb_m2s_mem0_i_stb),
	.wb_m2s_mem0_i_cti		(wb_m2s_mem0_i_cti[2:0]),
	.wb_m2s_mem0_i_bte		(wb_m2s_mem0_i_bte[1:0]),
	.wb_m2s_mem0_d_adr		(wb_m2s_mem0_d_adr[31:0]),
	.wb_m2s_mem0_d_dat		(wb_m2s_mem0_d_dat[31:0]),
	.wb_m2s_mem0_d_sel		(wb_m2s_mem0_d_sel[3:0]),
	.wb_m2s_mem0_d_we		(wb_m2s_mem0_d_we),
	.wb_m2s_mem0_d_cyc		(wb_m2s_mem0_d_cyc),
	.wb_m2s_mem0_d_stb		(wb_m2s_mem0_d_stb),
	.wb_m2s_mem0_d_cti		(wb_m2s_mem0_d_cti[2:0]),
	.wb_m2s_mem0_d_bte		(wb_m2s_mem0_d_bte[1:0]),
	.wb_m2s_rom0_adr		(wb_m2s_rom0_adr[31:0]),
	.wb_m2s_rom0_dat		(wb_m2s_rom0_dat[31:0]),
	.wb_m2s_rom0_sel		(wb_m2s_rom0_sel[3:0]),
	.wb_m2s_rom0_we			(wb_m2s_rom0_we),
	.wb_m2s_rom0_cyc		(wb_m2s_rom0_cyc),
	.wb_m2s_rom0_stb		(wb_m2s_rom0_stb),
	.wb_m2s_rom0_cti		(wb_m2s_rom0_cti[2:0]),
	.wb_m2s_rom0_bte		(wb_m2s_rom0_bte[1:0]),
	// Inputs
	.wb_clk_i			(wb_clk),		 // Templated
	.wb_rst_i			(wb_rst),		 // Templated
	.wb_m2s_or1k_i_adr		(wb_m2s_or1k_i_adr[31:0]),
	.wb_m2s_or1k_i_dat		(wb_m2s_or1k_i_dat[31:0]),
	.wb_m2s_or1k_i_sel		(wb_m2s_or1k_i_sel[3:0]),
	.wb_m2s_or1k_i_we		(wb_m2s_or1k_i_we),
	.wb_m2s_or1k_i_cyc		(wb_m2s_or1k_i_cyc),
	.wb_m2s_or1k_i_stb		(wb_m2s_or1k_i_stb),
	.wb_m2s_or1k_i_cti		(wb_m2s_or1k_i_cti[2:0]),
	.wb_m2s_or1k_i_bte		(wb_m2s_or1k_i_bte[1:0]),
	.wb_m2s_or1k_d_adr		(wb_m2s_or1k_d_adr[31:0]),
	.wb_m2s_or1k_d_dat		(wb_m2s_or1k_d_dat[31:0]),
	.wb_m2s_or1k_d_sel		(wb_m2s_or1k_d_sel[3:0]),
	.wb_m2s_or1k_d_we		(wb_m2s_or1k_d_we),
	.wb_m2s_or1k_d_cyc		(wb_m2s_or1k_d_cyc),
	.wb_m2s_or1k_d_stb		(wb_m2s_or1k_d_stb),
	.wb_m2s_or1k_d_cti		(wb_m2s_or1k_d_cti[2:0]),
	.wb_m2s_or1k_d_bte		(wb_m2s_or1k_d_bte[1:0]),
	.wb_m2s_dbg_adr			(wb_m2s_dbg_adr[31:0]),
	.wb_m2s_dbg_dat			(wb_m2s_dbg_dat[31:0]),
	.wb_m2s_dbg_sel			(wb_m2s_dbg_sel[3:0]),
	.wb_m2s_dbg_we			(wb_m2s_dbg_we),
	.wb_m2s_dbg_cyc			(wb_m2s_dbg_cyc),
	.wb_m2s_dbg_stb			(wb_m2s_dbg_stb),
	.wb_m2s_dbg_cti			(wb_m2s_dbg_cti[2:0]),
	.wb_m2s_dbg_bte			(wb_m2s_dbg_bte[1:0]),
	.wb_s2m_uart0_dat		(wb_s2m_uart0_dat[31:0]),
	.wb_s2m_uart0_ack		(wb_s2m_uart0_ack),
	.wb_s2m_uart0_err		(wb_s2m_uart0_err),
	.wb_s2m_uart0_rty		(wb_s2m_uart0_rty),
	.wb_s2m_gpio0_dat		(wb_s2m_gpio0_dat[31:0]),
	.wb_s2m_gpio0_ack		(wb_s2m_gpio0_ack),
	.wb_s2m_gpio0_err		(wb_s2m_gpio0_err),
	.wb_s2m_gpio0_rty		(wb_s2m_gpio0_rty),
	.wb_s2m_mem0_i_dat		(wb_s2m_mem0_i_dat[31:0]),
	.wb_s2m_mem0_i_ack		(wb_s2m_mem0_i_ack),
	.wb_s2m_mem0_i_err		(wb_s2m_mem0_i_err),
	.wb_s2m_mem0_i_rty		(wb_s2m_mem0_i_rty),
	.wb_s2m_mem0_d_dat		(wb_s2m_mem0_d_dat[31:0]),
	.wb_s2m_mem0_d_ack		(wb_s2m_mem0_d_ack),
	.wb_s2m_mem0_d_err		(wb_s2m_mem0_d_err),
	.wb_s2m_mem0_d_rty		(wb_s2m_mem0_d_rty),
	.wb_s2m_rom0_dat		(wb_s2m_rom0_dat[31:0]),
	.wb_s2m_rom0_ack		(wb_s2m_rom0_ack),
	.wb_s2m_rom0_err		(wb_s2m_rom0_err),
	.wb_s2m_rom0_rty		(wb_s2m_rom0_rty)
);

`ifdef SIM
////////////////////////////////////////////////////////////////////////
//
// GENERIC JTAG TAP
//
////////////////////////////////////////////////////////////////////////

wire	dbg_if_select;
wire	dbg_if_tdo;
wire	jtag_tap_tdo;
wire	jtag_tap_shift_dr;
wire	jtag_tap_pause_dr;
wire	jtag_tap_update_dr;
wire	jtag_tap_capture_dr;

tap_top jtag_tap0 (
	.tdo_pad_o			(tdo_pad_o),
	.tms_pad_i			(tms_pad_i),
	.tck_pad_i			(dbg_tck),
	.trst_pad_i			(async_rst),
	.tdi_pad_i			(tdi_pad_i),

	.tdo_padoe_o			(tdo_padoe_o),

	.tdo_o				(jtag_tap_tdo),

	.shift_dr_o			(jtag_tap_shift_dr),
	.pause_dr_o			(jtag_tap_pause_dr),
	.update_dr_o			(jtag_tap_update_dr),
	.capture_dr_o			(jtag_tap_capture_dr),

	.extest_select_o		(),
	.sample_preload_select_o	(),
	.mbist_select_o			(),
	.debug_select_o			(dbg_if_select),


	.bs_chain_tdi_i			(1'b0),
	.mbist_tdi_i			(1'b0),
	.debug_tdi_i			(dbg_if_tdo)
);

`elsif ALTERA_JTAG_TAP
////////////////////////////////////////////////////////////////////////
//
// ALTERA Virtual JTAG TAP
//
////////////////////////////////////////////////////////////////////////

wire	dbg_if_select;
wire	dbg_if_tdo;
wire	jtag_tap_tdo;
wire	jtag_tap_shift_dr;
wire	jtag_tap_pause_dr;
wire	jtag_tap_update_dr;
wire	jtag_tap_capture_dr;

altera_virtual_jtag jtag_tap0 (
	.tck_o			(dbg_tck),
	.debug_tdo_i		(dbg_if_tdo),
	.tdi_o			(jtag_tap_tdo),
	.test_logic_reset_o	(),
	.run_test_idle_o	(),
	.shift_dr_o		(jtag_tap_shift_dr),
	.capture_dr_o		(jtag_tap_capture_dr),
	.pause_dr_o		(jtag_tap_pause_dr),
	.update_dr_o		(jtag_tap_update_dr),
	.debug_select_o		(dbg_if_select)
);
`endif
////////////////////////////////////////////////////////////////////////
//
// Hard Processor System (HPS)
//
////////////////////////////////////////////////////////////////////////

// Instantiate the qsys generated system.
sockit hps (
	.clk_clk(wb_clk),
	.reset_reset_n(!wb_rst),
	.memory_mem_a(memory_mem_a),
	.memory_mem_ba(memory_mem_ba),
	.memory_mem_ck(memory_mem_ck),
	.memory_mem_ck_n(memory_mem_ck_n),
	.memory_mem_cke(memory_mem_cke),
	.memory_mem_cs_n(memory_mem_cs_n),
	.memory_mem_ras_n(memory_mem_ras_n),
	.memory_mem_cas_n(memory_mem_cas_n),
	.memory_mem_we_n(memory_mem_we_n),
	.memory_mem_reset_n(memory_mem_reset_n),
	.memory_mem_dq(memory_mem_dq),
	.memory_mem_dqs(memory_mem_dqs),
	.memory_mem_dqs_n(memory_mem_dqs_n),
	.memory_mem_odt(memory_mem_odt),
	.memory_mem_dm(memory_mem_dm),
	.memory_oct_rzqin(memory_oct_rzqin),
	.hps_io_hps_io_emac1_inst_TX_CLK(hps_io_hps_io_emac1_inst_TX_CLK),
	.hps_io_hps_io_emac1_inst_TXD0(hps_io_hps_io_emac1_inst_TXD0),
	.hps_io_hps_io_emac1_inst_TXD1(hps_io_hps_io_emac1_inst_TXD1),
	.hps_io_hps_io_emac1_inst_TXD2(hps_io_hps_io_emac1_inst_TXD2),
	.hps_io_hps_io_emac1_inst_TXD3(hps_io_hps_io_emac1_inst_TXD3),
	.hps_io_hps_io_emac1_inst_RXD0(hps_io_hps_io_emac1_inst_RXD0),
	.hps_io_hps_io_emac1_inst_MDIO(hps_io_hps_io_emac1_inst_MDIO),
	.hps_io_hps_io_emac1_inst_MDC(hps_io_hps_io_emac1_inst_MDC),
	.hps_io_hps_io_emac1_inst_RX_CTL(hps_io_hps_io_emac1_inst_RX_CTL),
	.hps_io_hps_io_emac1_inst_TX_CTL(hps_io_hps_io_emac1_inst_TX_CTL),
	.hps_io_hps_io_emac1_inst_RX_CLK(hps_io_hps_io_emac1_inst_RX_CLK),
	.hps_io_hps_io_emac1_inst_RXD1(hps_io_hps_io_emac1_inst_RXD1),
	.hps_io_hps_io_emac1_inst_RXD2(hps_io_hps_io_emac1_inst_RXD2),
	.hps_io_hps_io_emac1_inst_RXD3(hps_io_hps_io_emac1_inst_RXD3),
	.hps_io_hps_io_qspi_inst_IO0(hps_io_hps_io_qspi_inst_IO0),
	.hps_io_hps_io_qspi_inst_IO1(hps_io_hps_io_qspi_inst_IO1),
	.hps_io_hps_io_qspi_inst_IO2(hps_io_hps_io_qspi_inst_IO2),
	.hps_io_hps_io_qspi_inst_IO3(hps_io_hps_io_qspi_inst_IO3),
	.hps_io_hps_io_qspi_inst_SS0(hps_io_hps_io_qspi_inst_SS0),
	.hps_io_hps_io_qspi_inst_CLK(hps_io_hps_io_qspi_inst_CLK),
	.hps_io_hps_io_sdio_inst_CMD(hps_io_hps_io_sdio_inst_CMD),
	.hps_io_hps_io_sdio_inst_D0(hps_io_hps_io_sdio_inst_D0),
	.hps_io_hps_io_sdio_inst_D1(hps_io_hps_io_sdio_inst_D1),
	.hps_io_hps_io_sdio_inst_CLK(hps_io_hps_io_sdio_inst_CLK),
	.hps_io_hps_io_sdio_inst_D2(hps_io_hps_io_sdio_inst_D2),
	.hps_io_hps_io_sdio_inst_D3(hps_io_hps_io_sdio_inst_D3),
	.hps_io_hps_io_usb1_inst_D0(hps_io_hps_io_usb1_inst_D0),
	.hps_io_hps_io_usb1_inst_D1(hps_io_hps_io_usb1_inst_D1),
	.hps_io_hps_io_usb1_inst_D2(hps_io_hps_io_usb1_inst_D2),
	.hps_io_hps_io_usb1_inst_D3(hps_io_hps_io_usb1_inst_D3),
	.hps_io_hps_io_usb1_inst_D4(hps_io_hps_io_usb1_inst_D4),
	.hps_io_hps_io_usb1_inst_D5(hps_io_hps_io_usb1_inst_D5),
	.hps_io_hps_io_usb1_inst_D6(hps_io_hps_io_usb1_inst_D6),
	.hps_io_hps_io_usb1_inst_D7(hps_io_hps_io_usb1_inst_D7),
	.hps_io_hps_io_usb1_inst_CLK(hps_io_hps_io_usb1_inst_CLK),
	.hps_io_hps_io_usb1_inst_STP(hps_io_hps_io_usb1_inst_STP),
	.hps_io_hps_io_usb1_inst_DIR(hps_io_hps_io_usb1_inst_DIR),
	.hps_io_hps_io_usb1_inst_NXT(hps_io_hps_io_usb1_inst_NXT),
	.hps_io_hps_io_spim0_inst_CLK(hps_io_hps_io_spim0_inst_CLK),
	.hps_io_hps_io_spim0_inst_MOSI(hps_io_hps_io_spim0_inst_MOSI),
	.hps_io_hps_io_spim0_inst_MISO(hps_io_hps_io_spim0_inst_MISO),
	.hps_io_hps_io_spim0_inst_SS0(hps_io_hps_io_spim0_inst_SS0),
	.hps_io_hps_io_spim1_inst_CLK(hps_io_hps_io_spim1_inst_CLK),
	.hps_io_hps_io_spim1_inst_MOSI(hps_io_hps_io_spim1_inst_MOSI),
	.hps_io_hps_io_spim1_inst_MISO(hps_io_hps_io_spim1_inst_MISO),
	.hps_io_hps_io_spim1_inst_SS0(hps_io_hps_io_spim1_inst_SS0),
	.hps_io_hps_io_uart0_inst_RX(hps_io_hps_io_uart0_inst_RX),
	.hps_io_hps_io_uart0_inst_TX(hps_io_hps_io_uart0_inst_TX),
	.hps_io_hps_io_i2c1_inst_SDA(hps_io_hps_io_i2c1_inst_SDA),
	.hps_io_hps_io_i2c1_inst_SCL(hps_io_hps_io_i2c1_inst_SCL),
	.hps_io_hps_io_gpio_inst_GPIO00(hps_io_hps_io_gpio_inst_GPIO00),
	.hps_io_hps_io_gpio_inst_GPIO09(hps_io_hps_io_gpio_inst_GPIO09),
	.hps_io_hps_io_gpio_inst_GPIO35(hps_io_hps_io_gpio_inst_GPIO35),
	.hps_io_hps_io_gpio_inst_GPIO48(hps_io_hps_io_gpio_inst_GPIO48),
	.hps_io_hps_io_gpio_inst_GPIO53(hps_io_hps_io_gpio_inst_GPIO53),
	.hps_io_hps_io_gpio_inst_GPIO54(hps_io_hps_io_gpio_inst_GPIO54),
	.hps_io_hps_io_gpio_inst_GPIO55(hps_io_hps_io_gpio_inst_GPIO55),
	.hps_io_hps_io_gpio_inst_GPIO56(hps_io_hps_io_gpio_inst_GPIO56),
	.hps_io_hps_io_gpio_inst_GPIO61(hps_io_hps_io_gpio_inst_GPIO61),
	.hps_io_hps_io_gpio_inst_GPIO62(hps_io_hps_io_gpio_inst_GPIO62),
	.hps_0_uart1_cts(1'b0),
	.hps_0_uart1_dsr(1'b0),
	.hps_0_uart1_dcd(1'b0),
	.hps_0_uart1_ri(1'b0),
	.hps_0_uart1_dtr(),
	.hps_0_uart1_rts(),
	.hps_0_uart1_out1_n(),
	.hps_0_uart1_out2_n(),
	.hps_0_uart1_rxd(uart0_txd),
	.hps_0_uart1_txd(uart0_rxd),
	.hps_0_emac0_phy_txd_o(),
	.hps_0_emac0_phy_txen_o(),
	.hps_0_emac0_phy_txer_o(),
	.hps_0_emac0_phy_rxdv_i(),
	.hps_0_emac0_phy_rxer_i(),
	.hps_0_emac0_phy_rxd_i(),
	.hps_0_emac0_phy_col_i(),
	.hps_0_emac0_phy_crs_i(),
	.hps_0_emac0_gmii_mdo_o(),
	.hps_0_emac0_gmii_mdo_o_e(),
	.hps_0_emac0_gmii_mdi_i(),
	.hps_0_emac0_ptp_pps_o(),
	.hps_0_emac0_ptp_aux_ts_trig_i(),
	.hps_0_emac0_md_clk_clk(),
	.hps_0_emac0_rx_clk_in_clk(),
	.hps_0_emac0_tx_clk_in_clk(),
	.hps_0_emac0_gtx_clk_clk(),
	.hps_0_emac0_tx_reset_reset_n(),
	.hps_0_emac0_rx_reset_reset_n(),
	.hps_0_emac_ptp_ref_clock_clk(),
	.clk_0_clk_reset_reset_n(),
	.hps_0_f2h_sdram0_data_address(),
	.hps_0_f2h_sdram0_data_burstcount(),
	.hps_0_f2h_sdram0_data_waitrequest(),
	.hps_0_f2h_sdram0_data_readdata(),
	.hps_0_f2h_sdram0_data_readdatavalid(),
	.hps_0_f2h_sdram0_data_read(),
	.hps_0_f2h_sdram0_data_writedata(),
	.hps_0_f2h_sdram0_data_byteenable(),
	.hps_0_f2h_sdram0_data_write(),
	.hps_0_f2h_cold_reset_req_reset_n(!wb_rst)
);

////////////////////////////////////////////////////////////////////////
//
// OR1K CPU
//
////////////////////////////////////////////////////////////////////////

wire	[31:0]	or1k_irq;

wire	[31:0]	or1k_dbg_dat_i;
wire	[31:0]	or1k_dbg_adr_i;
wire		or1k_dbg_we_i;
wire		or1k_dbg_stb_i;
wire		or1k_dbg_ack_o;
wire	[31:0]	or1k_dbg_dat_o;

wire		or1k_dbg_stall_i;
wire		or1k_dbg_ewt_i;
wire	[3:0]	or1k_dbg_lss_o;
wire	[1:0]	or1k_dbg_is_o;
wire	[10:0]	or1k_dbg_wp_o;
wire		or1k_dbg_bp_o;
wire		or1k_dbg_rst;

wire		sig_tick;

`ifdef OR1200
wire		or1k_rst;

assign	or1k_rst= wb_rst | or1k_dbg_rst;

or1200_top #(.boot_adr(32'hf0000100))
or1200_top0 (
	// Instruction bus, clocks, reset
	.iwb_clk_i			(wb_clk),
	.iwb_rst_i			(wb_rst),
	.iwb_ack_i			(wb_s2m_or1k_i_ack),
	.iwb_err_i			(wb_s2m_or1k_i_err),
	.iwb_rty_i			(wb_s2m_or1k_i_rty),
	.iwb_dat_i			(wb_s2m_or1k_i_dat),

	.iwb_cyc_o			(wb_m2s_or1k_i_cyc),
	.iwb_adr_o			(wb_m2s_or1k_i_adr),
	.iwb_stb_o			(wb_m2s_or1k_i_stb),
	.iwb_we_o			(wb_m2s_or1k_i_we),
	.iwb_sel_o			(wb_m2s_or1k_i_sel),
	.iwb_dat_o			(wb_m2s_or1k_i_dat),
	.iwb_cti_o			(wb_m2s_or1k_i_cti),
	.iwb_bte_o			(wb_m2s_or1k_i_bte),

	// Data bus, clocks, reset
	.dwb_clk_i			(wb_clk),
	.dwb_rst_i			(wb_rst),
	.dwb_ack_i			(wb_s2m_or1k_d_ack),
	.dwb_err_i			(wb_s2m_or1k_d_err),
	.dwb_rty_i			(wb_s2m_or1k_d_rty),
	.dwb_dat_i			(wb_s2m_or1k_d_dat),

	.dwb_cyc_o			(wb_m2s_or1k_d_cyc_i),
	.dwb_adr_o			(wb_m2s_or1k_d_adr_i),
	.dwb_stb_o			(wb_m2s_or1k_d_stb_i),
	.dwb_we_o			(wb_m2s_or1k_d_we_i),
	.dwb_sel_o			(wb_m2s_or1k_d_sel_i),
	.dwb_dat_o			(wb_m2s_or1k_d_dat_i),
	.dwb_cti_o			(wb_m2s_or1k_d_cti_i),
	.dwb_bte_o			(wb_m2s_or1k_d_bte_i),

	// Debug interface ports
	.dbg_stall_i			(or1k_dbg_stall_i),
	.dbg_ewt_i			(1'b0),
	.dbg_lss_o			(or1k_dbg_lss_o),
	.dbg_is_o			(or1k_dbg_is_o),
	.dbg_wp_o			(or1k_dbg_wp_o),
	.dbg_bp_o			(or1k_dbg_bp_o),

	.dbg_adr_i			(or1k_dbg_adr_i),
	.dbg_we_i			(or1k_dbg_we_i),
	.dbg_stb_i			(or1k_dbg_stb_i),
	.dbg_dat_i			(or1k_dbg_dat_i),
	.dbg_dat_o			(or1k_dbg_dat_o),
	.dbg_ack_o			(or1k_dbg_ack_o),

	.pm_clksd_o			(),
	.pm_dc_gate_o			(),
	.pm_ic_gate_o			(),
	.pm_dmmu_gate_o			(),
	.pm_immu_gate_o			(),
	.pm_tt_gate_o			(),
	.pm_cpu_gate_o			(),
	.pm_wakeup_o			(),
	.pm_lvolt_o			(),

	// Core clocks, resets
	.clk_i				(wb_clk),
	.rst_i				(or1k_rst),

	.clmode_i			(2'b00),

	// Interrupts
	.pic_ints_i			(or1k_irq}),
	.sig_tick			(sig_tick),

	.pm_cpustall_i			(1'b0)
);
`else // !`ifdef OR1200
mor1kx #(
	.FEATURE_DEBUGUNIT("ENABLED"),
	.FEATURE_CMOV("ENABLED"),
	.FEATURE_INSTRUCTIONCACHE("ENABLED"),
	.OPTION_ICACHE_BLOCK_WIDTH(5),
	.OPTION_ICACHE_SET_WIDTH(8),
	.OPTION_ICACHE_WAYS(2),
	.OPTION_ICACHE_LIMIT_WIDTH(32),
	.FEATURE_IMMU("ENABLED"),
	.FEATURE_DATACACHE("ENABLED"),
	.OPTION_DCACHE_BLOCK_WIDTH(5),
	.OPTION_DCACHE_SET_WIDTH(8),
	.OPTION_DCACHE_WAYS(2),
	.OPTION_DCACHE_LIMIT_WIDTH(31),
	.FEATURE_DMMU("ENABLED"),
	.OPTION_PIC_TRIGGER("LATCHED_LEVEL"),

	.IBUS_WB_TYPE("B3_REGISTERED_FEEDBACK"),
	.DBUS_WB_TYPE("B3_REGISTERED_FEEDBACK"),
	.OPTION_CPU0("CAPPUCCINO"),
	.OPTION_RESET_PC(32'hf0000100)
) mor1kx0 (
	.iwbm_adr_o(wb_m2s_or1k_i_adr),
	.iwbm_stb_o(wb_m2s_or1k_i_stb),
	.iwbm_cyc_o(wb_m2s_or1k_i_cyc),
	.iwbm_sel_o(wb_m2s_or1k_i_sel),
	.iwbm_we_o (wb_m2s_or1k_i_we),
	.iwbm_cti_o(wb_m2s_or1k_i_cti),
	.iwbm_bte_o(wb_m2s_or1k_i_bte),
	.iwbm_dat_o(wb_m2s_or1k_i_dat),

	.dwbm_adr_o(wb_m2s_or1k_d_adr),
	.dwbm_stb_o(wb_m2s_or1k_d_stb),
	.dwbm_cyc_o(wb_m2s_or1k_d_cyc),
	.dwbm_sel_o(wb_m2s_or1k_d_sel),
	.dwbm_we_o (wb_m2s_or1k_d_we ),
	.dwbm_cti_o(wb_m2s_or1k_d_cti),
	.dwbm_bte_o(wb_m2s_or1k_d_bte),
	.dwbm_dat_o(wb_m2s_or1k_d_dat),

	.clk(wb_clk),
	.rst(wb_rst),

	.iwbm_err_i(wb_s2m_or1k_i_err),
	.iwbm_ack_i(wb_s2m_or1k_i_ack),
	.iwbm_dat_i(wb_s2m_or1k_i_dat),
	.iwbm_rty_i(wb_s2m_or1k_i_rty),

	.dwbm_err_i(wb_s2m_or1k_d_err),
	.dwbm_ack_i(wb_s2m_or1k_d_ack),
	.dwbm_dat_i(wb_s2m_or1k_d_dat),
	.dwbm_rty_i(wb_s2m_or1k_d_rty),

	.irq_i(or1k_irq),

	.du_addr_i(or1k_dbg_adr_i[15:0]),
	.du_stb_i(or1k_dbg_stb_i),
	.du_dat_i(or1k_dbg_dat_i),
	.du_we_i(or1k_dbg_we_i),
	.du_dat_o(or1k_dbg_dat_o),
	.du_ack_o(or1k_dbg_ack_o),
	.du_stall_i(or1k_dbg_stall_i),
	.du_stall_o(or1k_dbg_bp_o)
);

`endif
////////////////////////////////////////////////////////////////////////
//
// Debug Interface
//
////////////////////////////////////////////////////////////////////////

adbg_top dbg_if0 (
	// OR1K interface
	.cpu0_clk_i	(wb_clk),
	.cpu0_rst_o	(or1k_dbg_rst),
	.cpu0_addr_o	(or1k_dbg_adr_i),
	.cpu0_data_o	(or1k_dbg_dat_i),
	.cpu0_stb_o	(or1k_dbg_stb_i),
	.cpu0_we_o	(or1k_dbg_we_i),
	.cpu0_data_i	(or1k_dbg_dat_o),
	.cpu0_ack_i	(or1k_dbg_ack_o),
	.cpu0_stall_o	(or1k_dbg_stall_i),
	.cpu0_bp_i	(or1k_dbg_bp_o),

	// TAP interface
	.tck_i		(dbg_tck),
	.tdi_i		(jtag_tap_tdo),
	.tdo_o		(dbg_if_tdo),
	.rst_i		(wb_rst),
	.capture_dr_i	(jtag_tap_capture_dr),
	.shift_dr_i	(jtag_tap_shift_dr),
	.pause_dr_i	(jtag_tap_pause_dr),
	.update_dr_i	(jtag_tap_update_dr),
	.debug_select_i	(dbg_if_select),

	// Wishbone debug master
	.wb_clk_i	(wb_clk),
	.wb_dat_i	(wb_s2m_dbg_dat),
	.wb_ack_i	(wb_s2m_dbg_ack),
	.wb_err_i	(wb_s2m_dbg_err),

	.wb_adr_o	(wb_m2s_dbg_adr),
	.wb_dat_o	(wb_m2s_dbg_dat),
	.wb_cyc_o	(wb_m2s_dbg_cyc),
	.wb_stb_o	(wb_m2s_dbg_stb),
	.wb_sel_o	(wb_m2s_dbg_sel),
	.wb_we_o	(wb_m2s_dbg_we),
	.wb_cti_o	(wb_m2s_dbg_cti),
	.wb_bte_o	(wb_m2s_dbg_bte)
);

////////////////////////////////////////////////////////////////////////
//
// ROM
//
////////////////////////////////////////////////////////////////////////

assign	wb_s2m_rom0_err = 1'b0;
assign	wb_s2m_rom0_rty = 1'b0;

`ifdef BOOTROM
rom #(.addr_width(rom0_aw))
rom0 (
	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst),
	.wb_adr_i	(wb_m2s_rom0_adr[(rom0_aw + 2) - 1 : 2]),
	.wb_cyc_i	(wb_m2s_rom0_cyc),
	.wb_stb_i	(wb_m2s_rom0_stb),
	.wb_cti_i	(wb_m2s_rom0_cti),
	.wb_bte_i	(wb_m2s_rom0_bte),
	.wb_dat_o	(wb_s2m_rom0_dat),
	.wb_ack_o	(wb_s2m_rom0_ack)
);
`else
assign	wb_s2m_rom0_dat_o = 0;
assign	wb_s2m_rom0_ack_o = 0;
`endif

////////////////////////////////////////////////////////////////////////
//
// Internal SRAM
//
////////////////////////////////////////////////////////////////////////

ram_wb #(
	.aw(wb_aw),
	.dw(wb_dw),
	.mem_size_bytes(65536), // 64KB
	.mem_adr_width($clog2(65536))
) ram_wb0 (
	// Wishbone slave interface 0
	.wbm0_dat_i		(wb_m2s_mem0_i_dat),
	.wbm0_adr_i		(wb_m2s_mem0_i_adr),
	.wbm0_sel_i		(wb_m2s_mem0_i_sel),
	.wbm0_cti_i		(wb_m2s_mem0_i_cti),
	.wbm0_bte_i		(wb_m2s_mem0_i_bte),
	.wbm0_we_i		(wb_m2s_mem0_i_we),
	.wbm0_cyc_i		(wb_m2s_mem0_i_cyc),
	.wbm0_stb_i		(wb_m2s_mem0_i_stb),
	.wbm0_dat_o		(wb_s2m_mem0_i_dat),
	.wbm0_ack_o		(wb_s2m_mem0_i_ack),
	.wbm0_err_o		(wb_s2m_mem0_i_err),
	.wbm0_rty_o		(wb_s2m_mem0_i_rty),
	// Wishbone slave interface 1
	.wbm1_dat_i		(wb_m2s_mem0_d_dat),
	.wbm1_adr_i		(wb_m2s_mem0_d_adr),
	.wbm1_sel_i		(wb_m2s_mem0_d_sel),
	.wbm1_cti_i		(wb_m2s_mem0_d_cti),
	.wbm1_bte_i		(wb_m2s_mem0_d_bte),
	.wbm1_we_i		(wb_m2s_mem0_d_we),
	.wbm1_cyc_i		(wb_m2s_mem0_d_cyc),
	.wbm1_stb_i		(wb_m2s_mem0_d_stb),
	.wbm1_dat_o		(wb_s2m_mem0_d_dat),
	.wbm1_ack_o		(wb_s2m_mem0_d_ack),
	.wbm1_err_o		(wb_s2m_mem0_d_err),
	.wbm1_rty_o		(wb_s2m_mem0_d_rty),
	// Wishbone slave interface 2
	.wbm2_dat_i		(32'd0),
	.wbm2_adr_i		(32'd0),
	.wbm2_sel_i		(4'd0),
	.wbm2_cti_i		(3'd0),
	.wbm2_bte_i		(2'd0),
	.wbm2_we_i		(1'd0),
	.wbm2_cyc_i		(1'd0),
	.wbm2_stb_i		(1'd0),
	.wbm2_dat_o		(),
	.wbm2_ack_o		(),
	.wbm2_err_o		(),
	.wbm2_rty_o		(),
	// Clock, reset
	.wb_clk_i		(wb_clk),
	.wb_rst_i		(wb_rst)
);

////////////////////////////////////////////////////////////////////////
//
// UART0
//
////////////////////////////////////////////////////////////////////////

wire	uart0_irq;

wire [31:0]	wb8_m2s_uart0_adr;
wire [1:0]	wb8_m2s_uart0_bte;
wire [2:0]	wb8_m2s_uart0_cti;
wire		wb8_m2s_uart0_cyc;
wire [7:0]	wb8_m2s_uart0_dat;
wire		wb8_m2s_uart0_stb;
wire		wb8_m2s_uart0_we;
wire [7:0] 	wb8_s2m_uart0_dat;
wire		wb8_s2m_uart0_ack;
wire		wb8_s2m_uart0_err;
wire		wb8_s2m_uart0_rty;

assign	wb8_s2m_uart0_err = 0;
assign	wb8_s2m_uart0_rty = 0;

uart_top uart16550_0 (
	// Wishbone slave interface
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),
	.wb_adr_i	(wb8_m2s_uart0_adr[uart0_aw-1:0]),
	.wb_dat_i	(wb8_m2s_uart0_dat),
	.wb_we_i	(wb8_m2s_uart0_we),
	.wb_stb_i	(wb8_m2s_uart0_stb),
	.wb_cyc_i	(wb8_m2s_uart0_cyc),
	.wb_sel_i	(4'b0), // Not used in 8-bit mode
	.wb_dat_o	(wb8_s2m_uart0_dat),
	.wb_ack_o	(wb8_s2m_uart0_ack),

	// Outputs
	.int_o		(uart0_irq),
	.stx_pad_o	(uart0_txd),
	.rts_pad_o	(),
	.dtr_pad_o	(),

	// Inputs
	.srx_pad_i	(uart0_rxd),
	.cts_pad_i	(1'b0),
	.dsr_pad_i	(1'b0),
	.ri_pad_i	(1'b0),
	.dcd_pad_i	(1'b0)
);

// 32-bit to 8-bit wishbone bus resize
wb_data_resize wb_data_resize_uart0 (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_uart0_adr),
	.wbm_dat_i	(wb_m2s_uart0_dat),
	.wbm_sel_i	(wb_m2s_uart0_sel),
	.wbm_we_i	(wb_m2s_uart0_we ),
	.wbm_cyc_i	(wb_m2s_uart0_cyc),
	.wbm_stb_i	(wb_m2s_uart0_stb),
	.wbm_cti_i	(wb_m2s_uart0_cti),
	.wbm_bte_i	(wb_m2s_uart0_bte),
	.wbm_sdt_o	(wb_s2m_uart0_dat),
	.wbm_ack_o	(wb_s2m_uart0_ack),
	.wbm_err_o	(wb_s2m_uart0_err),
	.wbm_rty_o	(wb_s2m_uart0_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_uart0_adr),
	.wbs_dat_o	(wb8_m2s_uart0_dat),
	.wbs_we_o 	(wb8_m2s_uart0_we ),
	.wbs_cyc_o	(wb8_m2s_uart0_cyc),
	.wbs_stb_o	(wb8_m2s_uart0_stb),
	.wbs_cti_o	(wb8_m2s_uart0_cti),
	.wbs_bte_o	(wb8_m2s_uart0_bte),
	.wbs_sdt_i	(wb8_s2m_uart0_dat),
	.wbs_ack_i	(wb8_s2m_uart0_ack),
	.wbs_err_i	(wb8_s2m_uart0_err),
	.wbs_rty_i	(wb8_s2m_uart0_rty)
);

////////////////////////////////////////////////////////////////////////
//
// GPIO 0
//
////////////////////////////////////////////////////////////////////////

localparam gpio0_io_width = 8;

wire [gpio0_io_width-1:0] gpio0_in;
wire [gpio0_io_width-1:0] gpio0_out;
wire [gpio0_io_width-1:0] gpio0_dir;

wire [31:0]	wb8_m2s_gpio0_adr;
wire [1:0]	wb8_m2s_gpio0_bte;
wire [2:0]	wb8_m2s_gpio0_cti;
wire		wb8_m2s_gpio0_cyc;
wire [7:0]	wb8_m2s_gpio0_dat;
wire		wb8_m2s_gpio0_stb;
wire		wb8_m2s_gpio0_we;
wire [7:0] 	wb8_s2m_gpio0_dat;
wire		wb8_s2m_gpio0_ack;
wire		wb8_s2m_gpio0_err;
wire		wb8_s2m_gpio0_rty;

// Tristate logic for IO
// 0 = input, 1 = output
genvar                    i;
generate
	for (i = 0; i < gpio0_io_width; i = i+1) begin: gpio0_tris
		assign gpio0_io[i] = gpio0_dir[i] ? gpio0_out[i] : 1'bz;
		assign gpio0_in[i] = gpio0_dir[i] ? gpio0_out[i] : gpio0_io[i];
	end
endgenerate

gpio gpio0 (
	// GPIO bus
	.gpio_i		(gpio0_in),
	.gpio_o		(gpio0_out),
	.gpio_dir_o	(gpio0_dir),
	// Wishbone slave interface
	.wb_adr_i	(wb8_m2s_gpio0_adr[gpio_addr_width-1:0]),
	.wb_dat_i	(wb8_m2s_gpio0_dat),
	.wb_we_i	(wb8_m2s_gpio0_we),
	.wb_cyc_i	(wb8_m2s_gpio0_cyc),
	.wb_stb_i	(wb8_m2s_gpio0_stb),
	.wb_cti_i	(wb8_m2s_gpio0_cti),
	.wb_bte_i	(wb8_m2s_gpio0_bte),
	.wb_dat_o	(wb8_s2m_gpio0_dat),
	.wb_ack_o	(wb8_s2m_gpio0_ack),
	.wb_err_o	(wb8_s2m_gpio0_err),
	.wb_rty_o	(wb8_s2m_gpio0_rty),

	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst)
);

// 32-bit to 8-bit wishbone bus resize
wb_data_resize wb_data_resize_gpio0 (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_gpio0_adr),
	.wbm_dat_i	(wb_m2s_gpio0_dat),
	.wbm_sel_i	(wb_m2s_gpio0_sel),
	.wbm_we_i	(wb_m2s_gpio0_we ),
	.wbm_cyc_i	(wb_m2s_gpio0_cyc),
	.wbm_stb_i	(wb_m2s_gpio0_stb),
	.wbm_cti_i	(wb_m2s_gpio0_cti),
	.wbm_bte_i	(wb_m2s_gpio0_bte),
	.wbm_sdt_o	(wb_s2m_gpio0_dat),
	.wbm_ack_o	(wb_s2m_gpio0_ack),
	.wbm_err_o	(wb_s2m_gpio0_err),
	.wbm_rty_o	(wb_s2m_gpio0_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_gpio0_adr),
	.wbs_dat_o	(wb8_m2s_gpio0_dat),
	.wbs_we_o	(wb8_m2s_gpio0_we ),
	.wbs_cyc_o	(wb8_m2s_gpio0_cyc),
	.wbs_stb_o	(wb8_m2s_gpio0_stb),
	.wbs_cti_o	(wb8_m2s_gpio0_cti),
	.wbs_bte_o	(wb8_m2s_gpio0_bte),
	.wbs_sdt_i	(wb8_s2m_gpio0_dat),
	.wbs_ack_i	(wb8_s2m_gpio0_ack),
	.wbs_err_i	(wb8_s2m_gpio0_err),
	.wbs_rty_i	(wb8_s2m_gpio0_rty)
);

////////////////////////////////////////////////////////////////////////
//
// Interrupt assignment
//
////////////////////////////////////////////////////////////////////////

assign or1k_irq[0] = 0; // Non-maskable inside OR1K
assign or1k_irq[1] = 0; // Non-maskable inside OR1K
assign or1k_irq[2] = uart0_irq;
assign or1k_irq[3] = 0;
assign or1k_irq[4] = 0;
assign or1k_irq[5] = 0;
assign or1k_irq[6] = 0;
assign or1k_irq[7] = 0;
assign or1k_irq[8] = 0;
assign or1k_irq[9] = 0;
assign or1k_irq[10] = 0;
assign or1k_irq[11] = 0;
assign or1k_irq[12] = 0;
assign or1k_irq[13] = 0;
assign or1k_irq[14] = 0;
assign or1k_irq[15] = 0;
assign or1k_irq[16] = 0;
assign or1k_irq[17] = 0;
assign or1k_irq[18] = 0;
assign or1k_irq[19] = 0;
assign or1k_irq[20] = 0;
assign or1k_irq[21] = 0;
assign or1k_irq[22] = 0;
assign or1k_irq[23] = 0;
assign or1k_irq[24] = 0;
assign or1k_irq[25] = 0;
assign or1k_irq[26] = 0;
assign or1k_irq[27] = 0;
assign or1k_irq[28] = 0;
assign or1k_irq[29] = 0;
assign or1k_irq[30] = 0;
assign or1k_irq[31] = 0;

endmodule // orpsoc_top
