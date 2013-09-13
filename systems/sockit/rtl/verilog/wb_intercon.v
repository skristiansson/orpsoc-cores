module wb_intercon
   (input         wb_clk_i,
    input         wb_rst_i,
    input  [31:0] wb_m2s_or1k_i_adr,
    input  [31:0] wb_m2s_or1k_i_dat,
    input   [3:0] wb_m2s_or1k_i_sel,
    input         wb_m2s_or1k_i_we,
    input         wb_m2s_or1k_i_cyc,
    input         wb_m2s_or1k_i_stb,
    input   [2:0] wb_m2s_or1k_i_cti,
    input   [1:0] wb_m2s_or1k_i_bte,
    output [31:0] wb_s2m_or1k_i_dat,
    output        wb_s2m_or1k_i_ack,
    output        wb_s2m_or1k_i_err,
    output        wb_s2m_or1k_i_rty,
    input  [31:0] wb_m2s_or1k_d_adr,
    input  [31:0] wb_m2s_or1k_d_dat,
    input   [3:0] wb_m2s_or1k_d_sel,
    input         wb_m2s_or1k_d_we,
    input         wb_m2s_or1k_d_cyc,
    input         wb_m2s_or1k_d_stb,
    input   [2:0] wb_m2s_or1k_d_cti,
    input   [1:0] wb_m2s_or1k_d_bte,
    output [31:0] wb_s2m_or1k_d_dat,
    output        wb_s2m_or1k_d_ack,
    output        wb_s2m_or1k_d_err,
    output        wb_s2m_or1k_d_rty,
    input  [31:0] wb_m2s_dbg_adr,
    input  [31:0] wb_m2s_dbg_dat,
    input   [3:0] wb_m2s_dbg_sel,
    input         wb_m2s_dbg_we,
    input         wb_m2s_dbg_cyc,
    input         wb_m2s_dbg_stb,
    input   [2:0] wb_m2s_dbg_cti,
    input   [1:0] wb_m2s_dbg_bte,
    output [31:0] wb_s2m_dbg_dat,
    output        wb_s2m_dbg_ack,
    output        wb_s2m_dbg_err,
    output        wb_s2m_dbg_rty,
    output [31:0] wb_m2s_gpio0_adr,
    output [31:0] wb_m2s_gpio0_dat,
    output  [3:0] wb_m2s_gpio0_sel,
    output        wb_m2s_gpio0_we,
    output        wb_m2s_gpio0_cyc,
    output        wb_m2s_gpio0_stb,
    output  [2:0] wb_m2s_gpio0_cti,
    output  [1:0] wb_m2s_gpio0_bte,
    input  [31:0] wb_s2m_gpio0_dat,
    input         wb_s2m_gpio0_ack,
    input         wb_s2m_gpio0_err,
    input         wb_s2m_gpio0_rty,
    output [31:0] wb_m2s_rom0_adr,
    output [31:0] wb_m2s_rom0_dat,
    output  [3:0] wb_m2s_rom0_sel,
    output        wb_m2s_rom0_we,
    output        wb_m2s_rom0_cyc,
    output        wb_m2s_rom0_stb,
    output  [2:0] wb_m2s_rom0_cti,
    output  [1:0] wb_m2s_rom0_bte,
    input  [31:0] wb_s2m_rom0_dat,
    input         wb_s2m_rom0_ack,
    input         wb_s2m_rom0_err,
    input         wb_s2m_rom0_rty,
    output [31:0] wb_m2s_mem0_d_adr,
    output [31:0] wb_m2s_mem0_d_dat,
    output  [3:0] wb_m2s_mem0_d_sel,
    output        wb_m2s_mem0_d_we,
    output        wb_m2s_mem0_d_cyc,
    output        wb_m2s_mem0_d_stb,
    output  [2:0] wb_m2s_mem0_d_cti,
    output  [1:0] wb_m2s_mem0_d_bte,
    input  [31:0] wb_s2m_mem0_d_dat,
    input         wb_s2m_mem0_d_ack,
    input         wb_s2m_mem0_d_err,
    input         wb_s2m_mem0_d_rty,
    output [31:0] wb_m2s_mem0_i_adr,
    output [31:0] wb_m2s_mem0_i_dat,
    output  [3:0] wb_m2s_mem0_i_sel,
    output        wb_m2s_mem0_i_we,
    output        wb_m2s_mem0_i_cyc,
    output        wb_m2s_mem0_i_stb,
    output  [2:0] wb_m2s_mem0_i_cti,
    output  [1:0] wb_m2s_mem0_i_bte,
    input  [31:0] wb_s2m_mem0_i_dat,
    input         wb_s2m_mem0_i_ack,
    input         wb_s2m_mem0_i_err,
    input         wb_s2m_mem0_i_rty,
    output [31:0] wb_m2s_uart0_adr,
    output [31:0] wb_m2s_uart0_dat,
    output  [3:0] wb_m2s_uart0_sel,
    output        wb_m2s_uart0_we,
    output        wb_m2s_uart0_cyc,
    output        wb_m2s_uart0_stb,
    output  [2:0] wb_m2s_uart0_cti,
    output  [1:0] wb_m2s_uart0_bte,
    input  [31:0] wb_s2m_uart0_dat,
    input         wb_s2m_uart0_ack,
    input         wb_s2m_uart0_err,
    input         wb_s2m_uart0_rty,
    output [31:0] wb_m2s_mem1_adr,
    output [31:0] wb_m2s_mem1_dat,
    output  [3:0] wb_m2s_mem1_sel,
    output        wb_m2s_mem1_we,
    output        wb_m2s_mem1_cyc,
    output        wb_m2s_mem1_stb,
    output  [2:0] wb_m2s_mem1_cti,
    output  [1:0] wb_m2s_mem1_bte,
    input  [31:0] wb_s2m_mem1_dat,
    input         wb_s2m_mem1_ack,
    input         wb_s2m_mem1_err,
    input         wb_s2m_mem1_rty);

