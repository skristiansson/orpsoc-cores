wire [31:0] wb_m2s_eco32f_i_adr;
wire [31:0] wb_m2s_eco32f_i_dat;
wire  [3:0] wb_m2s_eco32f_i_sel;
wire        wb_m2s_eco32f_i_we;
wire        wb_m2s_eco32f_i_cyc;
wire        wb_m2s_eco32f_i_stb;
wire  [2:0] wb_m2s_eco32f_i_cti;
wire  [1:0] wb_m2s_eco32f_i_bte;
wire [31:0] wb_s2m_eco32f_i_dat;
wire        wb_s2m_eco32f_i_ack;
wire        wb_s2m_eco32f_i_err;
wire        wb_s2m_eco32f_i_rty;
wire [31:0] wb_m2s_eco32f_d_adr;
wire [31:0] wb_m2s_eco32f_d_dat;
wire  [3:0] wb_m2s_eco32f_d_sel;
wire        wb_m2s_eco32f_d_we;
wire        wb_m2s_eco32f_d_cyc;
wire        wb_m2s_eco32f_d_stb;
wire  [2:0] wb_m2s_eco32f_d_cti;
wire  [1:0] wb_m2s_eco32f_d_bte;
wire [31:0] wb_s2m_eco32f_d_dat;
wire        wb_s2m_eco32f_d_ack;
wire        wb_s2m_eco32f_d_err;
wire        wb_s2m_eco32f_d_rty;
wire [31:0] wb_m2s_mem_adr;
wire [31:0] wb_m2s_mem_dat;
wire  [3:0] wb_m2s_mem_sel;
wire        wb_m2s_mem_we;
wire        wb_m2s_mem_cyc;
wire        wb_m2s_mem_stb;
wire  [2:0] wb_m2s_mem_cti;
wire  [1:0] wb_m2s_mem_bte;
wire [31:0] wb_s2m_mem_dat;
wire        wb_s2m_mem_ack;
wire        wb_s2m_mem_err;
wire        wb_s2m_mem_rty;
wire [31:0] wb_m2s_uart0_adr;
wire [31:0] wb_m2s_uart0_dat;
wire  [3:0] wb_m2s_uart0_sel;
wire        wb_m2s_uart0_we;
wire        wb_m2s_uart0_cyc;
wire        wb_m2s_uart0_stb;
wire  [2:0] wb_m2s_uart0_cti;
wire  [1:0] wb_m2s_uart0_bte;
wire [31:0] wb_s2m_uart0_dat;
wire        wb_s2m_uart0_ack;
wire        wb_s2m_uart0_err;
wire        wb_s2m_uart0_rty;
wire [31:0] wb_m2s_timer0_adr;
wire [31:0] wb_m2s_timer0_dat;
wire  [3:0] wb_m2s_timer0_sel;
wire        wb_m2s_timer0_we;
wire        wb_m2s_timer0_cyc;
wire        wb_m2s_timer0_stb;
wire  [2:0] wb_m2s_timer0_cti;
wire  [1:0] wb_m2s_timer0_bte;
wire [31:0] wb_s2m_timer0_dat;
wire        wb_s2m_timer0_ack;
wire        wb_s2m_timer0_err;
wire        wb_s2m_timer0_rty;

