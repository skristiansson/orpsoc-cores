//////////////////////////////////////////////////////////////////////
//
// Eco32 SoC top for de0_nano board
//
// Based on the orpsoc version
// Copyright (C) 2013-2014 Stefan Kristiansson
//  <stefan.kristiansson@saunalahti.fi>
//
// Based on de1 board by
// Franck Jullien, franck.jullien@gmail.com
// Which probably was based on the or1200-generic board by
// Olof Kindgren, which in turn was based on orpsocv2 boards by
// Julius Baxter.
//
//////////////////////////////////////////////////////////////////////
//
// This source file may be used and distributed without
// restriction provided that this copyright statement is not
// removed from the file and that any derivative work contains
// the original copyright notice and the associated disclaimer.
//
// This source file is free software; you can redistribute it
// and/or modify it under the terms of the GNU Lesser General
// Public License as published by the Free Software Foundation;
// either version 2.1 of the License, or (at your option) any
// later version.
//
// This source is distributed in the hope that it will be
// useful, but WITHOUT ANY WARRANTY; without even the implied
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
// PURPOSE.  See the GNU Lesser General Public License for more
// details.
//
// You should have received a copy of the GNU Lesser General
// Public License along with this source; if not, download it
// from http://www.opencores.org/lgpl.shtml
//
//////////////////////////////////////////////////////////////////////

`include "config.vh"

module orpsoc_top #(
	parameter	rom0_aw = 6,
	parameter	uart0_aw = 3,
        parameter       HV1_SADR = 8'h45,
        parameter       i2c0_wb_adr_width = 3,
        parameter       i2c1_wb_adr_width = 3
)(
	input		sys_clk_pad_i,
	input		rst_n_pad_i,

`ifdef SIM
	output		tdo_pad_o,
	input		tms_pad_i,
	input		tck_pad_i,
	input		tdi_pad_i,
`endif

	output	[1:0]	sdram_ba_pad_o,
	output	[12:0]	sdram_a_pad_o,
	output		sdram_cs_n_pad_o,
	output		sdram_ras_pad_o,
	output		sdram_cas_pad_o,
	output		sdram_we_pad_o,
	inout	[15:0]	sdram_dq_pad_io,
	output	[1:0]	sdram_dqm_pad_o,
	output		sdram_cke_pad_o,
	output		sdram_clk_pad_o,

	input		uart0_srx_pad_i,
	output		uart0_stx_pad_o,

	inout	[7:0]	gpio0_io,

`ifdef I2C0
	inout		i2c0_sda_io,
	inout		i2c0_scl_io,
`endif
`ifdef I2C1
	inout		i2c1_sda_io,
	inout		i2c1_scl_io,
`endif

`ifdef SPI0
    output          spi0_sck_o,
    output          spi0_mosi_o,
    input           spi0_miso_i,
 `ifdef SPI0_SLAVE_SELECTS
    output          spi0_ss_o,
 `endif
`endif

`ifdef SPI1
    output          spi1_sck_o,
    output          spi1_mosi_o,
    input           spi1_miso_i,
 `ifdef SPI1_SLAVE_SELECTS
    output          spi1_ss_o,
 `endif
`endif

`ifdef SPI2
    output          spi2_sck_o,
    output          spi2_mosi_o,
    input           spi2_miso_i,
 `ifdef SPI2_SLAVE_SELECTS
    output          spi2_ss_o,
 `endif
`endif

    output          accelerometer_cs_o,
    input           accelerometer_irq_i
);

parameter	IDCODE_VALUE=32'h14951185;

// choose I2C operation mode
assign accelerometer_cs_o = 1;

////////////////////////////////////////////////////////////////////////
//
// Clock and reset generation module
//
////////////////////////////////////////////////////////////////////////

wire	async_rst;
wire	wb_clk, wb_rst;
wire	dbg_tck;
wire	sdram_clk;
wire	sdram_rst;

assign	sdram_clk_pad_o = sdram_clk;

clkgen clkgen0 (
	.sys_clk_pad_i	(sys_clk_pad_i),
	.rst_n_pad_i	(rst_n_pad_i),
	.async_rst_o	(async_rst),
	.wb_clk_o	(wb_clk),
	.wb_rst_o	(wb_rst),
`ifdef SIM
	.tck_pad_i	(tck_pad_i),
	.dbg_tck_o	(dbg_tck),
