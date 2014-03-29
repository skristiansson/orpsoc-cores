module orpsoc_top
  #(parameter UART_SIM = 0)
  (input wb_clk_i,
   input wb_rst_i);

   localparam wb_aw = 32;
   localparam wb_dw = 32;

   localparam MEM_SIZE_BITS = 23;
   
   ////////////////////////////////////////////////////////////////////////
   //
   // Clock and reset generation
   // 
   ////////////////////////////////////////////////////////////////////////
   

   ////////////////////////////////////////////////////////////////////////
   //
   // Wishbone interconnect
   //
   ////////////////////////////////////////////////////////////////////////
   wire wb_clk = wb_clk_i;
   wire wb_rst = wb_rst_i;

   `include "wb_intercon.vh"

   ////////////////////////////////////////////////////////////////////////
   //
   // or1200
   // 
   ////////////////////////////////////////////////////////////////////////

   wire [19:0] 				  or1200_pic_ints;

   or1200_top #(.boot_adr(32'h00000100)) or1200_top0
       (
	// Instruction bus, clocks, reset
	.iwb_clk_i			(wb_clk_i),
	.iwb_rst_i			(wb_rst_i),
	.iwb_adr_o			(wb_m2s_or1200_i_adr),
	.iwb_dat_o			(wb_m2s_or1200_i_dat),
	.iwb_sel_o			(wb_m2s_or1200_i_sel),
	.iwb_we_o			(wb_m2s_or1200_i_we ),
	.iwb_cyc_o			(wb_m2s_or1200_i_cyc),
	.iwb_stb_o			(wb_m2s_or1200_i_stb),
	.iwb_cti_o			(wb_m2s_or1200_i_cti),
	.iwb_bte_o			(wb_m2s_or1200_i_bte),
	.iwb_dat_i			(wb_s2m_or1200_i_dat),
	.iwb_ack_i			(wb_s2m_or1200_i_ack),
	.iwb_err_i			(wb_s2m_or1200_i_err),
	.iwb_rty_i			(wb_s2m_or1200_i_rty),
	// Data bus, clocks, reset            
	.dwb_clk_i			(wb_clk_i),
	.dwb_rst_i			(wb_rst_i),
	.dwb_adr_o			(wb_m2s_or1200_d_adr),
	.dwb_dat_o			(wb_m2s_or1200_d_dat),
	.dwb_sel_o			(wb_m2s_or1200_d_sel),
	.dwb_we_o			(wb_m2s_or1200_d_we),
	.dwb_cyc_o			(wb_m2s_or1200_d_cyc),
	.dwb_stb_o			(wb_m2s_or1200_d_stb),
	.dwb_cti_o			(wb_m2s_or1200_d_cti),
	.dwb_bte_o			(wb_m2s_or1200_d_bte),
	.dwb_dat_i			(wb_s2m_or1200_d_dat),
	.dwb_ack_i			(wb_s2m_or1200_d_ack),
	.dwb_err_i			(wb_s2m_or1200_d_err),
	.dwb_rty_i			(wb_s2m_or1200_d_rty),

	// Debug interface ports
	.dbg_stall_i			(1'b0),
	.dbg_ewt_i			(1'b0),
	.dbg_lss_o			(),
	.dbg_is_o			(),
	.dbg_wp_o			(),
	.dbg_bp_o			(),

	.dbg_adr_i			(32'b0),      
	.dbg_we_i			(1'b0), 
	.dbg_stb_i			(1'b0),          
	.dbg_dat_i			(32'b0),
	.dbg_dat_o			(),
	.dbg_ack_o			(),
	
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
	.clk_i				(wb_clk_i),
	.rst_i				(wb_rst_i),
	
	.clmode_i			(2'b00),
	// Interrupts      
	.pic_ints_i			(or1200_pic_ints),
	.sig_tick(),

	.pm_cpustall_i			(1'b0));

   ////////////////////////////////////////////////////////////////////////
   //
   // Generic main RAM
   // 
   ////////////////////////////////////////////////////////////////////////
   ram_wb_b3 #(
   //wb_bfm_memory #(.DEBUG (0),
	       .mem_size_bytes (2**MEM_SIZE_BITS*(wb_dw/8)),
	       .mem_adr_width (MEM_SIZE_BITS))
   wb_bfm_memory0
     (
      //Wishbone Master interface
      .wb_clk_i (wb_clk_i),
      .wb_rst_i (wb_rst_i),
      .wb_adr_i	(wb_m2s_mem_adr & (2**MEM_SIZE_BITS-1)),
      .wb_dat_i	(wb_m2s_mem_dat),
      .wb_sel_i	(wb_m2s_mem_sel),
      .wb_we_i	(wb_m2s_mem_we),
      .wb_cyc_i	(wb_m2s_mem_cyc),
      .wb_stb_i	(wb_m2s_mem_stb),
      .wb_cti_i	(wb_m2s_mem_cti),
      .wb_bte_i	(wb_m2s_mem_bte),
      .wb_dat_o	(wb_s2m_mem_dat),
      .wb_ack_o	(wb_s2m_mem_ack),
      .wb_err_o (wb_s2m_mem_err),
      .wb_rty_o (wb_s2m_mem_rty));
   

   wb_uart_wrapper
     #(.DEBUG (0),
       .SIM   (UART_SIM))
   wb_uart_wrapper0
     (
      //Wishbone Master interface
      .wb_clk_i (wb_clk_i),
      .wb_rst_i (wb_rst_i),
      .rx       (1'b0),
      .tx       (uart),
      .wb_adr_i	(wb_m2s_uart_adr),
      .wb_dat_i	(wb_m2s_uart_dat),
      .wb_we_i	(wb_m2s_uart_we),
      .wb_cyc_i	(wb_m2s_uart_cyc),
      .wb_stb_i	(wb_m2s_uart_stb),
      .wb_cti_i	(wb_m2s_uart_cti),
      .wb_bte_i	(wb_m2s_uart_bte),
      .wb_dat_o	(wb_s2m_uart_dat),
      .wb_ack_o	(wb_s2m_uart_ack),
      .wb_err_o (wb_s2m_uart_err),
      .wb_rty_o (wb_s2m_uart_rty));

   `ifdef VERILATOR
   wire [7:0] 				  uart_rx_data;
   wire  				  uart_rx_done;
   
   uart_transceiver uart_transceiver0
     (
      .sys_rst (wb_rst_i),
      .sys_clk  (wb_clk_i),

      .uart_rx (uart),
      .uart_tx (),

      .divisor(16'd26),

      .rx_data (uart_rx_data),
      .rx_done (uart_rx_done),

      .tx_data (8'h00),
      .tx_wr   (1'b0),
      .tx_done (),

      .rx_break ());

   always @(posedge wb_clk_i)
     if(uart_rx_done)
       $write("%c", uart_rx_data);
   
   `endif

   ////////////////////////////////////////////////////////////////////////
   //
   // OR1200 Interrupt assignment
   // 
   ////////////////////////////////////////////////////////////////////////
   assign or1200_pic_ints[0] = 0; // Non-maskable inside OR1200
   assign or1200_pic_ints[1] = 0; // Non-maskable inside OR1200
   assign or1200_pic_ints[2] = 0;
   assign or1200_pic_ints[3] = 0;
   assign or1200_pic_ints[4] = 0;
   assign or1200_pic_ints[5] = 0;
   assign or1200_pic_ints[6] = 0;
   assign or1200_pic_ints[7] = 0;
   assign or1200_pic_ints[8] = 0;
   assign or1200_pic_ints[9] = 0;
   assign or1200_pic_ints[10] = 0;
   assign or1200_pic_ints[11] = 0;
   assign or1200_pic_ints[12] = 0;
   assign or1200_pic_ints[13] = 0;
   assign or1200_pic_ints[14] = 0;
   assign or1200_pic_ints[15] = 0;
   assign or1200_pic_ints[16] = 0;
   assign or1200_pic_ints[17] = 0;
   assign or1200_pic_ints[18] = 0;
   assign or1200_pic_ints[19] = 0;
   
endmodule
