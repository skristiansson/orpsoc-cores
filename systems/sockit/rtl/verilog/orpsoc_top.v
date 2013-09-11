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

// CPU instruction bus wires
wire	[wb_aw-1:0]	wb_cpu_i_adr;
wire	[wb_dw-1:0]	wb_cpu_i_dat;
wire	[3:0]		wb_cpu_i_sel;
wire			wb_cpu_i_we;
wire			wb_cpu_i_cyc;
wire			wb_cpu_i_stb;
wire	[2:0]		wb_cpu_i_cti;
wire	[1:0]		wb_cpu_i_bte;

wire	[wb_dw-1:0]	wb_cpu_i_sdt;
wire			wb_cpu_i_ack;
wire			wb_cpu_i_err;
wire			wb_cpu_i_rty;

// CPU data bus wires
wire	[wb_aw-1:0]	wb_cpu_d_adr;
wire	[wb_dw-1:0]	wb_cpu_d_dat;
wire	[3:0] 		wb_cpu_d_sel;
wire			wb_cpu_d_we;
wire			wb_cpu_d_cyc;
wire			wb_cpu_d_stb;
wire	[2:0]		wb_cpu_d_cti;
wire	[1:0]		wb_cpu_d_bte;

wire	[wb_dw-1:0]	wb_cpu_d_sdt;
wire			wb_cpu_d_ack;
wire			wb_cpu_d_err;
wire			wb_cpu_d_rty;

// Debug interface bus wires
wire	[wb_aw-1:0]	wb_dbg_adr;
wire	[wb_dw-1:0]	wb_dbg_dat;
wire	[3:0]		wb_dbg_sel;
wire			wb_dbg_we;
wire			wb_dbg_cyc;
wire			wb_dbg_stb;
wire	[2:0]		wb_dbg_cti;
wire	[1:0]		wb_dbg_bte;

wire	[wb_dw-1:0]	wb_dbg_sdt;
wire			wb_dbg_ack;
wire			wb_dbg_err;
wire			wb_dbg_rty;

wire	[wb_aw-1:0]	wbm_dbus_adr;
wire	[wb_dw-1:0]	wbm_dbus_dat;
wire	[3:0]		wbm_dbus_sel;
wire			wbm_dbus_we;
wire			wbm_dbus_cyc;
wire			wbm_dbus_stb;
wire	[2:0]		wbm_dbus_cti;
wire	[1:0]		wbm_dbus_bte;

wire	[wb_dw-1:0]	wbm_dbus_sdt;
wire			wbm_dbus_ack;
wire			wbm_dbus_err;
wire			wbm_dbus_rty;

// Byte bus bridge master signals
wire	[wb_dw-1:0]	wb_bbus_sdt;
wire			wb_bbus_ack;
wire			wb_bbus_err;
wire			wb_bbus_rty;

// Instruction bus slave wires //

// rom0 instruction bus wires
wire	[31:0]		wb_rom0_sdt;
wire			wb_rom0_ack;
wire			wb_rom0_err;
wire			wb_rom0_rty;
// mc0 instruction bus wires
wire	[31:0]		wb_mc0_ibus_sdt;
wire			wb_mc0_ibus_ack;
wire			wb_mc0_ibus_err;
wire			wb_mc0_ibus_rty;
// mc0 data bus wires
wire	[31:0]		wb_mc0_dbus_sdt;
wire			wb_mc0_dbus_ack;
wire			wb_mc0_dbus_err;
wire			wb_mc0_dbus_rty;

// Data bus slave wires //

// uart0 wires
wire	[7:0]		wb_uart_sdt;
wire			wb_uart_ack;
wire			wb_uart_err;
wire			wb_uart_rty;
wire			uart0_rxd;
wire			uart0_txd;

// intgen wires
wire	[7:0]		wb_intgen_sdt;
wire			wb_intgen_ack;
wire			wb_intgen_err;
wire			wb_intgen_rty;
// gpio wires
wire	[7:0]		wb_gpio_sdt;
wire			wb_gpio_ack;
wire			wb_gpio_err;
wire			wb_gpio_rty;

//
// Wishbone instruction address decoder
//

