module orpsoc_top
  #(parameter UART_SIM = 0)
  (input wb_clk_i,
   input wb_rst_i);

   localparam wb_aw = 32;
   localparam wb_dw = 32;

   localparam MEM_SIZE_BITS = 25;

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
   wire wb_clk_n = ~wb_clk;
   wire wb_rst = wb_rst_i;

   `include "wb_intercon.vh"

wire [15:0] 				  eco32_irq;

////////////////////////////////////////////////////////////////////////
//
// eco32f
//
////////////////////////////////////////////////////////////////////////

eco32f #(
	.RESET_PC(32'hc0000000)
) eco32f0 (
	// Instruction bus, clocks, reset
	.iwbm_adr_o			(wb_m2s_eco32f_i_adr),
	.iwbm_dat_o			(wb_m2s_eco32f_i_dat),
	.iwbm_sel_o			(wb_m2s_eco32f_i_sel),
	.iwbm_we_o			(wb_m2s_eco32f_i_we ),
	.iwbm_cyc_o			(wb_m2s_eco32f_i_cyc),
	.iwbm_stb_o			(wb_m2s_eco32f_i_stb),
	.iwbm_cti_o			(wb_m2s_eco32f_i_cti),
	.iwbm_bte_o			(wb_m2s_eco32f_i_bte),
	.iwbm_dat_i			(wb_s2m_eco32f_i_dat),
	.iwbm_ack_i			(wb_s2m_eco32f_i_ack),
	.iwbm_err_i			(wb_s2m_eco32f_i_err),
	.iwbm_rty_i			(wb_s2m_eco32f_i_rty),
	// Data bus, clocks, reset
	.dwbm_adr_o			(wb_m2s_eco32f_d_adr),
	.dwbm_dat_o			(wb_m2s_eco32f_d_dat),
	.dwbm_sel_o			(wb_m2s_eco32f_d_sel),
	.dwbm_we_o			(wb_m2s_eco32f_d_we),
	.dwbm_cyc_o			(wb_m2s_eco32f_d_cyc),
	.dwbm_stb_o			(wb_m2s_eco32f_d_stb),
	.dwbm_cti_o			(wb_m2s_eco32f_d_cti),
	.dwbm_bte_o			(wb_m2s_eco32f_d_bte),
	.dwbm_dat_i			(wb_s2m_eco32f_d_dat),
	.dwbm_ack_i			(wb_s2m_eco32f_d_ack),
	.dwbm_err_i			(wb_s2m_eco32f_d_err),
	.dwbm_rty_i			(wb_s2m_eco32f_d_rty),

	// Core clocks, resets
	.clk				(wb_clk_i),
	.rst				(wb_rst_i),

	// Interrupts
	.irq				(eco32_irq)
);

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

////////////////////////////////////////////////////////////////////////////////
//
// UART0
//
////////////////////////////////////////////////////////////////////////////////

wire uart0_txd;

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
		.clk		(wb_clk_i),
		.reset		(wb_rst_i),
		.en		(eco32_uart0_en),
		.wr		(wb_m2s_uart0_we),
		.addr		(wb_m2s_uart0_adr[3:2]),
		.data_in	(eco32_uart0_data_in),
		.data_out	(eco32_uart0_data_out),
		.wt		(eco32_uart0_wt),
		.irq_r		(eco32_uart0_irq_r),
		.irq_t		(eco32_uart0_irq_t),
		.rxd		(1'b1),
		.txd		(uart0_txd)
);

   `ifdef VERILATOR
   wire [7:0] 				  uart_rx_data;
   wire  				  uart_rx_done;

   uart_transceiver uart_transceiver0
     (
      .sys_rst (wb_rst_i),
      .sys_clk  (wb_clk_i),

      .uart_rx (uart0_txd),
      .uart_tx (),

      .divisor(16'd80),

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

////////////////////////////////////////////////////////////////////////////////
//
// TIMER
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

tmr eco32_timer0
       (
	.clk		(wb_clk_i),
	.reset		(wb_rst_i),
	.en		(eco32_timer0_en),
	.wr		(wb_m2s_timer0_we),
	.addr		(wb_m2s_timer0_adr[3:2]),
	.data_in	(eco32_timer0_data_in),
	.data_out	(eco32_timer0_data_out),
	.wt		(eco32_timer0_wt),
	.irq		(eco32_timer0_irq)
);

////////////////////////////////////////////////////////////////////////////////
//
// eco32f irq assignment
//
////////////////////////////////////////////////////////////////////////////////

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