wire [31:0] wb_m2s_or1k_i_mem1_adr;
wire [31:0] wb_m2s_or1k_i_mem1_dat;
wire  [3:0] wb_m2s_or1k_i_mem1_sel;
wire        wb_m2s_or1k_i_mem1_we;
wire        wb_m2s_or1k_i_mem1_cyc;
wire        wb_m2s_or1k_i_mem1_stb;
wire  [2:0] wb_m2s_or1k_i_mem1_cti;
wire  [1:0] wb_m2s_or1k_i_mem1_bte;
wire [31:0] wb_s2m_or1k_i_mem1_dat;
wire        wb_s2m_or1k_i_mem1_ack;
wire        wb_s2m_or1k_i_mem1_err;
wire        wb_s2m_or1k_i_mem1_rty;
wire [31:0] wb_m2s_or1k_d_mem0_d_adr;
wire [31:0] wb_m2s_or1k_d_mem0_d_dat;
wire  [3:0] wb_m2s_or1k_d_mem0_d_sel;
wire        wb_m2s_or1k_d_mem0_d_we;
wire        wb_m2s_or1k_d_mem0_d_cyc;
wire        wb_m2s_or1k_d_mem0_d_stb;
wire  [2:0] wb_m2s_or1k_d_mem0_d_cti;
wire  [1:0] wb_m2s_or1k_d_mem0_d_bte;
wire [31:0] wb_s2m_or1k_d_mem0_d_dat;
wire        wb_s2m_or1k_d_mem0_d_ack;
wire        wb_s2m_or1k_d_mem0_d_err;
wire        wb_s2m_or1k_d_mem0_d_rty;
wire [31:0] wb_m2s_or1k_d_mem1_adr;
wire [31:0] wb_m2s_or1k_d_mem1_dat;
wire  [3:0] wb_m2s_or1k_d_mem1_sel;
wire        wb_m2s_or1k_d_mem1_we;
wire        wb_m2s_or1k_d_mem1_cyc;
wire        wb_m2s_or1k_d_mem1_stb;
wire  [2:0] wb_m2s_or1k_d_mem1_cti;
wire  [1:0] wb_m2s_or1k_d_mem1_bte;
wire [31:0] wb_s2m_or1k_d_mem1_dat;
wire        wb_s2m_or1k_d_mem1_ack;
wire        wb_s2m_or1k_d_mem1_err;
wire        wb_s2m_or1k_d_mem1_rty;
wire [31:0] wb_m2s_or1k_d_uart0_adr;
wire [31:0] wb_m2s_or1k_d_uart0_dat;
wire  [3:0] wb_m2s_or1k_d_uart0_sel;
wire        wb_m2s_or1k_d_uart0_we;
wire        wb_m2s_or1k_d_uart0_cyc;
wire        wb_m2s_or1k_d_uart0_stb;
wire  [2:0] wb_m2s_or1k_d_uart0_cti;
wire  [1:0] wb_m2s_or1k_d_uart0_bte;
wire [31:0] wb_s2m_or1k_d_uart0_dat;
wire        wb_s2m_or1k_d_uart0_ack;
wire        wb_s2m_or1k_d_uart0_err;
wire        wb_s2m_or1k_d_uart0_rty;
wire [31:0] wb_m2s_or1k_d_gpio0_adr;
wire [31:0] wb_m2s_or1k_d_gpio0_dat;
wire  [3:0] wb_m2s_or1k_d_gpio0_sel;
wire        wb_m2s_or1k_d_gpio0_we;
wire        wb_m2s_or1k_d_gpio0_cyc;
wire        wb_m2s_or1k_d_gpio0_stb;
wire  [2:0] wb_m2s_or1k_d_gpio0_cti;
wire  [1:0] wb_m2s_or1k_d_gpio0_bte;
wire [31:0] wb_s2m_or1k_d_gpio0_dat;
wire        wb_s2m_or1k_d_gpio0_ack;
wire        wb_s2m_or1k_d_gpio0_err;
wire        wb_s2m_or1k_d_gpio0_rty;
wire [31:0] wb_m2s_dbg_mem0_d_adr;
wire [31:0] wb_m2s_dbg_mem0_d_dat;
wire  [3:0] wb_m2s_dbg_mem0_d_sel;
wire        wb_m2s_dbg_mem0_d_we;
wire        wb_m2s_dbg_mem0_d_cyc;
wire        wb_m2s_dbg_mem0_d_stb;
wire  [2:0] wb_m2s_dbg_mem0_d_cti;
wire  [1:0] wb_m2s_dbg_mem0_d_bte;
wire [31:0] wb_s2m_dbg_mem0_d_dat;
wire        wb_s2m_dbg_mem0_d_ack;
wire        wb_s2m_dbg_mem0_d_err;
wire        wb_s2m_dbg_mem0_d_rty;
wire [31:0] wb_m2s_dbg_mem1_adr;
wire [31:0] wb_m2s_dbg_mem1_dat;
wire  [3:0] wb_m2s_dbg_mem1_sel;
wire        wb_m2s_dbg_mem1_we;
wire        wb_m2s_dbg_mem1_cyc;
wire        wb_m2s_dbg_mem1_stb;
wire  [2:0] wb_m2s_dbg_mem1_cti;
wire  [1:0] wb_m2s_dbg_mem1_bte;
wire [31:0] wb_s2m_dbg_mem1_dat;
wire        wb_s2m_dbg_mem1_ack;
wire        wb_s2m_dbg_mem1_err;
wire        wb_s2m_dbg_mem1_rty;
wire [31:0] wb_m2s_dbg_uart0_adr;
wire [31:0] wb_m2s_dbg_uart0_dat;
wire  [3:0] wb_m2s_dbg_uart0_sel;
wire        wb_m2s_dbg_uart0_we;
wire        wb_m2s_dbg_uart0_cyc;
wire        wb_m2s_dbg_uart0_stb;
wire  [2:0] wb_m2s_dbg_uart0_cti;
wire  [1:0] wb_m2s_dbg_uart0_bte;
wire [31:0] wb_s2m_dbg_uart0_dat;
wire        wb_s2m_dbg_uart0_ack;
wire        wb_s2m_dbg_uart0_err;
wire        wb_s2m_dbg_uart0_rty;
wire [31:0] wb_m2s_dbg_gpio0_adr;
wire [31:0] wb_m2s_dbg_gpio0_dat;
wire  [3:0] wb_m2s_dbg_gpio0_sel;
wire        wb_m2s_dbg_gpio0_we;
wire        wb_m2s_dbg_gpio0_cyc;
wire        wb_m2s_dbg_gpio0_stb;
wire  [2:0] wb_m2s_dbg_gpio0_cti;
wire  [1:0] wb_m2s_dbg_gpio0_bte;
wire [31:0] wb_s2m_dbg_gpio0_dat;
wire        wb_s2m_dbg_gpio0_ack;
wire        wb_s2m_dbg_gpio0_err;
wire        wb_s2m_dbg_gpio0_rty;