// 0x00000000 to 0xefffffff is mapped to the SDRAM
// 0xf0000000 to 0xffffffff is mapped to the ROM
wire	[ibus_slaves-1:0] ibus_slave_sel =
		{wb_cpu_i_adr[31:28] != 4'hf,
		wb_cpu_i_adr[31:28] == 4'hf};

wire	[31:0]			wb_ibus_adr;
wire	[31:0]			wb_ibus_dat;
wire	[3:0]			wb_ibus_sel;
wire				wb_ibus_we;
wire	[ibus_slaves-1:0]	wb_ibus_cyc;
wire				wb_ibus_stb;
wire	[2:0] 			wb_ibus_cti;
wire	[1:0] 			wb_ibus_bte;

wb_mux #(.num_slaves(ibus_slaves))
wb_mux_ibus (
	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst),
	.slave_sel_i	(ibus_slave_sel),
	// Master Interface
	.wbm_adr_i	(wb_cpu_i_adr),
	.wbm_dat_i	(wb_cpu_i_dat),
	.wbm_sel_i	(wb_cpu_i_sel),
	.wbm_we_i	(wb_cpu_i_we),
	.wbm_cyc_i	(wb_cpu_i_cyc),
	.wbm_stb_i	(wb_cpu_i_stb),
	.wbm_cti_i	(wb_cpu_i_cti),
	.wbm_bte_i	(wb_cpu_i_bte),
	.wbm_sdt_o	(wb_cpu_i_sdt),
	.wbm_ack_o	(wb_cpu_i_ack),
	.wbm_err_o	(wb_cpu_i_err),
	.wbm_rty_o	(wb_cpu_i_rty),
	//Slave interface
	.wbs_adr_o	(wb_ibus_adr),
	.wbs_dat_o	(wb_ibus_dat),
	.wbs_sel_o	(wb_ibus_sel),
	.wbs_we_o	(wb_ibus_we),
	.wbs_cyc_o	(wb_ibus_cyc),
	.wbs_stb_o	(wb_ibus_stb),
	.wbs_cti_o	(wb_ibus_cti),
	.wbs_bte_o	(wb_ibus_bte),
	.wbs_sdt_i	({wb_mc0_ibus_sdt, wb_rom0_sdt}),
	.wbs_ack_i	({wb_mc0_ibus_ack, wb_rom0_ack}),
	.wbs_err_i	({wb_mc0_ibus_err, wb_rom0_err}),
	.wbs_rty_i	({wb_mc0_ibus_rty, wb_rom0_rty})
);

//
// Wishbone data bus arbiter
//

parameter num_d_masters = 2;

wire	[31:0]			wb_dbus_adr;
wire	[31:0]			wb_dbus_dat;
wire	[3:0]			wb_dbus_sel;
wire				wb_dbus_we;
wire	[num_d_masters-1:0]	wb_dbus_cyc;
wire				wb_dbus_stb;
wire	[2:0]			wb_dbus_cti;
wire	[1:0]			wb_dbus_bte;

wb_arbiter #(.num_masters(num_d_masters))
wb_arbiter_dbus (
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),
	// Master Interface
	.wbm_adr_i	({wb_dbg_adr, wb_cpu_d_adr}),
	.wbm_dat_i	({wb_dbg_dat, wb_cpu_d_dat}),
	.wbm_sel_i	({wb_dbg_sel, wb_cpu_d_sel}),
	.wbm_we_i	({wb_dbg_we , wb_cpu_d_we }),
	.wbm_cyc_i	({wb_dbg_cyc, wb_cpu_d_cyc}),
	.wbm_stb_i	({wb_dbg_stb, wb_cpu_d_stb}),
	.wbm_cti_i	({wb_dbg_cti, wb_cpu_d_cti}),
	.wbm_bte_i	({wb_dbg_bte, wb_cpu_d_bte}),
	.wbm_dat_o	({wb_dbg_sdt, wb_cpu_d_sdt}),
	.wbm_ack_o	({wb_dbg_ack, wb_cpu_d_ack}),
	.wbm_err_o	({wb_dbg_err, wb_cpu_d_err}),
	.wbm_rty_o	({wb_dbg_rty, wb_cpu_d_rty}),
	//Slave interface
	.wbs_adr_o	(wbm_dbus_adr),
	.wbs_dat_o	(wbm_dbus_dat),
	.wbs_sel_o	(wbm_dbus_sel),
	.wbs_we_o	(wbm_dbus_we),
	.wbs_cyc_o	(wbm_dbus_cyc),
	.wbs_stb_o	(wbm_dbus_stb),
	.wbs_cti_o	(wbm_dbus_cti),
	.wbs_bte_o	(wbm_dbus_bte),
	.wbs_dat_i	(wbm_dbus_sdt),
	.wbs_ack_i	(wbm_dbus_ack),
	.wbs_err_i	(wbm_dbus_err),
	.wbs_rty_i	(wbm_dbus_rty)
);

