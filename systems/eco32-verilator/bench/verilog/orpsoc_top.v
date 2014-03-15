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

////////////////////////////////////////////////////////////////////////
//
// eco32
//
////////////////////////////////////////////////////////////////////////

wire [15:0] 				  eco32_irq;

wire		eco32_bus_en;		// bus enable
wire		eco32_bus_wr;		// bus write
wire [1:0]	eco32_bus_size;		// 00: byte, 01: halfword, 10: word
wire [31:0]	eco32_bus_addr;		// bus address
wire [31:0]	eco32_bus_data_in;	// bus data input, for reads
wire [31:0]	eco32_bus_data_out;	// bus data output, for writes
wire		eco32_bus_wt;		// bus wait

wire non_word_write = eco32_bus_en && eco32_bus_size != 2'b10 && eco32_bus_wr;
wire non_word_read = eco32_bus_en && eco32_bus_size != 2'b10 && !eco32_bus_wr;

assign wb_m2s_eco32f_i_adr = 0;
assign wb_m2s_eco32f_i_dat = 0;
assign wb_m2s_eco32f_i_sel = 0;
assign wb_m2s_eco32f_i_we = 0;
assign wb_m2s_eco32f_i_cyc = 0;
assign wb_m2s_eco32f_i_stb = 0;
assign wb_m2s_eco32f_i_cti = 0;
assign wb_m2s_eco32f_i_bte = 0;

assign wb_m2s_eco32f_d_adr = eco32_bus_addr;
assign wb_m2s_eco32f_d_dat = eco32_bus_size == 2'b00 ? // byte
			     {4{eco32_bus_data_out[7:0]}} :
			     eco32_bus_size == 2'b01 ? // halfword
			     {2{eco32_bus_data_out[15:0]}} :
			     eco32_bus_data_out;
assign wb_m2s_eco32f_d_sel = eco32_bus_size == 2'b00 ? // byte
			     (eco32_bus_addr[1:0] == 2'b00 ? 4'b1000 :
			      eco32_bus_addr[1:0] == 2'b01 ? 4'b0100 :
			      eco32_bus_addr[1:0] == 2'b10 ? 4'b0010 :
			      4'b0001) :
			     eco32_bus_size == 2'b01 ? // half word
			     (eco32_bus_addr[1] == 1'b0 ? 4'b1100 : 4'b0011) :
			     4'b1111;
assign wb_m2s_eco32f_d_we = eco32_bus_wr;
assign wb_m2s_eco32f_d_cyc = eco32_bus_en;
assign wb_m2s_eco32f_d_stb = eco32_bus_en;
assign wb_m2s_eco32f_d_cti = 0;
assign wb_m2s_eco32f_d_bte = 0;

assign eco32_bus_data_in = wb_m2s_eco32f_d_sel == 4'b1000 ?
			   {4{wb_s2m_eco32f_d_dat[31:24]}} :
			   wb_m2s_eco32f_d_sel == 4'b0100 ?
			   {4{wb_s2m_eco32f_d_dat[23:16]}} :
			   wb_m2s_eco32f_d_sel == 4'b0010 ?
			   {4{wb_s2m_eco32f_d_dat[15:8]}} :
			   wb_m2s_eco32f_d_sel == 4'b0001 ?
			   {4{wb_s2m_eco32f_d_dat[7:0]}} :
			   wb_m2s_eco32f_d_sel == 4'b1100 ?
			   {2{wb_s2m_eco32f_d_dat[31:16]}} :
			   wb_m2s_eco32f_d_sel == 4'b0011 ?
			   {2{wb_s2m_eco32f_d_dat[15:0]}} :
			   wb_s2m_eco32f_d_dat;

assign eco32_bus_wt = !wb_s2m_eco32f_d_ack;

cpu eco32_0
       (
	// Core clocks, resets
	.clk				(wb_clk_i),
	.reset				(wb_rst_i),

	// Bus
	.bus_en				(eco32_bus_en),
	.bus_wr				(eco32_bus_wr),
	.bus_size			(eco32_bus_size),
	.bus_addr			(eco32_bus_addr),
	.bus_data_in			(eco32_bus_data_in),
	.bus_data_out			(eco32_bus_data_out),
	.bus_wt				(eco32_bus_wt),

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