wb_mux
  #(.num_slaves (3),
    .MATCH_ADDR ({32'h00000000, 32'h40000000, 32'hf0000100}),
    .MATCH_MASK ({32'hc0000000, 32'hc0000000, 32'hffffffc0}))
 wb_mux_or1k_i
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_m2s_or1k_i_adr),
    .wbm_dat_i (wb_m2s_or1k_i_dat),
    .wbm_sel_i (wb_m2s_or1k_i_sel),
    .wbm_we_i  (wb_m2s_or1k_i_we),
    .wbm_cyc_i (wb_m2s_or1k_i_cyc),
    .wbm_stb_i (wb_m2s_or1k_i_stb),
    .wbm_cti_i (wb_m2s_or1k_i_cti),
    .wbm_bte_i (wb_m2s_or1k_i_bte),
    .wbm_dat_o (wb_s2m_or1k_i_dat),
    .wbm_ack_o (wb_s2m_or1k_i_ack),
    .wbm_err_o (wb_s2m_or1k_i_err),
    .wbm_rty_o (wb_s2m_or1k_i_rty),
    .wbs_adr_o ({wb_m2s_mem0_i_adr, wb_m2s_or1k_i_mem1_adr, wb_m2s_rom0_adr}),
    .wbs_dat_o ({wb_m2s_mem0_i_dat, wb_m2s_or1k_i_mem1_dat, wb_m2s_rom0_dat}),
    .wbs_sel_o ({wb_m2s_mem0_i_sel, wb_m2s_or1k_i_mem1_sel, wb_m2s_rom0_sel}),
    .wbs_we_o  ({wb_m2s_mem0_i_we, wb_m2s_or1k_i_mem1_we, wb_m2s_rom0_we}),
    .wbs_cyc_o ({wb_m2s_mem0_i_cyc, wb_m2s_or1k_i_mem1_cyc, wb_m2s_rom0_cyc}),
    .wbs_stb_o ({wb_m2s_mem0_i_stb, wb_m2s_or1k_i_mem1_stb, wb_m2s_rom0_stb}),
    .wbs_cti_o ({wb_m2s_mem0_i_cti, wb_m2s_or1k_i_mem1_cti, wb_m2s_rom0_cti}),
    .wbs_bte_o ({wb_m2s_mem0_i_bte, wb_m2s_or1k_i_mem1_bte, wb_m2s_rom0_bte}),
    .wbs_dat_i ({wb_s2m_mem0_i_dat, wb_s2m_or1k_i_mem1_dat, wb_s2m_rom0_dat}),
    .wbs_ack_i ({wb_s2m_mem0_i_ack, wb_s2m_or1k_i_mem1_ack, wb_s2m_rom0_ack}),
    .wbs_err_i ({wb_s2m_mem0_i_err, wb_s2m_or1k_i_mem1_err, wb_s2m_rom0_err}),
    .wbs_rty_i ({wb_s2m_mem0_i_rty, wb_s2m_or1k_i_mem1_rty, wb_s2m_rom0_rty}));

wb_mux
  #(.num_slaves (4),
    .MATCH_ADDR ({32'h00000000, 32'h40000000, 32'h90000000, 32'h91000000}),
    .MATCH_MASK ({32'hc0000000, 32'hc0000000, 32'hffffffe0, 32'hfffffffe}))
 wb_mux_or1k_d
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_m2s_or1k_d_adr),
    .wbm_dat_i (wb_m2s_or1k_d_dat),
    .wbm_sel_i (wb_m2s_or1k_d_sel),
    .wbm_we_i  (wb_m2s_or1k_d_we),
    .wbm_cyc_i (wb_m2s_or1k_d_cyc),
    .wbm_stb_i (wb_m2s_or1k_d_stb),
    .wbm_cti_i (wb_m2s_or1k_d_cti),
    .wbm_bte_i (wb_m2s_or1k_d_bte),
    .wbm_dat_o (wb_s2m_or1k_d_dat),
    .wbm_ack_o (wb_s2m_or1k_d_ack),
    .wbm_err_o (wb_s2m_or1k_d_err),
    .wbm_rty_o (wb_s2m_or1k_d_rty),
    .wbs_adr_o ({wb_m2s_or1k_d_mem0_d_adr, wb_m2s_or1k_d_mem1_adr, wb_m2s_or1k_d_uart0_adr, wb_m2s_or1k_d_gpio0_adr}),
    .wbs_dat_o ({wb_m2s_or1k_d_mem0_d_dat, wb_m2s_or1k_d_mem1_dat, wb_m2s_or1k_d_uart0_dat, wb_m2s_or1k_d_gpio0_dat}),
    .wbs_sel_o ({wb_m2s_or1k_d_mem0_d_sel, wb_m2s_or1k_d_mem1_sel, wb_m2s_or1k_d_uart0_sel, wb_m2s_or1k_d_gpio0_sel}),
    .wbs_we_o  ({wb_m2s_or1k_d_mem0_d_we, wb_m2s_or1k_d_mem1_we, wb_m2s_or1k_d_uart0_we, wb_m2s_or1k_d_gpio0_we}),
    .wbs_cyc_o ({wb_m2s_or1k_d_mem0_d_cyc, wb_m2s_or1k_d_mem1_cyc, wb_m2s_or1k_d_uart0_cyc, wb_m2s_or1k_d_gpio0_cyc}),
    .wbs_stb_o ({wb_m2s_or1k_d_mem0_d_stb, wb_m2s_or1k_d_mem1_stb, wb_m2s_or1k_d_uart0_stb, wb_m2s_or1k_d_gpio0_stb}),
    .wbs_cti_o ({wb_m2s_or1k_d_mem0_d_cti, wb_m2s_or1k_d_mem1_cti, wb_m2s_or1k_d_uart0_cti, wb_m2s_or1k_d_gpio0_cti}),
    .wbs_bte_o ({wb_m2s_or1k_d_mem0_d_bte, wb_m2s_or1k_d_mem1_bte, wb_m2s_or1k_d_uart0_bte, wb_m2s_or1k_d_gpio0_bte}),
    .wbs_dat_i ({wb_s2m_or1k_d_mem0_d_dat, wb_s2m_or1k_d_mem1_dat, wb_s2m_or1k_d_uart0_dat, wb_s2m_or1k_d_gpio0_dat}),
    .wbs_ack_i ({wb_s2m_or1k_d_mem0_d_ack, wb_s2m_or1k_d_mem1_ack, wb_s2m_or1k_d_uart0_ack, wb_s2m_or1k_d_gpio0_ack}),
    .wbs_err_i ({wb_s2m_or1k_d_mem0_d_err, wb_s2m_or1k_d_mem1_err, wb_s2m_or1k_d_uart0_err, wb_s2m_or1k_d_gpio0_err}),
    .wbs_rty_i ({wb_s2m_or1k_d_mem0_d_rty, wb_s2m_or1k_d_mem1_rty, wb_s2m_or1k_d_uart0_rty, wb_s2m_or1k_d_gpio0_rty}));