//
// Wishbone data address decoder
//

// 0x00000000 to 0x0fffffff is mapped to the SDRAM
// 0x10000000 to 0xffffffff is mapped to the peripherals
wire	[dbus_slaves-1:0] dbus_slave_sel =
		{wbm_dbus_adr[31:28] != 4'h0,
		wbm_dbus_adr[31:28] == 4'h0};

wb_mux #(.num_slaves(dbus_slaves))
wb_mux_dbus (
	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst),
	.slave_sel_i	(dbus_slave_sel),
	// Master Interface
	.wbm_adr_i	(wbm_dbus_adr),
	.wbm_dat_i	(wbm_dbus_dat),
	.wbm_sel_i	(wbm_dbus_sel),
	.wbm_we_i	(wbm_dbus_we),
	.wbm_cyc_i	(wbm_dbus_cyc),
	.wbm_stb_i	(wbm_dbus_stb),
	.wbm_cti_i	(wbm_dbus_cti),
	.wbm_bte_i	(wbm_dbus_bte),
	.wbm_sdt_o	(wbm_dbus_sdt),
	.wbm_ack_o	(wbm_dbus_ack),
	.wbm_err_o	(wbm_dbus_err),
	.wbm_rty_o	(wbm_dbus_rty),
	//Slave interface
	.wbs_adr_o	(wb_dbus_adr),
	.wbs_dat_o	(wb_dbus_dat),
	.wbs_sel_o	(wb_dbus_sel),
	.wbs_we_o	(wb_dbus_we),
	.wbs_cyc_o	(wb_dbus_cyc),
	.wbs_stb_o	(wb_dbus_stb),
	.wbs_cti_o	(wb_dbus_cti),
	.wbs_bte_o	(wb_dbus_bte),
	.wbs_sdt_i	({wb_bbus_sdt, wb_mc0_dbus_sdt}),
	.wbs_ack_i	({wb_bbus_ack, wb_mc0_dbus_ack}),
	.wbs_err_i	({wb_bbus_err, wb_mc0_dbus_err}),
	.wbs_rty_i	({wb_bbus_rty, wb_mc0_dbus_rty}));

//
// Wishbone data address decoder
//

wire	[31:0]			wb_s_bbus_adr;
wire	[7:0]			wb_s_bbus_dat;
wire				wb_s_bbus_we;
wire				wb_s_bbus_cyc;
wire				wb_s_bbus_stb;
wire	[2:0]			wb_s_bbus_cti;
wire	[1:0]			wb_s_bbus_bte;
wire	[7:0]			wb_s_bbus_sdt;
wire				wb_s_bbus_ack;
wire				wb_s_bbus_err;
wire				wb_s_bbus_rty;

wb_data_resize #(.sdw(8))