wb_intercon wb_intercon0
   (.wb_clk_i          (wb_clk),
    .wb_rst_i          (wb_rst),
    .wb_eco32f_i_adr_i (wb_m2s_eco32f_i_adr),
    .wb_eco32f_i_dat_i (wb_m2s_eco32f_i_dat),
    .wb_eco32f_i_sel_i (wb_m2s_eco32f_i_sel),
    .wb_eco32f_i_we_i  (wb_m2s_eco32f_i_we),
    .wb_eco32f_i_cyc_i (wb_m2s_eco32f_i_cyc),
    .wb_eco32f_i_stb_i (wb_m2s_eco32f_i_stb),
    .wb_eco32f_i_cti_i (wb_m2s_eco32f_i_cti),
    .wb_eco32f_i_bte_i (wb_m2s_eco32f_i_bte),
    .wb_eco32f_i_dat_o (wb_s2m_eco32f_i_dat),
    .wb_eco32f_i_ack_o (wb_s2m_eco32f_i_ack),
    .wb_eco32f_i_err_o (wb_s2m_eco32f_i_err),
    .wb_eco32f_i_rty_o (wb_s2m_eco32f_i_rty),
    .wb_eco32f_d_adr_i (wb_m2s_eco32f_d_adr),
    .wb_eco32f_d_dat_i (wb_m2s_eco32f_d_dat),
    .wb_eco32f_d_sel_i (wb_m2s_eco32f_d_sel),
    .wb_eco32f_d_we_i  (wb_m2s_eco32f_d_we),
    .wb_eco32f_d_cyc_i (wb_m2s_eco32f_d_cyc),
    .wb_eco32f_d_stb_i (wb_m2s_eco32f_d_stb),
    .wb_eco32f_d_cti_i (wb_m2s_eco32f_d_cti),
    .wb_eco32f_d_bte_i (wb_m2s_eco32f_d_bte),
    .wb_eco32f_d_dat_o (wb_s2m_eco32f_d_dat),
    .wb_eco32f_d_ack_o (wb_s2m_eco32f_d_ack),
    .wb_eco32f_d_err_o (wb_s2m_eco32f_d_err),
    .wb_eco32f_d_rty_o (wb_s2m_eco32f_d_rty),
    .wb_mem_adr_o      (wb_m2s_mem_adr),
    .wb_mem_dat_o      (wb_m2s_mem_dat),
    .wb_mem_sel_o      (wb_m2s_mem_sel),
    .wb_mem_we_o       (wb_m2s_mem_we),
    .wb_mem_cyc_o      (wb_m2s_mem_cyc),
    .wb_mem_stb_o      (wb_m2s_mem_stb),
    .wb_mem_cti_o      (wb_m2s_mem_cti),
    .wb_mem_bte_o      (wb_m2s_mem_bte),
    .wb_mem_dat_i      (wb_s2m_mem_dat),
    .wb_mem_ack_i      (wb_s2m_mem_ack),
    .wb_mem_err_i      (wb_s2m_mem_err),
    .wb_mem_rty_i      (wb_s2m_mem_rty),
    .wb_uart0_adr_o    (wb_m2s_uart0_adr),
    .wb_uart0_dat_o    (wb_m2s_uart0_dat),
    .wb_uart0_sel_o    (wb_m2s_uart0_sel),
    .wb_uart0_we_o     (wb_m2s_uart0_we),
    .wb_uart0_cyc_o    (wb_m2s_uart0_cyc),
    .wb_uart0_stb_o    (wb_m2s_uart0_stb),
    .wb_uart0_cti_o    (wb_m2s_uart0_cti),
    .wb_uart0_bte_o    (wb_m2s_uart0_bte),
    .wb_uart0_dat_i    (wb_s2m_uart0_dat),
    .wb_uart0_ack_i    (wb_s2m_uart0_ack),
    .wb_uart0_err_i    (wb_s2m_uart0_err),
    .wb_uart0_rty_i    (wb_s2m_uart0_rty),
    .wb_timer0_adr_o   (wb_m2s_timer0_adr),
    .wb_timer0_dat_o   (wb_m2s_timer0_dat),
    .wb_timer0_sel_o   (wb_m2s_timer0_sel),
    .wb_timer0_we_o    (wb_m2s_timer0_we),
    .wb_timer0_cyc_o   (wb_m2s_timer0_cyc),
    .wb_timer0_stb_o   (wb_m2s_timer0_stb),
    .wb_timer0_cti_o   (wb_m2s_timer0_cti),
    .wb_timer0_bte_o   (wb_m2s_timer0_bte),
    .wb_timer0_dat_i   (wb_s2m_timer0_dat),
    .wb_timer0_ack_i   (wb_s2m_timer0_ack),
    .wb_timer0_err_i   (wb_s2m_timer0_err),
    .wb_timer0_rty_i   (wb_s2m_timer0_rty));