wb_mux
  #(.num_slaves (4),
    .MATCH_ADDR ({32'h00000000, 32'h40000000, 32'h90000000, 32'h91000000}),
    .MATCH_MASK ({32'hc0000000, 32'hc0000000, 32'hffffffe0, 32'hfffffffe}))
 wb_mux_dbg
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_m2s_dbg_adr),
    .wbm_dat_i (wb_m2s_dbg_dat),
    .wbm_sel_i (wb_m2s_dbg_sel),
    .wbm_we_i  (wb_m2s_dbg_we),
    .wbm_cyc_i (wb_m2s_dbg_cyc),
    .wbm_stb_i (wb_m2s_dbg_stb),
    .wbm_cti_i (wb_m2s_dbg_cti),
    .wbm_bte_i (wb_m2s_dbg_bte),
    .wbm_dat_o (wb_s2m_dbg_dat),
    .wbm_ack_o (wb_s2m_dbg_ack),
    .wbm_err_o (wb_s2m_dbg_err),
    .wbm_rty_o (wb_s2m_dbg_rty),
    .wbs_adr_o ({wb_m2s_dbg_mem0_d_adr, wb_m2s_dbg_mem1_adr, wb_m2s_dbg_uart0_adr, wb_m2s_dbg_gpio0_adr}),
    .wbs_dat_o ({wb_m2s_dbg_mem0_d_dat, wb_m2s_dbg_mem1_dat, wb_m2s_dbg_uart0_dat, wb_m2s_dbg_gpio0_dat}),
    .wbs_sel_o ({wb_m2s_dbg_mem0_d_sel, wb_m2s_dbg_mem1_sel, wb_m2s_dbg_uart0_sel, wb_m2s_dbg_gpio0_sel}),
    .wbs_we_o  ({wb_m2s_dbg_mem0_d_we, wb_m2s_dbg_mem1_we, wb_m2s_dbg_uart0_we, wb_m2s_dbg_gpio0_we}),
    .wbs_cyc_o ({wb_m2s_dbg_mem0_d_cyc, wb_m2s_dbg_mem1_cyc, wb_m2s_dbg_uart0_cyc, wb_m2s_dbg_gpio0_cyc}),
    .wbs_stb_o ({wb_m2s_dbg_mem0_d_stb, wb_m2s_dbg_mem1_stb, wb_m2s_dbg_uart0_stb, wb_m2s_dbg_gpio0_stb}),
    .wbs_cti_o ({wb_m2s_dbg_mem0_d_cti, wb_m2s_dbg_mem1_cti, wb_m2s_dbg_uart0_cti, wb_m2s_dbg_gpio0_cti}),
    .wbs_bte_o ({wb_m2s_dbg_mem0_d_bte, wb_m2s_dbg_mem1_bte, wb_m2s_dbg_uart0_bte, wb_m2s_dbg_gpio0_bte}),
    .wbs_dat_i ({wb_s2m_dbg_mem0_d_dat, wb_s2m_dbg_mem1_dat, wb_s2m_dbg_uart0_dat, wb_s2m_dbg_gpio0_dat}),
    .wbs_ack_i ({wb_s2m_dbg_mem0_d_ack, wb_s2m_dbg_mem1_ack, wb_s2m_dbg_uart0_ack, wb_s2m_dbg_gpio0_ack}),
    .wbs_err_i ({wb_s2m_dbg_mem0_d_err, wb_s2m_dbg_mem1_err, wb_s2m_dbg_uart0_err, wb_s2m_dbg_gpio0_err}),
    .wbs_rty_i ({wb_s2m_dbg_mem0_d_rty, wb_s2m_dbg_mem1_rty, wb_s2m_dbg_uart0_rty, wb_s2m_dbg_gpio0_rty}));