`endif
	.sdram_clk_o	(sdram_clk),
	.sdram_rst_o	(sdram_rst)
);

////////////////////////////////////////////////////////////////////////
//
// Modules interconnections
//
////////////////////////////////////////////////////////////////////////
`include "wb_intercon.vh"

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
// eco32 cpu
//
////////////////////////////////////////////////////////////////////////
wire [15:0]				eco32_irq;

eco32f #(
	.RESET_PC			(32'hc0000000)
) eco32f0 (
	// Instruction bus, clocks, reset
	.iwbm_adr_o			(wb_m2s_eco32_i_adr),
	.iwbm_dat_o			(wb_m2s_eco32_i_dat),
	.iwbm_sel_o			(wb_m2s_eco32_i_sel),
	.iwbm_we_o			(wb_m2s_eco32_i_we ),
	.iwbm_cyc_o			(wb_m2s_eco32_i_cyc),
	.iwbm_stb_o			(wb_m2s_eco32_i_stb),
	.iwbm_cti_o			(wb_m2s_eco32_i_cti),
	.iwbm_bte_o			(wb_m2s_eco32_i_bte),
	.iwbm_dat_i			(wb_s2m_eco32_i_dat),
	.iwbm_ack_i			(wb_s2m_eco32_i_ack),
	.iwbm_err_i			(wb_s2m_eco32_i_err),
	.iwbm_rty_i			(wb_s2m_eco32_i_rty),
	// Data bus, clocks, reset
	.dwbm_adr_o			(wb_m2s_eco32_d_adr),
	.dwbm_dat_o			(wb_m2s_eco32_d_dat),
	.dwbm_sel_o			(wb_m2s_eco32_d_sel),
	.dwbm_we_o			(wb_m2s_eco32_d_we),
	.dwbm_cyc_o			(wb_m2s_eco32_d_cyc),
	.dwbm_stb_o			(wb_m2s_eco32_d_stb),
	.dwbm_cti_o			(wb_m2s_eco32_d_cti),
	.dwbm_bte_o			(wb_m2s_eco32_d_bte),
	.dwbm_dat_i			(wb_s2m_eco32_d_dat),
	.dwbm_ack_i			(wb_s2m_eco32_d_ack),
	.dwbm_err_i			(wb_s2m_eco32_d_err),
	.dwbm_rty_i			(wb_s2m_eco32_d_rty),

	// Core clocks, resets
	.clk				(wb_clk),
	.rst				(wb_rst),

	// Interrupts
	.irq				(eco32_irq)
);

////////////////////////////////////////////////////////////////////////
//
// Debug Interface
//
////////////////////////////////////////////////////////////////////////