wb_data_resize_bbus
(
	// Wishbone Master interface
	.wbm_adr_i(wb_dbus_adr),
	.wbm_dat_i(wb_dbus_dat),
	.wbm_sel_i(wb_dbus_sel),
	.wbm_we_i(wb_dbus_we),
	.wbm_cyc_i(wb_dbus_cyc[bbus_slave_nr]),
	.wbm_stb_i(wb_dbus_stb),
	.wbm_cti_i(wb_dbus_cti),
	.wbm_bte_i(wb_dbus_bte),
	.wbm_sdt_o(wb_bbus_sdt),
	.wbm_ack_o(wb_bbus_ack),
	.wbm_err_o(wb_bbus_err),
	.wbm_rty_o(wb_bbus_rty),
	// Wishbone Slave interface
	.wbs_adr_o(wb_s_bbus_adr),
	.wbs_dat_o(wb_s_bbus_dat),
	.wbs_we_o(wb_s_bbus_we),
	.wbs_cyc_o(wb_s_bbus_cyc),
	.wbs_stb_o(wb_s_bbus_stb),
	.wbs_cti_o(wb_s_bbus_cti),
	.wbs_bte_o(wb_s_bbus_bte),
	.wbs_sdt_i(wb_s_bbus_sdt),
	.wbs_ack_i(wb_s_bbus_ack),
	.wbs_err_i(wb_s_bbus_err),
	.wbs_rty_i(wb_s_bbus_rty)
);

//
// Wishbone byte-wide address decoder
//

// 0xe1000000 to 0xe1ffffff is mapped to the intgen
// 0x90000000 to 0x90ffffff is mapped to the uart
wire	[bbus_slaves-1:0] bbus_slave_sel =
		{wb_dbus_adr[31:24] == gpio_wb_adr,
		 wb_dbus_adr[31:24] == uart0_wb_adr};

wire	[31:0]			wb_bbus_adr;
wire	[7:0]			wb_bbus_dat;
wire	[3:0]			wb_bbus_sel;
wire				wb_bbus_we;
wire	[bbus_slaves-1:0]	wb_bbus_cyc;
wire				wb_bbus_stb;
wire	[2:0]			wb_bbus_cti;
wire	[1:0]			wb_bbus_bte;

wb_mux	#(.dw(8),
	  .num_slaves(bbus_slaves))