wb_arbiter
  #(.num_masters (2))
 wb_arbiter_gpio0
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k_d_gpio0_adr, wb_m2s_dbg_gpio0_adr}),
    .wbm_dat_i ({wb_m2s_or1k_d_gpio0_dat, wb_m2s_dbg_gpio0_dat}),
    .wbm_sel_i ({wb_m2s_or1k_d_gpio0_sel, wb_m2s_dbg_gpio0_sel}),
    .wbm_we_i  ({wb_m2s_or1k_d_gpio0_we, wb_m2s_dbg_gpio0_we}),
    .wbm_cyc_i ({wb_m2s_or1k_d_gpio0_cyc, wb_m2s_dbg_gpio0_cyc}),
    .wbm_stb_i ({wb_m2s_or1k_d_gpio0_stb, wb_m2s_dbg_gpio0_stb}),
    .wbm_cti_i ({wb_m2s_or1k_d_gpio0_cti, wb_m2s_dbg_gpio0_cti}),
    .wbm_bte_i ({wb_m2s_or1k_d_gpio0_bte, wb_m2s_dbg_gpio0_bte}),
    .wbm_dat_o ({wb_s2m_or1k_d_gpio0_dat, wb_s2m_dbg_gpio0_dat}),
    .wbm_ack_o ({wb_s2m_or1k_d_gpio0_ack, wb_s2m_dbg_gpio0_ack}),
    .wbm_err_o ({wb_s2m_or1k_d_gpio0_err, wb_s2m_dbg_gpio0_err}),
    .wbm_rty_o ({wb_s2m_or1k_d_gpio0_rty, wb_s2m_dbg_gpio0_rty}),
    .wbs_adr_o (wb_m2s_gpio0_adr),
    .wbs_dat_o (wb_m2s_gpio0_dat),
    .wbs_sel_o (wb_m2s_gpio0_sel),
    .wbs_we_o  (wb_m2s_gpio0_we),
    .wbs_cyc_o (wb_m2s_gpio0_cyc),
    .wbs_stb_o (wb_m2s_gpio0_stb),
    .wbs_cti_o (wb_m2s_gpio0_cti),
    .wbs_bte_o (wb_m2s_gpio0_bte),
    .wbs_dat_i (wb_s2m_gpio0_dat),
    .wbs_ack_i (wb_s2m_gpio0_ack),
    .wbs_err_i (wb_s2m_gpio0_err),
    .wbs_rty_i (wb_s2m_gpio0_rty));