adbg_top dbg_if0 (
	// CPU interface
	.cpu0_clk_i	(wb_clk),
	.cpu0_rst_o	(),
	.cpu0_addr_o	(),
	.cpu0_data_o	(),
	.cpu0_stb_o	(),
	.cpu0_we_o	(),
	.cpu0_data_i	(32'b0),
	.cpu0_ack_i	(1'b1),
	.cpu0_stall_o	(),
	.cpu0_bp_i	(),

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
// SDRAM Memory Controller
//
////////////////////////////////////////////////////////////////////////

wire	[15:0]	sdram_dq_i;
wire	[15:0]	sdram_dq_o;
wire		sdram_dq_oe;

assign	sdram_dq_i = sdram_dq_pad_io;
assign	sdram_dq_pad_io = sdram_dq_oe ? sdram_dq_o : 16'bz;
assign	sdram_clk_pad_o = sdram_clk;

assign	wb_s2m_sdram_ibus_err = 0;
assign	wb_s2m_sdram_ibus_rty = 0;

assign	wb_s2m_sdram_dbus_err = 0;
assign	wb_s2m_sdram_dbus_rty = 0;

wb_sdram_ctrl #(
`ifndef SIM
	.TECHNOLOGY	("ALTERA"),
`endif
	.CLK_FREQ_MHZ	(100),	// sdram_clk freq in MHZ
	.POWERUP_DELAY	(200),	// power up delay in us
	.WB_PORTS	(2),	// Number of wishbone ports
	.ROW_WIDTH	(13),	// Row width
	.COL_WIDTH	(9),	// Column width
	.BA_WIDTH	(2),	// Ba width
	.tCAC		(2),	// CAS Latency
	.tRAC		(5),	// RAS Latency
	.tRP		(2),	// Command Period (PRE to ACT)
	.tRC		(7),	// Command Period (REF to REF / ACT to ACT)
	.tMRD		(2)	// Mode Register Set To Command Delay time
) wb_sdram_ctrl0 (
	// External SDRAM interface
	.ba_pad_o	(sdram_ba_pad_o[1:0]),
	.a_pad_o	(sdram_a_pad_o[12:0]),
	.cs_n_pad_o	(sdram_cs_n_pad_o),
	.ras_pad_o	(sdram_ras_pad_o),
	.cas_pad_o	(sdram_cas_pad_o),
	.we_pad_o	(sdram_we_pad_o),
	.dq_i		(sdram_dq_i[15:0]),
	.dq_o		(sdram_dq_o[15:0]),
	.dqm_pad_o	(sdram_dqm_pad_o[1:0]),
	.dq_oe		(sdram_dq_oe),
	.cke_pad_o	(sdram_cke_pad_o),
	.sdram_clk	(sdram_clk),
	.sdram_rst	(sdram_rst),

	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst),

	.wb_adr_i	({wb_m2s_sdram_ibus_adr, wb_m2s_sdram_dbus_adr}),
	.wb_stb_i	({wb_m2s_sdram_ibus_stb, wb_m2s_sdram_dbus_stb}),
	.wb_cyc_i	({wb_m2s_sdram_ibus_cyc, wb_m2s_sdram_dbus_cyc}),
	.wb_cti_i	({wb_m2s_sdram_ibus_cti, wb_m2s_sdram_dbus_cti}),
	.wb_bte_i	({wb_m2s_sdram_ibus_bte, wb_m2s_sdram_dbus_bte}),
	.wb_we_i	({wb_m2s_sdram_ibus_we,  wb_m2s_sdram_dbus_we }),
	.wb_sel_i	({wb_m2s_sdram_ibus_sel, wb_m2s_sdram_dbus_sel}),
	.wb_dat_i	({wb_m2s_sdram_ibus_dat, wb_m2s_sdram_dbus_dat}),
	.wb_dat_o	({wb_s2m_sdram_ibus_dat, wb_s2m_sdram_dbus_dat}),
	.wb_ack_o	({wb_s2m_sdram_ibus_ack, wb_s2m_sdram_dbus_ack})
);

////////////////////////////////////////////////////////////////////////
//
// UART0
//
////////////////////////////////////////////////////////////////////////
wire eco32_uart0_en = wb_m2s_uart0_cyc & wb_m2s_uart0_stb;
wire [7:0] eco32_uart0_data_in;
wire [7:0] eco32_uart0_data_out;
wire eco32_uart0_wt;
wire eco32_uart0_irq_r;
wire eco32_uart0_irq_t;

assign wb_s2m_uart0_ack = !eco32_uart0_wt & eco32_uart0_en;
assign wb_s2m_uart0_dat = {24'h0, eco32_uart0_data_out[7:0]};
assign eco32_uart0_data_in = wb_m2s_uart0_dat[7:0];

ser eco32_uart0 (
	.clk		(wb_clk),
	.reset		(wb_rst),
	.en		(eco32_uart0_en),
	.wr		(wb_m2s_uart0_we),
	.addr		(wb_m2s_uart0_adr[3:2]),
	.data_in	(eco32_uart0_data_in),
	.data_out	(eco32_uart0_data_out),
	.wt		(eco32_uart0_wt),
	.irq_r		(eco32_uart0_irq_r),
	.irq_t		(eco32_uart0_irq_t),
	.rxd		(uart0_srx_pad_i),
	.txd		(uart0_stx_pad_o)
);

////////////////////////////////////////////////////////////////////////////////
//
// ECO32 TIMER
//
////////////////////////////////////////////////////////////////////////////////

wire eco32_timer0_en = wb_m2s_timer0_cyc & wb_m2s_timer0_stb;
wire [31:0] eco32_timer0_data_in;
wire [31:0] eco32_timer0_data_out;
wire eco32_timer0_wt;
wire eco32_timer0_irq;

assign wb_s2m_timer0_ack = !eco32_timer0_wt & eco32_timer0_en;
assign wb_s2m_timer0_dat = eco32_timer0_data_out;
assign eco32_timer0_data_in = wb_m2s_timer0_dat;

tmr eco32_timer0 (
	.clk		(wb_clk),
	.reset		(wb_rst),
	.en		(eco32_timer0_en),
	.wr		(wb_m2s_timer0_we),
	.addr		(wb_m2s_timer0_adr[3:2]),
	.data_in	(eco32_timer0_data_in),
	.data_out	(eco32_timer0_data_out),
	.wt		(eco32_timer0_wt),
	.irq		(eco32_timer0_irq)
);

`ifdef I2C0
////////////////////////////////////////////////////////////////////////
//
// I2C controller 0
//
////////////////////////////////////////////////////////////////////////

//
// Wires
//
wire 		i2c0_irq;
wire 		scl0_pad_o;
wire 		scl0_padoen_o;
wire 		sda0_pad_o;
wire 		sda0_padoen_o;

wire [31:0]	wb8_m2s_i2c0_adr;
wire [1:0]	wb8_m2s_i2c0_bte;
wire [2:0]	wb8_m2s_i2c0_cti;
wire		wb8_m2s_i2c0_cyc;
wire [7:0]	wb8_m2s_i2c0_dat;
wire		wb8_m2s_i2c0_stb;
wire		wb8_m2s_i2c0_we;
wire [7:0] 	wb8_s2m_i2c0_dat;
wire		wb8_s2m_i2c0_ack;
wire		wb8_s2m_i2c0_err;
wire		wb8_s2m_i2c0_rty;

i2c_master_top #(
	.DEFAULT_SLAVE_ADDR	(HV1_SADR)
) i2c0 (
	.wb_clk_i		(wb_clk),
	.wb_rst_i		(wb_rst),
	.arst_i			(wb_rst),
	.wb_adr_i		(wb8_m2s_i2c0_adr[i2c0_wb_adr_width-1:0]),
	.wb_dat_i		(wb8_m2s_i2c0_dat),
	.wb_we_i		(wb8_m2s_i2c0_we),
	.wb_cyc_i		(wb8_m2s_i2c0_cyc),
	.wb_stb_i		(wb8_m2s_i2c0_stb),
	.wb_dat_o		(wb8_s2m_i2c0_dat),
	.wb_ack_o		(wb8_s2m_i2c0_ack),
	.scl_pad_i		(i2c0_scl_io),
	.scl_pad_o		(scl0_pad_o),
	.scl_padoen_o		(scl0_padoen_o),
	.sda_pad_i		(i2c0_sda_io),
	.sda_pad_o		(sda0_pad_o),
	.sda_padoen_o		(sda0_padoen_o),

	// Interrupt
	.wb_inta_o		(i2c0_irq)
);

assign wb8_s2m_i2c0_err = 0;
assign wb8_s2m_i2c0_rty = 0;

// i2c phy lines
assign i2c0_scl_io = scl0_padoen_o ? 1'bz : scl0_pad_o;
assign i2c0_sda_io = sda0_padoen_o ? 1'bz : sda0_pad_o;

// 32-bit to 8-bit wishbone bus resize
wb_data_resize wb_data_resize_i2c0 (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_i2c0_adr),
	.wbm_dat_i	(wb_m2s_i2c0_dat),
	.wbm_sel_i	(wb_m2s_i2c0_sel),
	.wbm_we_i	(wb_m2s_i2c0_we ),
	.wbm_cyc_i	(wb_m2s_i2c0_cyc),
	.wbm_stb_i	(wb_m2s_i2c0_stb),
	.wbm_cti_i	(wb_m2s_i2c0_cti),
	.wbm_bte_i	(wb_m2s_i2c0_bte),
	.wbm_dat_o	(wb_s2m_i2c0_dat),
	.wbm_ack_o	(wb_s2m_i2c0_ack),
	.wbm_err_o	(wb_s2m_i2c0_err),
	.wbm_rty_o	(wb_s2m_i2c0_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_i2c0_adr),
	.wbs_dat_o	(wb8_m2s_i2c0_dat),
	.wbs_we_o 	(wb8_m2s_i2c0_we ),
	.wbs_cyc_o	(wb8_m2s_i2c0_cyc),
	.wbs_stb_o	(wb8_m2s_i2c0_stb),
	.wbs_cti_o	(wb8_m2s_i2c0_cti),
	.wbs_bte_o	(wb8_m2s_i2c0_bte),
	.wbs_dat_i	(wb8_s2m_i2c0_dat),
	.wbs_ack_i	(wb8_s2m_i2c0_ack),
	.wbs_err_i	(wb8_s2m_i2c0_err),
	.wbs_rty_i	(wb8_s2m_i2c0_rty)
);

////////////////////////////////////////////////////////////////////////
`else // !`ifdef I2C0

assign wb8_s2m_i2c0_dat = 0;
assign wb8_s2m_i2c0_ack = 0;
assign wb8_s2m_i2c0_err = 0;
assign wb8_s2m_i2c0_rty = 0;

////////////////////////////////////////////////////////////////////////
`endif // !`ifdef I2C0

`ifdef I2C1
////////////////////////////////////////////////////////////////////////
//
// I2C controller 1
//
////////////////////////////////////////////////////////////////////////

//
// Wires
//
wire 		i2c1_irq;
wire 		scl1_pad_o;
wire 		scl1_padoen_o;
wire 		sda1_pad_o;
wire 		sda1_padoen_o;

wire [31:0]	wb8_m2s_i2c1_adr;
wire [1:0]	wb8_m2s_i2c1_bte;
wire [2:0]	wb8_m2s_i2c1_cti;
wire		wb8_m2s_i2c1_cyc;
wire [7:0]	wb8_m2s_i2c1_dat;
wire		wb8_m2s_i2c1_stb;
wire		wb8_m2s_i2c1_we;
wire [7:0] 	wb8_s2m_i2c1_dat;
wire		wb8_s2m_i2c1_ack;
wire		wb8_s2m_i2c1_err;
wire		wb8_s2m_i2c1_rty;

i2c_master_top
 #
 (
  .DEFAULT_SLAVE_ADDR(HV1_SADR)
 )
i2c1
  (
   .wb_clk_i			     (wb_clk),
   .wb_rst_i			     (wb_rst),
   .arst_i			     (wb_rst),
   .wb_adr_i			     (wb8_m2s_i2c1_adr[i2c1_wb_adr_width-1:0]),
   .wb_dat_i			     (wb8_m2s_i2c1_dat),
   .wb_we_i			     (wb8_m2s_i2c1_we),
   .wb_cyc_i			     (wb8_m2s_i2c1_cyc),
   .wb_stb_i			     (wb8_m2s_i2c1_stb),
   .wb_dat_o			     (wb8_s2m_i2c1_dat),
   .wb_ack_o			     (wb8_s2m_i2c1_ack),
   .scl_pad_i		     	     (i2c1_scl_io        ),
   .scl_pad_o			     (scl1_pad_o	 ),
   .scl_padoen_o		     (scl1_padoen_o	 ),
   .sda_pad_i			     (i2c1_sda_io 	 ),
   .sda_pad_o			     (sda1_pad_o	 ),
   .sda_padoen_o		     (sda1_padoen_o	 ),

   // Interrupt
   .wb_inta_o			     (i2c1_irq)

   );

assign wb8_s2m_i2c1_err = 0;
assign wb8_s2m_i2c1_rty = 0;

// i2c phy lines
assign i2c1_scl_io = scl1_padoen_o ? 1'bz : scl1_pad_o;
assign i2c1_sda_io = sda1_padoen_o ? 1'bz : sda1_pad_o;

// 32-bit to 8-bit wishbone bus resize
wb_data_resize wb_data_resize_i2c1 (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_i2c1_adr),
	.wbm_dat_i	(wb_m2s_i2c1_dat),
	.wbm_sel_i	(wb_m2s_i2c1_sel),
	.wbm_we_i	(wb_m2s_i2c1_we ),
	.wbm_cyc_i	(wb_m2s_i2c1_cyc),
	.wbm_stb_i	(wb_m2s_i2c1_stb),
	.wbm_cti_i	(wb_m2s_i2c1_cti),
	.wbm_bte_i	(wb_m2s_i2c1_bte),
	.wbm_dat_o	(wb_s2m_i2c1_dat),
	.wbm_ack_o	(wb_s2m_i2c1_ack),
	.wbm_err_o	(wb_s2m_i2c1_err),
	.wbm_rty_o	(wb_s2m_i2c1_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_i2c1_adr),
	.wbs_dat_o	(wb8_m2s_i2c1_dat),
	.wbs_we_o 	(wb8_m2s_i2c1_we ),
	.wbs_cyc_o	(wb8_m2s_i2c1_cyc),
	.wbs_stb_o	(wb8_m2s_i2c1_stb),
	.wbs_cti_o	(wb8_m2s_i2c1_cti),
	.wbs_bte_o	(wb8_m2s_i2c1_bte),
	.wbs_dat_i	(wb8_s2m_i2c1_dat),
	.wbs_ack_i	(wb8_s2m_i2c1_ack),
	.wbs_err_i	(wb8_s2m_i2c1_err),
	.wbs_rty_i	(wb8_s2m_i2c1_rty)
);

////////////////////////////////////////////////////////////////////////
`else // !`ifdef I2C1

assign wb8_s2m_i2c1_dat = 0;
assign wb8_s2m_i2c1_ack = 0;
assign wb8_s2m_i2c1_err = 0;
assign wb8_s2m_i2c1_rty = 0;

////////////////////////////////////////////////////////////////////////
`endif // !`ifdef I2C1

`ifdef SPI0
////////////////////////////////////////////////////////////////////////
//
// SPI0 controller
//
////////////////////////////////////////////////////////////////////////

//
// Wires
//
wire            spi0_irq;

wire [31:0]	wb8_m2s_spi0_adr;
wire [1:0]	wb8_m2s_spi0_bte;
wire [2:0]	wb8_m2s_spi0_cti;
wire		wb8_m2s_spi0_cyc;
wire [7:0]	wb8_m2s_spi0_dat;
wire		wb8_m2s_spi0_stb;
wire		wb8_m2s_spi0_we;
wire [7:0] 	wb8_s2m_spi0_dat;
wire		wb8_s2m_spi0_ack;
wire		wb8_s2m_spi0_err;
wire		wb8_s2m_spi0_rty;

//
// Assigns
//
assign  wbs_d_spi0_err_o = 0;
assign  wbs_d_spi0_rty_o = 0;
assign  spi0_hold_n_o = 1;
assign  spi0_w_n_o = 1;

simple_spi spi0(
	// Wishbone slave interface
	.clk_i	(wb_clk),
	.rst_i	(wb_rst),
	.adr_i	(wb8_m2s_spi0_adr[2:0]),
	.dat_i	(wb8_m2s_spi0_dat),
	.we_i	(wb8_m2s_spi0_we),
	.stb_i	(wb8_m2s_spi0_stb),
	.cyc_i	(wb8_m2s_spi0_cyc),
	.dat_o	(wb8_s2m_spi0_dat),
	.ack_o	(wb8_s2m_spi0_ack),

	// Outputs
	.inta_o		(spi0_irq),
	.sck_o		(spi0_sck_o),
 `ifdef SPI0_SLAVE_SELECTS
	.ss_o		(spi0_ss_o),
 `else
	.ss_o		(),
 `endif
	.mosi_o		(spi0_mosi_o),

	// Inputs
	.miso_i		(spi0_miso_i)
);

// 32-bit to 8-bit wishbone bus resize
wb_data_resize wb_data_resize_spi0 (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_spi0_adr),
	.wbm_dat_i	(wb_m2s_spi0_dat),
	.wbm_sel_i	(wb_m2s_spi0_sel),
	.wbm_we_i	(wb_m2s_spi0_we ),
	.wbm_cyc_i	(wb_m2s_spi0_cyc),
	.wbm_stb_i	(wb_m2s_spi0_stb),
	.wbm_cti_i	(wb_m2s_spi0_cti),
	.wbm_bte_i	(wb_m2s_spi0_bte),
	.wbm_dat_o	(wb_s2m_spi0_dat),
	.wbm_ack_o	(wb_s2m_spi0_ack),
	.wbm_err_o	(wb_s2m_spi0_err),
	.wbm_rty_o	(wb_s2m_spi0_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_spi0_adr),
	.wbs_dat_o	(wb8_m2s_spi0_dat),
	.wbs_we_o 	(wb8_m2s_spi0_we ),
	.wbs_cyc_o	(wb8_m2s_spi0_cyc),
	.wbs_stb_o	(wb8_m2s_spi0_stb),
	.wbs_cti_o	(wb8_m2s_spi0_cti),
	.wbs_bte_o	(wb8_m2s_spi0_bte),
	.wbs_dat_i	(wb8_s2m_spi0_dat),
	.wbs_ack_i	(wb8_s2m_spi0_ack),
	.wbs_err_i	(wb8_s2m_spi0_err),
	.wbs_rty_i	(wb8_s2m_spi0_rty)
);
`endif

`ifdef SPI1
////////////////////////////////////////////////////////////////////////
//
// SPI1 controller
//
////////////////////////////////////////////////////////////////////////