wb_mux_bbus (
	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst),
	.slave_sel_i	(bbus_slave_sel),
	//Master interface
	.wbm_adr_i	(wb_s_bbus_adr),
	.wbm_dat_i	(wb_s_bbus_dat),
	.wbm_sel_i	(1'b1),
	.wbm_we_i	(wb_s_bbus_we),
	.wbm_cyc_i	(wb_s_bbus_cyc),
	.wbm_stb_i	(wb_s_bbus_stb),
	.wbm_cti_i	(wb_s_bbus_cti),
	.wbm_bte_i	(wb_s_bbus_bte),
	.wbm_sdt_o	(wb_s_bbus_sdt),
	.wbm_ack_o	(wb_s_bbus_ack),
	.wbm_err_o	(wb_s_bbus_err),
	.wbm_rty_o	(wb_s_bbus_rty),
	//Slave interface
	.wbs_adr_o	(wb_bbus_adr),
	.wbs_dat_o	(wb_bbus_dat),
	.wbs_sel_o	(),
	.wbs_we_o	(wb_bbus_we),
	.wbs_cyc_o	(wb_bbus_cyc),
	.wbs_stb_o	(wb_bbus_stb),
	.wbs_cti_o	(wb_bbus_cti),
	.wbs_bte_o	(wb_bbus_bte),
	.wbs_sdt_i	({wb_gpio_sdt, wb_intgen_sdt, wb_uart_sdt}),
	.wbs_ack_i	({wb_gpio_ack, wb_intgen_ack, wb_uart_ack}),
	.wbs_err_i	({wb_gpio_err, wb_intgen_err, wb_uart_err}),
	.wbs_rty_i	({wb_gpio_rty, wb_intgen_rty, wb_uart_rty})
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
// CPU
//
////////////////////////////////////////////////////////////////////////

wire	[31:0]	cpu_irq;

wire	[31:0]	cpu_dbg_dat_i;
wire	[31:0]	cpu_dbg_adr_i;
wire		cpu_dbg_we_i;
wire		cpu_dbg_stb_i;
wire		cpu_dbg_ack_o;
wire	[31:0]	cpu_dbg_dat_o;

wire		cpu_dbg_stall_i;
wire		cpu_dbg_ewt_i;
wire	[3:0]	cpu_dbg_lss_o;
wire	[1:0]	cpu_dbg_is_o;
wire	[10:0]	cpu_dbg_wp_o;
wire		cpu_dbg_bp_o;
wire		cpu_dbg_rst;

wire		sig_tick;
wire		cpu_rst;

assign	cpu_rst= wb_rst | cpu_dbg_rst;

`ifdef OR1200
or1200_top #(.boot_adr(32'hf0000100))
or1200_top0 (
	// Instruction bus, clocks, reset
	.iwb_clk_i			(wb_clk),
	.iwb_rst_i			(wb_rst),
	.iwb_ack_i			(wb_cpu_i_ack),
	.iwb_err_i			(wb_cpu_i_err),
	.iwb_rty_i			(wb_cpu_i_rty),
	.iwb_dat_i			(wb_cpu_i_sdt),

	.iwb_cyc_o			(wb_cpu_i_cyc),
	.iwb_adr_o			(wb_cpu_i_adr),
	.iwb_stb_o			(wb_cpu_i_stb),
	.iwb_we_o			(wb_cpu_i_we),
	.iwb_sel_o			(wb_cpu_i_sel),
	.iwb_dat_o			(wb_cpu_i_dat),
	.iwb_cti_o			(wb_cpu_i_cti),
	.iwb_bte_o			(wb_cpu_i_bte),

	// Data bus, clocks, reset
	.dwb_clk_i			(wb_clk),
	.dwb_rst_i			(wb_rst),
	.dwb_ack_i			(wb_cpu_d_ack),
	.dwb_err_i			(wb_cpu_d_err),
	.dwb_rty_i			(wb_cpu_d_rty),
	.dwb_dat_i			(wb_cpu_d_sdt),

	.dwb_cyc_o			(wb_cpu_d_cyc),
	.dwb_adr_o			(wb_cpu_d_adr),
	.dwb_stb_o			(wb_cpu_d_stb),
	.dwb_we_o			(wb_cpu_d_we),
	.dwb_sel_o			(wb_cpu_d_sel),
	.dwb_dat_o			(wb_cpu_d_dat),
	.dwb_cti_o			(wb_cpu_d_cti),
	.dwb_bte_o			(wb_cpu_d_bte),

	// Debug interface ports
	.dbg_stall_i			(cpu_dbg_stall_i),
	.dbg_ewt_i			(1'b0),
	.dbg_lss_o			(cpu_dbg_lss_o),
	.dbg_is_o			(cpu_dbg_is_o),
	.dbg_wp_o			(cpu_dbg_wp_o),
	.dbg_bp_o			(cpu_dbg_bp_o),

	.dbg_adr_i			(cpu_dbg_adr_i),
	.dbg_we_i			(cpu_dbg_we_i),
	.dbg_stb_i			(cpu_dbg_stb_i),
	.dbg_dat_i			(cpu_dbg_dat_i),
	.dbg_dat_o			(cpu_dbg_dat_o),
	.dbg_ack_o			(cpu_dbg_ack_o),

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
	.rst_i				(cpu_rst),

	.clmode_i			(2'b00),

	// Interrupts
	.pic_ints_i			(cpu_irq}),
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
	.iwbm_adr_o(wb_cpu_i_adr),
	.iwbm_stb_o(wb_cpu_i_stb),
	.iwbm_cyc_o(wb_cpu_i_cyc),
	.iwbm_sel_o(wb_cpu_i_sel),
	.iwbm_we_o (wb_cpu_i_we),
	.iwbm_cti_o(wb_cpu_i_cti),
	.iwbm_bte_o(wb_cpu_i_bte),
	.iwbm_dat_o(wb_cpu_i_dat),

	.dwbm_adr_o(wb_cpu_d_adr),
	.dwbm_stb_o(wb_cpu_d_stb),
	.dwbm_cyc_o(wb_cpu_d_cyc),
	.dwbm_sel_o(wb_cpu_d_sel),
	.dwbm_we_o (wb_cpu_d_we ),
	.dwbm_cti_o(wb_cpu_d_cti),
	.dwbm_bte_o(wb_cpu_d_bte),
	.dwbm_dat_o(wb_cpu_d_dat),

	.clk(wb_clk),
	.rst(wb_rst),

	.iwbm_err_i(wb_cpu_i_err),
	.iwbm_ack_i(wb_cpu_i_ack),
	.iwbm_dat_i(wb_cpu_i_sdt),
	.iwbm_rty_i(wb_cpu_i_rty),

	.dwbm_err_i(wb_cpu_d_err),
	.dwbm_ack_i(wb_cpu_d_ack),
	.dwbm_dat_i(wb_cpu_d_sdt),
	.dwbm_rty_i(wb_cpu_d_rty),

	.irq_i(cpu_irq),

	.du_addr_i(cpu_dbg_adr_i[15:0]),
	.du_stb_i(cpu_dbg_stb_i),
	.du_dat_i(cpu_dbg_dat_i),
	.du_we_i(cpu_dbg_we_i),
	.du_dat_o(cpu_dbg_dat_o),
	.du_ack_o(cpu_dbg_ack_o),
	.du_stall_i(cpu_dbg_stall_i),
	.du_stall_o(cpu_dbg_bp_o)
);

`endif
////////////////////////////////////////////////////////////////////////
//
// Debug Interface
//
////////////////////////////////////////////////////////////////////////

adbg_top dbg_if0 (
	// OR1200 interface
	.cpu0_clk_i	(wb_clk),
	.cpu0_rst_o	(cpu_dbg_rst),
	.cpu0_addr_o	(cpu_dbg_adr_i),
	.cpu0_data_o	(cpu_dbg_dat_i),
	.cpu0_stb_o	(cpu_dbg_stb_i),
	.cpu0_we_o	(cpu_dbg_we_i),
	.cpu0_data_i	(cpu_dbg_dat_o),
	.cpu0_ack_i	(cpu_dbg_ack_o),
	.cpu0_stall_o	(cpu_dbg_stall_i),
	.cpu0_bp_i	(cpu_dbg_bp_o),

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
	.wb_dat_i	(wb_dbg_sdt),
	.wb_ack_i	(wb_dbg_ack),
	.wb_err_i	(wb_dbg_err),

	.wb_adr_o	(wb_dbg_adr),
	.wb_dat_o	(wb_dbg_dat),
	.wb_cyc_o	(wb_dbg_cyc),
	.wb_stb_o	(wb_dbg_stb),
	.wb_sel_o	(wb_dbg_sel),
	.wb_we_o	(wb_dbg_we),
	.wb_cti_o	(wb_dbg_cti),
	.wb_bte_o	(wb_dbg_bte)
);

////////////////////////////////////////////////////////////////////////
//
// ROM
//
////////////////////////////////////////////////////////////////////////

assign	wb_rom0_err = 1'b0;
assign	wb_rom0_rty = 1'b0;

`ifdef BOOTROM
rom #(.addr_width(rom0_aw))
rom0 (
	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst),
	.wb_adr_i	(wb_ibus_adr[(rom0_aw + 2) - 1 : 2]),
	.wb_cyc_i	(wb_ibus_cyc[rom0_slave_nr]),
	.wb_stb_i	(wb_ibus_stb),
	.wb_cti_i	(wb_ibus_cti),
	.wb_bte_i	(wb_ibus_bte),
	.wb_dat_o	(wb_rom0_sdt),
	.wb_ack_o	(wb_rom0_ack)
);
`else
assign	wb_rom0_dat_o = 0;
assign	wb_rom0_ack_o = 0;
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
	.wbm0_dat_i		(wb_ibus_dat),
	.wbm0_adr_i		(wb_ibus_adr),
	.wbm0_sel_i		(wb_ibus_sel),
	.wbm0_cti_i		(wb_ibus_cti),
	.wbm0_bte_i		(wb_ibus_bte),
	.wbm0_we_i		(wb_ibus_we ),
	.wbm0_cyc_i		(wb_ibus_cyc[mc0_ibus_slave_nr]),
	.wbm0_stb_i		(wb_ibus_stb),
	.wbm0_dat_o		(wb_mc0_ibus_sdt),
	.wbm0_ack_o		(wb_mc0_ibus_ack),
	.wbm0_err_o		(wb_mc0_ibus_err),
	.wbm0_rty_o		(wb_mc0_ibus_rty),
	// Wishbone slave interface 1
	.wbm1_dat_i		(wb_dbus_dat),
	.wbm1_adr_i		(wb_dbus_adr),
	.wbm1_sel_i		(wb_dbus_sel),
	.wbm1_cti_i		(wb_dbus_cti),
	.wbm1_bte_i		(wb_dbus_bte),
	.wbm1_we_i		(wb_dbus_we),
	.wbm1_cyc_i		(wb_dbus_cyc[mc0_dbus_slave_nr]),
	.wbm1_stb_i		(wb_dbus_stb),
	.wbm1_dat_o		(wb_mc0_dbus_sdt),
	.wbm1_ack_o		(wb_mc0_dbus_ack),
	.wbm1_err_o		(wb_mc0_dbus_err),
	.wbm1_rty_o		(wb_mc0_dbus_rty),
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

assign	wb_uart_err = 0;
assign	wb_uart_rty = 0;

uart_top uart16550_0 (
	// Wishbone slave interface
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),
	.wb_adr_i	(wb_bbus_adr[uart0_aw-1:0]),
	.wb_dat_i	(wb_bbus_dat),
	.wb_we_i	(wb_bbus_we),
	.wb_stb_i	(wb_bbus_stb),
	.wb_cyc_i	(wb_bbus_cyc[uart_slave_nr]),
	.wb_sel_i	(),
	.wb_dat_o	(wb_uart_sdt),
	.wb_ack_o	(wb_uart_ack),

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

////////////////////////////////////////////////////////////////////////
//
// GPIO 0
//
////////////////////////////////////////////////////////////////////////

	localparam gpio0_io_width = 8;

	wire [gpio0_io_width-1:0] gpio0_in;
	wire [gpio0_io_width-1:0] gpio0_out;
	wire [gpio0_io_width-1:0] gpio0_dir;

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
	.wb_adr_i	(wb_bbus_adr[gpio_addr_width-1:0]),
	.wb_dat_i	(wb_bbus_dat),
	.wb_we_i	(wb_bbus_we),
	.wb_cyc_i	(wb_bbus_cyc[gpio_slave_nr]),
	.wb_stb_i	(wb_bbus_stb),
	.wb_cti_i	(),
	.wb_bte_i	(),
	.wb_dat_o	(wb_gpio_sdt),
	.wb_ack_o	(wb_gpio_ack),
	.wb_err_o	(wb_gpio_err),
	.wb_rty_o	(wb_gpio_rty),

	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst)
);