wb_arbiter
  #(.num_masters (2))
 wb_arbiter_mem0_d
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k_d_mem0_d_adr, wb_m2s_dbg_mem0_d_adr}),
    .wbm_dat_i ({wb_m2s_or1k_d_mem0_d_dat, wb_m2s_dbg_mem0_d_dat}),
    .wbm_sel_i ({wb_m2s_or1k_d_mem0_d_sel, wb_m2s_dbg_mem0_d_sel}),
    .wbm_we_i  ({wb_m2s_or1k_d_mem0_d_we, wb_m2s_dbg_mem0_d_we}),
    .wbm_cyc_i ({wb_m2s_or1k_d_mem0_d_cyc, wb_m2s_dbg_mem0_d_cyc}),
    .wbm_stb_i ({wb_m2s_or1k_d_mem0_d_stb, wb_m2s_dbg_mem0_d_stb}),
    .wbm_cti_i ({wb_m2s_or1k_d_mem0_d_cti, wb_m2s_dbg_mem0_d_cti}),
    .wbm_bte_i ({wb_m2s_or1k_d_mem0_d_bte, wb_m2s_dbg_mem0_d_bte}),
    .wbm_dat_o ({wb_s2m_or1k_d_mem0_d_dat, wb_s2m_dbg_mem0_d_dat}),
    .wbm_ack_o ({wb_s2m_or1k_d_mem0_d_ack, wb_s2m_dbg_mem0_d_ack}),
    .wbm_err_o ({wb_s2m_or1k_d_mem0_d_err, wb_s2m_dbg_mem0_d_err}),
    .wbm_rty_o ({wb_s2m_or1k_d_mem0_d_rty, wb_s2m_dbg_mem0_d_rty}),
    .wbs_adr_o (wb_m2s_mem0_d_adr),
    .wbs_dat_o (wb_m2s_mem0_d_dat),
    .wbs_sel_o (wb_m2s_mem0_d_sel),
    .wbs_we_o  (wb_m2s_mem0_d_we),
    .wbs_cyc_o (wb_m2s_mem0_d_cyc),
    .wbs_stb_o (wb_m2s_mem0_d_stb),
    .wbs_cti_o (wb_m2s_mem0_d_cti),
    .wbs_bte_o (wb_m2s_mem0_d_bte),
    .wbs_dat_i (wb_s2m_mem0_d_dat),
    .wbs_ack_i (wb_s2m_mem0_d_ack),
    .wbs_err_i (wb_s2m_mem0_d_err),
    .wbs_rty_i (wb_s2m_mem0_d_rty));