//
// Wires
//
wire            spi1_irq;

wire [31:0]	wb8_m2s_spi1_adr;
wire [1:0]	wb8_m2s_spi1_bte;
wire [2:0]	wb8_m2s_spi1_cti;
wire		wb8_m2s_spi1_cyc;
wire [7:0]	wb8_m2s_spi1_dat;
wire		wb8_m2s_spi1_stb;
wire		wb8_m2s_spi1_we;
wire [7:0] 	wb8_s2m_spi1_dat;
wire		wb8_s2m_spi1_ack;
wire		wb8_s2m_spi1_err;
wire		wb8_s2m_spi1_rty;

//
// Assigns
//
assign  wbs_d_spi1_err_o = 0;
assign  wbs_d_spi1_rty_o = 0;
assign  spi1_hold_n_o = 1;
assign  spi1_w_n_o = 1;

simple_spi spi1(
	// Wishbone slave interface
	.clk_i	(wb_clk),
	.rst_i	(wb_rst),
	.adr_i	(wb8_m2s_spi1_adr[2:0]),
	.dat_i	(wb8_m2s_spi1_dat),
	.we_i	(wb8_m2s_spi1_we),
	.stb_i	(wb8_m2s_spi1_stb),
	.cyc_i	(wb8_m2s_spi1_cyc),
	.dat_o	(wb8_s2m_spi1_dat),
	.ack_o	(wb8_s2m_spi1_ack),

	// Outputs
	.inta_o		(spi1_irq),
	.sck_o		(spi1_sck_o),
 `ifdef SPI1_SLAVE_SELECTS
	.ss_o		(spi1_ss_o),
 `else
	.ss_o		(),
 `endif
	.mosi_o		(spi1_mosi_o),

	// Inputs
	.miso_i		(spi1_miso_i)
);

// 32-bit to 8-bit wishbone bus resize
wb_data_resize wb_data_resize_spi1 (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_spi1_adr),
	.wbm_dat_i	(wb_m2s_spi1_dat),
	.wbm_sel_i	(wb_m2s_spi1_sel),
	.wbm_we_i	(wb_m2s_spi1_we ),
	.wbm_cyc_i	(wb_m2s_spi1_cyc),
	.wbm_stb_i	(wb_m2s_spi1_stb),
	.wbm_cti_i	(wb_m2s_spi1_cti),
	.wbm_bte_i	(wb_m2s_spi1_bte),
	.wbm_dat_o	(wb_s2m_spi1_dat),
	.wbm_ack_o	(wb_s2m_spi1_ack),
	.wbm_err_o	(wb_s2m_spi1_err),
	.wbm_rty_o	(wb_s2m_spi1_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_spi1_adr),
	.wbs_dat_o	(wb8_m2s_spi1_dat),
	.wbs_we_o 	(wb8_m2s_spi1_we ),
	.wbs_cyc_o	(wb8_m2s_spi1_cyc),
	.wbs_stb_o	(wb8_m2s_spi1_stb),
	.wbs_cti_o	(wb8_m2s_spi1_cti),
	.wbs_bte_o	(wb8_m2s_spi1_bte),
	.wbs_dat_i	(wb8_s2m_spi1_dat),
	.wbs_ack_i	(wb8_s2m_spi1_ack),
	.wbs_err_i	(wb8_s2m_spi1_err),
	.wbs_rty_i	(wb8_s2m_spi1_rty)
);
`endif

`ifdef SPI2
////////////////////////////////////////////////////////////////////////
//
// SPI2 controller
//
////////////////////////////////////////////////////////////////////////

//
// Wires
//
wire            spi2_irq;

wire [31:0]	wb8_m2s_spi2_adr;
wire [1:0]	wb8_m2s_spi2_bte;
wire [2:0]	wb8_m2s_spi2_cti;
wire		wb8_m2s_spi2_cyc;
wire [7:0]	wb8_m2s_spi2_dat;
wire		wb8_m2s_spi2_stb;
wire		wb8_m2s_spi2_we;
wire [7:0] 	wb8_s2m_spi2_dat;
wire		wb8_s2m_spi2_ack;
wire		wb8_s2m_spi2_err;
wire		wb8_s2m_spi2_rty;

//
// Assigns
//
assign  wbs_d_spi2_err_o = 0;
assign  wbs_d_spi2_rty_o = 0;
assign  spi2_hold_n_o = 1;
assign  spi2_w_n_o = 1;

simple_spi spi2(
	// Wishbone slave interface
	.clk_i	(wb_clk),
	.rst_i	(wb_rst),
	.adr_i	(wb8_m2s_spi2_adr[2:0]),
	.dat_i	(wb8_m2s_spi2_dat),
	.we_i	(wb8_m2s_spi2_we),
	.stb_i	(wb8_m2s_spi2_stb),
	.cyc_i	(wb8_m2s_spi2_cyc),
	.dat_o	(wb8_s2m_spi2_dat),
	.ack_o	(wb8_s2m_spi2_ack),

	// Outputs
	.inta_o		(spi2_irq),
	.sck_o		(spi2_sck_o),
 `ifdef SPI2_SLAVE_SELECTS
	.ss_o		(spi2_ss_o),
 `else
	.ss_o		(),
 `endif
	.mosi_o		(spi2_mosi_o),

	// Inputs
	.miso_i		(spi2_miso_i)
);