////////////////////////////////////////////////////////////////////////
//
// Interrupt assignment
//
////////////////////////////////////////////////////////////////////////

assign cpu_irq[0] = 0; // Non-maskable inside OR1200
assign cpu_irq[1] = 0; // Non-maskable inside OR1200
assign cpu_irq[2] = uart0_irq;
assign cpu_irq[3] = 0;
assign cpu_irq[4] = 0;
assign cpu_irq[5] = 0;
assign cpu_irq[6] = 0;
assign cpu_irq[7] = 0;
assign cpu_irq[8] = 0;
assign cpu_irq[9] = 0;
assign cpu_irq[10] = 0;
assign cpu_irq[11] = 0;
assign cpu_irq[12] = 0;
assign cpu_irq[13] = 0;
assign cpu_irq[14] = 0;
assign cpu_irq[15] = 0;
assign cpu_irq[16] = 0;
assign cpu_irq[17] = 0;
assign cpu_irq[18] = 0;
assign cpu_irq[19] = 0;
assign cpu_irq[20] = 0;
assign cpu_irq[21] = 0;
assign cpu_irq[22] = 0;
assign cpu_irq[23] = 0;
assign cpu_irq[24] = 0;
assign cpu_irq[25] = 0;
assign cpu_irq[26] = 0;
assign cpu_irq[27] = 0;
assign cpu_irq[28] = 0;
assign cpu_irq[29] = 0;
assign cpu_irq[30] = 0;
assign cpu_irq[31] = 0;

endmodule // orpsoc_top