wb_arbiter
  #(.num_masters (2))
 wb_arbiter_uart0
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k_d_uart0_adr, wb_m2s_dbg_uart0_adr}),
    .wbm_dat_i ({wb_m2s_or1k_d_uart0_dat, wb_m2s_dbg_uart0_dat}),
    .wbm_sel_i ({wb_m2s_or1k_d_uart0_sel, wb_m2s_dbg_uart0_sel}),
    .wbm_we_i  ({wb_m2s_or1k_d_uart0_we, wb_m2s_dbg_uart0_we}),
    .wbm_cyc_i ({wb_m2s_or1k_d_uart0_cyc, wb_m2s_dbg_uart0_cyc}),
    .wbm_stb_i ({wb_m2s_or1k_d_uart0_stb, wb_m2s_dbg_uart0_stb}),
    .wbm_cti_i ({wb_m2s_or1k_d_uart0_cti, wb_m2s_dbg_uart0_cti}),
    .wbm_bte_i ({wb_m2s_or1k_d_uart0_bte, wb_m2s_dbg_uart0_bte}),
    .wbm_dat_o ({wb_s2m_or1k_d_uart0_dat, wb_s2m_dbg_uart0_dat}),
    .wbm_ack_o ({wb_s2m_or1k_d_uart0_ack, wb_s2m_dbg_uart0_ack}),
    .wbm_err_o ({wb_s2m_or1k_d_uart0_err, wb_s2m_dbg_uart0_err}),
    .wbm_rty_o ({wb_s2m_or1k_d_uart0_rty, wb_s2m_dbg_uart0_rty}),
    .wbs_adr_o (wb_m2s_uart0_adr),
    .wbs_dat_o (wb_m2s_uart0_dat),
    .wbs_sel_o (wb_m2s_uart0_sel),
    .wbs_we_o  (wb_m2s_uart0_we),
    .wbs_cyc_o (wb_m2s_uart0_cyc),
    .wbs_stb_o (wb_m2s_uart0_stb),
    .wbs_cti_o (wb_m2s_uart0_cti),
    .wbs_bte_o (wb_m2s_uart0_bte),
    .wbs_dat_i (wb_s2m_uart0_dat),
    .wbs_ack_i (wb_s2m_uart0_ack),
    .wbs_err_i (wb_s2m_uart0_err),
    .wbs_rty_i (wb_s2m_uart0_rty));