// 32-bit to 8-bit wishbone bus resize
wb_data_resize wb_data_resize_spi2 (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_spi2_adr),
	.wbm_dat_i	(wb_m2s_spi2_dat),
	.wbm_sel_i	(wb_m2s_spi2_sel),
	.wbm_we_i	(wb_m2s_spi2_we ),
	.wbm_cyc_i	(wb_m2s_spi2_cyc),
	.wbm_stb_i	(wb_m2s_spi2_stb),
	.wbm_cti_i	(wb_m2s_spi2_cti),
	.wbm_bte_i	(wb_m2s_spi2_bte),
	.wbm_dat_o	(wb_s2m_spi2_dat),
	.wbm_ack_o	(wb_s2m_spi2_ack),
	.wbm_err_o	(wb_s2m_spi2_err),
	.wbm_rty_o	(wb_s2m_spi2_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_spi2_adr),
	.wbs_dat_o	(wb8_m2s_spi2_dat),
	.wbs_we_o 	(wb8_m2s_spi2_we ),
	.wbs_cyc_o	(wb8_m2s_spi2_cyc),
	.wbs_stb_o	(wb8_m2s_spi2_stb),
	.wbs_cti_o	(wb8_m2s_spi2_cti),
	.wbs_bte_o	(wb8_m2s_spi2_bte),
	.wbs_dat_i	(wb8_s2m_spi2_dat),
	.wbs_ack_i	(wb8_s2m_spi2_ack),
	.wbs_err_i	(wb8_s2m_spi2_err),
	.wbs_rty_i	(wb8_s2m_spi2_rty)
);
`endif

////////////////////////////////////////////////////////////////////////
//
// GPIO 0
//
////////////////////////////////////////////////////////////////////////

wire [7:0]	gpio0_in;
wire [7:0]	gpio0_out;
wire [7:0]	gpio0_dir;

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
	for (i = 0; i < 8; i = i+1) begin: gpio0_tris
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
	.wb_adr_i	(wb8_m2s_gpio0_adr[0]),
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
	.wbm_dat_o	(wb_s2m_gpio0_dat),
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
	.wbs_dat_i	(wb8_s2m_gpio0_dat),
	.wbs_ack_i	(wb8_s2m_gpio0_ack),
	.wbs_err_i	(wb8_s2m_gpio0_err),
	.wbs_rty_i	(wb8_s2m_gpio0_rty)
);

////////////////////////////////////////////////////////////////////////
//
// Interrupt assignment
//
////////////////////////////////////////////////////////////////////////

assign eco32_irq[0] = eco32_uart0_irq_t;
assign eco32_irq[1] = eco32_uart0_irq_r;
assign eco32_irq[2] = 0;
assign eco32_irq[3] = 0;
assign eco32_irq[4] = 0;
assign eco32_irq[5] = 0;
assign eco32_irq[6] = 0;
assign eco32_irq[7] = 0;
assign eco32_irq[8] = 0;
assign eco32_irq[9] = 0;
assign eco32_irq[10] = 0;
assign eco32_irq[11] = 0;
assign eco32_irq[12] = 0;
assign eco32_irq[13] = 0;
assign eco32_irq[14] = eco32_timer0_irq;
assign eco32_irq[15] = 0;

endmodule