wb_arbiter
  #(.num_masters (3))
 wb_arbiter_mem1
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k_i_mem1_adr, wb_m2s_or1k_d_mem1_adr, wb_m2s_dbg_mem1_adr}),
    .wbm_dat_i ({wb_m2s_or1k_i_mem1_dat, wb_m2s_or1k_d_mem1_dat, wb_m2s_dbg_mem1_dat}),
    .wbm_sel_i ({wb_m2s_or1k_i_mem1_sel, wb_m2s_or1k_d_mem1_sel, wb_m2s_dbg_mem1_sel}),
    .wbm_we_i  ({wb_m2s_or1k_i_mem1_we, wb_m2s_or1k_d_mem1_we, wb_m2s_dbg_mem1_we}),
    .wbm_cyc_i ({wb_m2s_or1k_i_mem1_cyc, wb_m2s_or1k_d_mem1_cyc, wb_m2s_dbg_mem1_cyc}),
    .wbm_stb_i ({wb_m2s_or1k_i_mem1_stb, wb_m2s_or1k_d_mem1_stb, wb_m2s_dbg_mem1_stb}),
    .wbm_cti_i ({wb_m2s_or1k_i_mem1_cti, wb_m2s_or1k_d_mem1_cti, wb_m2s_dbg_mem1_cti}),
    .wbm_bte_i ({wb_m2s_or1k_i_mem1_bte, wb_m2s_or1k_d_mem1_bte, wb_m2s_dbg_mem1_bte}),
    .wbm_dat_o ({wb_s2m_or1k_i_mem1_dat, wb_s2m_or1k_d_mem1_dat, wb_s2m_dbg_mem1_dat}),
    .wbm_ack_o ({wb_s2m_or1k_i_mem1_ack, wb_s2m_or1k_d_mem1_ack, wb_s2m_dbg_mem1_ack}),
    .wbm_err_o ({wb_s2m_or1k_i_mem1_err, wb_s2m_or1k_d_mem1_err, wb_s2m_dbg_mem1_err}),
    .wbm_rty_o ({wb_s2m_or1k_i_mem1_rty, wb_s2m_or1k_d_mem1_rty, wb_s2m_dbg_mem1_rty}),
    .wbs_adr_o (wb_m2s_mem1_adr),
    .wbs_dat_o (wb_m2s_mem1_dat),
    .wbs_sel_o (wb_m2s_mem1_sel),
    .wbs_we_o  (wb_m2s_mem1_we),
    .wbs_cyc_o (wb_m2s_mem1_cyc),
    .wbs_stb_o (wb_m2s_mem1_stb),
    .wbs_cti_o (wb_m2s_mem1_cti),
    .wbs_bte_o (wb_m2s_mem1_bte),
    .wbs_dat_i (wb_s2m_mem1_dat),
    .wbs_ack_i (wb_s2m_mem1_ack),
    .wbs_err_i (wb_s2m_mem1_err),
    .wbs_rty_i (wb_s2m_mem1_rty));

endmodule
