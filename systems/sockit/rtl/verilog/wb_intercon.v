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
    input  [31:0] wb_m2s_h2f_lw_adr,
    input  [31:0] wb_m2s_h2f_lw_dat,
    input   [3:0] wb_m2s_h2f_lw_sel,
    input         wb_m2s_h2f_lw_we,
    input         wb_m2s_h2f_lw_cyc,
    input         wb_m2s_h2f_lw_stb,
    input   [2:0] wb_m2s_h2f_lw_cti,
    input   [1:0] wb_m2s_h2f_lw_bte,
    output [31:0] wb_s2m_h2f_lw_dat,
    output        wb_s2m_h2f_lw_ack,
    output        wb_s2m_h2f_lw_err,
    output        wb_s2m_h2f_lw_rty,
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
    output [31:0] wb_m2s_fpga_ddr3_adr,
    output [31:0] wb_m2s_fpga_ddr3_dat,
    output  [3:0] wb_m2s_fpga_ddr3_sel,
    output        wb_m2s_fpga_ddr3_we,
    output        wb_m2s_fpga_ddr3_cyc,
    output        wb_m2s_fpga_ddr3_stb,
    output  [2:0] wb_m2s_fpga_ddr3_cti,
    output  [1:0] wb_m2s_fpga_ddr3_bte,
    input  [31:0] wb_s2m_fpga_ddr3_dat,
    input         wb_s2m_fpga_ddr3_ack,
    input         wb_s2m_fpga_ddr3_err,
    input         wb_s2m_fpga_ddr3_rty,
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
    output [31:0] wb_m2s_hps_ddr3_adr,
    output [31:0] wb_m2s_hps_ddr3_dat,
    output  [3:0] wb_m2s_hps_ddr3_sel,
    output        wb_m2s_hps_ddr3_we,
    output        wb_m2s_hps_ddr3_cyc,
    output        wb_m2s_hps_ddr3_stb,
    output  [2:0] wb_m2s_hps_ddr3_cti,
    output  [1:0] wb_m2s_hps_ddr3_bte,
    input  [31:0] wb_s2m_hps_ddr3_dat,
    input         wb_s2m_hps_ddr3_ack,
    input         wb_s2m_hps_ddr3_err,
    input         wb_s2m_hps_ddr3_rty,
    output [31:0] wb_m2s_clkgen_adr,
    output [31:0] wb_m2s_clkgen_dat,
    output  [3:0] wb_m2s_clkgen_sel,
    output        wb_m2s_clkgen_we,
    output        wb_m2s_clkgen_cyc,
    output        wb_m2s_clkgen_stb,
    output  [2:0] wb_m2s_clkgen_cti,
    output  [1:0] wb_m2s_clkgen_bte,
    input  [31:0] wb_s2m_clkgen_dat,
    input         wb_s2m_clkgen_ack,
    input         wb_s2m_clkgen_err,
    input         wb_s2m_clkgen_rty,
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
    output [31:0] wb_m2s_sram0_adr,
    output [31:0] wb_m2s_sram0_dat,
    output  [3:0] wb_m2s_sram0_sel,
    output        wb_m2s_sram0_we,
    output        wb_m2s_sram0_cyc,
    output        wb_m2s_sram0_stb,
    output  [2:0] wb_m2s_sram0_cti,
    output  [1:0] wb_m2s_sram0_bte,
    input  [31:0] wb_s2m_sram0_dat,
    input         wb_s2m_sram0_ack,
    input         wb_s2m_sram0_err,
    input         wb_s2m_sram0_rty,
    output [31:0] wb_m2s_diila_adr,
    output [31:0] wb_m2s_diila_dat,
    output  [3:0] wb_m2s_diila_sel,
    output        wb_m2s_diila_we,
    output        wb_m2s_diila_cyc,
    output        wb_m2s_diila_stb,
    output  [2:0] wb_m2s_diila_cti,
    output  [1:0] wb_m2s_diila_bte,
    input  [31:0] wb_s2m_diila_dat,
    input         wb_s2m_diila_ack,
    input         wb_s2m_diila_err,
    input         wb_s2m_diila_rty);

wire [31:0] wb_m2s_or1k_i_hps_ddr3_adr;
wire [31:0] wb_m2s_or1k_i_hps_ddr3_dat;
wire  [3:0] wb_m2s_or1k_i_hps_ddr3_sel;
wire        wb_m2s_or1k_i_hps_ddr3_we;
wire        wb_m2s_or1k_i_hps_ddr3_cyc;
wire        wb_m2s_or1k_i_hps_ddr3_stb;
wire  [2:0] wb_m2s_or1k_i_hps_ddr3_cti;
wire  [1:0] wb_m2s_or1k_i_hps_ddr3_bte;
wire [31:0] wb_s2m_or1k_i_hps_ddr3_dat;
wire        wb_s2m_or1k_i_hps_ddr3_ack;
wire        wb_s2m_or1k_i_hps_ddr3_err;
wire        wb_s2m_or1k_i_hps_ddr3_rty;
wire [31:0] wb_m2s_or1k_i_fpga_ddr3_adr;
wire [31:0] wb_m2s_or1k_i_fpga_ddr3_dat;
wire  [3:0] wb_m2s_or1k_i_fpga_ddr3_sel;
wire        wb_m2s_or1k_i_fpga_ddr3_we;
wire        wb_m2s_or1k_i_fpga_ddr3_cyc;
wire        wb_m2s_or1k_i_fpga_ddr3_stb;
wire  [2:0] wb_m2s_or1k_i_fpga_ddr3_cti;
wire  [1:0] wb_m2s_or1k_i_fpga_ddr3_bte;
wire [31:0] wb_s2m_or1k_i_fpga_ddr3_dat;
wire        wb_s2m_or1k_i_fpga_ddr3_ack;
wire        wb_s2m_or1k_i_fpga_ddr3_err;
wire        wb_s2m_or1k_i_fpga_ddr3_rty;
wire [31:0] wb_m2s_or1k_i_sram0_adr;
wire [31:0] wb_m2s_or1k_i_sram0_dat;
wire  [3:0] wb_m2s_or1k_i_sram0_sel;
wire        wb_m2s_or1k_i_sram0_we;
wire        wb_m2s_or1k_i_sram0_cyc;
wire        wb_m2s_or1k_i_sram0_stb;
wire  [2:0] wb_m2s_or1k_i_sram0_cti;
wire  [1:0] wb_m2s_or1k_i_sram0_bte;
wire [31:0] wb_s2m_or1k_i_sram0_dat;
wire        wb_s2m_or1k_i_sram0_ack;
wire        wb_s2m_or1k_i_sram0_err;
wire        wb_s2m_or1k_i_sram0_rty;
wire [31:0] wb_m2s_h2f_lw_uart0_adr;
wire [31:0] wb_m2s_h2f_lw_uart0_dat;
wire  [3:0] wb_m2s_h2f_lw_uart0_sel;
wire        wb_m2s_h2f_lw_uart0_we;
wire        wb_m2s_h2f_lw_uart0_cyc;
wire        wb_m2s_h2f_lw_uart0_stb;
wire  [2:0] wb_m2s_h2f_lw_uart0_cti;
wire  [1:0] wb_m2s_h2f_lw_uart0_bte;
wire [31:0] wb_s2m_h2f_lw_uart0_dat;
wire        wb_s2m_h2f_lw_uart0_ack;
wire        wb_s2m_h2f_lw_uart0_err;
wire        wb_s2m_h2f_lw_uart0_rty;
wire [31:0] wb_m2s_h2f_lw_gpio0_adr;
wire [31:0] wb_m2s_h2f_lw_gpio0_dat;
wire  [3:0] wb_m2s_h2f_lw_gpio0_sel;
wire        wb_m2s_h2f_lw_gpio0_we;
wire        wb_m2s_h2f_lw_gpio0_cyc;
wire        wb_m2s_h2f_lw_gpio0_stb;
wire  [2:0] wb_m2s_h2f_lw_gpio0_cti;
wire  [1:0] wb_m2s_h2f_lw_gpio0_bte;
wire [31:0] wb_s2m_h2f_lw_gpio0_dat;
wire        wb_s2m_h2f_lw_gpio0_ack;
wire        wb_s2m_h2f_lw_gpio0_err;
wire        wb_s2m_h2f_lw_gpio0_rty;
wire [31:0] wb_m2s_h2f_lw_clkgen_adr;
wire [31:0] wb_m2s_h2f_lw_clkgen_dat;
wire  [3:0] wb_m2s_h2f_lw_clkgen_sel;
wire        wb_m2s_h2f_lw_clkgen_we;
wire        wb_m2s_h2f_lw_clkgen_cyc;
wire        wb_m2s_h2f_lw_clkgen_stb;
wire  [2:0] wb_m2s_h2f_lw_clkgen_cti;
wire  [1:0] wb_m2s_h2f_lw_clkgen_bte;
wire [31:0] wb_s2m_h2f_lw_clkgen_dat;
wire        wb_s2m_h2f_lw_clkgen_ack;
wire        wb_s2m_h2f_lw_clkgen_err;
wire        wb_s2m_h2f_lw_clkgen_rty;
wire [31:0] wb_m2s_or1k_d_hps_ddr3_adr;
wire [31:0] wb_m2s_or1k_d_hps_ddr3_dat;
wire  [3:0] wb_m2s_or1k_d_hps_ddr3_sel;
wire        wb_m2s_or1k_d_hps_ddr3_we;
wire        wb_m2s_or1k_d_hps_ddr3_cyc;
wire        wb_m2s_or1k_d_hps_ddr3_stb;
wire  [2:0] wb_m2s_or1k_d_hps_ddr3_cti;
wire  [1:0] wb_m2s_or1k_d_hps_ddr3_bte;
wire [31:0] wb_s2m_or1k_d_hps_ddr3_dat;
wire        wb_s2m_or1k_d_hps_ddr3_ack;
wire        wb_s2m_or1k_d_hps_ddr3_err;
wire        wb_s2m_or1k_d_hps_ddr3_rty;
wire [31:0] wb_m2s_or1k_d_fpga_ddr3_adr;
wire [31:0] wb_m2s_or1k_d_fpga_ddr3_dat;
wire  [3:0] wb_m2s_or1k_d_fpga_ddr3_sel;
wire        wb_m2s_or1k_d_fpga_ddr3_we;
wire        wb_m2s_or1k_d_fpga_ddr3_cyc;
wire        wb_m2s_or1k_d_fpga_ddr3_stb;
wire  [2:0] wb_m2s_or1k_d_fpga_ddr3_cti;
wire  [1:0] wb_m2s_or1k_d_fpga_ddr3_bte;
wire [31:0] wb_s2m_or1k_d_fpga_ddr3_dat;
wire        wb_s2m_or1k_d_fpga_ddr3_ack;
wire        wb_s2m_or1k_d_fpga_ddr3_err;
wire        wb_s2m_or1k_d_fpga_ddr3_rty;
wire [31:0] wb_m2s_or1k_d_sram0_adr;
wire [31:0] wb_m2s_or1k_d_sram0_dat;
wire  [3:0] wb_m2s_or1k_d_sram0_sel;
wire        wb_m2s_or1k_d_sram0_we;
wire        wb_m2s_or1k_d_sram0_cyc;
wire        wb_m2s_or1k_d_sram0_stb;
wire  [2:0] wb_m2s_or1k_d_sram0_cti;
wire  [1:0] wb_m2s_or1k_d_sram0_bte;
wire [31:0] wb_s2m_or1k_d_sram0_dat;
wire        wb_s2m_or1k_d_sram0_ack;
wire        wb_s2m_or1k_d_sram0_err;
wire        wb_s2m_or1k_d_sram0_rty;
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
wire [31:0] wb_m2s_or1k_d_clkgen_adr;
wire [31:0] wb_m2s_or1k_d_clkgen_dat;
wire  [3:0] wb_m2s_or1k_d_clkgen_sel;
wire        wb_m2s_or1k_d_clkgen_we;
wire        wb_m2s_or1k_d_clkgen_cyc;
wire        wb_m2s_or1k_d_clkgen_stb;
wire  [2:0] wb_m2s_or1k_d_clkgen_cti;
wire  [1:0] wb_m2s_or1k_d_clkgen_bte;
wire [31:0] wb_s2m_or1k_d_clkgen_dat;
wire        wb_s2m_or1k_d_clkgen_ack;
wire        wb_s2m_or1k_d_clkgen_err;
wire        wb_s2m_or1k_d_clkgen_rty;
wire [31:0] wb_m2s_dbg_hps_ddr3_adr;
wire [31:0] wb_m2s_dbg_hps_ddr3_dat;
wire  [3:0] wb_m2s_dbg_hps_ddr3_sel;
wire        wb_m2s_dbg_hps_ddr3_we;
wire        wb_m2s_dbg_hps_ddr3_cyc;
wire        wb_m2s_dbg_hps_ddr3_stb;
wire  [2:0] wb_m2s_dbg_hps_ddr3_cti;
wire  [1:0] wb_m2s_dbg_hps_ddr3_bte;
wire [31:0] wb_s2m_dbg_hps_ddr3_dat;
wire        wb_s2m_dbg_hps_ddr3_ack;
wire        wb_s2m_dbg_hps_ddr3_err;
wire        wb_s2m_dbg_hps_ddr3_rty;
wire [31:0] wb_m2s_dbg_fpga_ddr3_adr;
wire [31:0] wb_m2s_dbg_fpga_ddr3_dat;
wire  [3:0] wb_m2s_dbg_fpga_ddr3_sel;
wire        wb_m2s_dbg_fpga_ddr3_we;
wire        wb_m2s_dbg_fpga_ddr3_cyc;
wire        wb_m2s_dbg_fpga_ddr3_stb;
wire  [2:0] wb_m2s_dbg_fpga_ddr3_cti;
wire  [1:0] wb_m2s_dbg_fpga_ddr3_bte;
wire [31:0] wb_s2m_dbg_fpga_ddr3_dat;
wire        wb_s2m_dbg_fpga_ddr3_ack;
wire        wb_s2m_dbg_fpga_ddr3_err;
wire        wb_s2m_dbg_fpga_ddr3_rty;
wire [31:0] wb_m2s_dbg_sram0_adr;
wire [31:0] wb_m2s_dbg_sram0_dat;
wire  [3:0] wb_m2s_dbg_sram0_sel;
wire        wb_m2s_dbg_sram0_we;
wire        wb_m2s_dbg_sram0_cyc;
wire        wb_m2s_dbg_sram0_stb;
wire  [2:0] wb_m2s_dbg_sram0_cti;
wire  [1:0] wb_m2s_dbg_sram0_bte;
wire [31:0] wb_s2m_dbg_sram0_dat;
wire        wb_s2m_dbg_sram0_ack;
wire        wb_s2m_dbg_sram0_err;
wire        wb_s2m_dbg_sram0_rty;
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
wire [31:0] wb_m2s_dbg_clkgen_adr;
wire [31:0] wb_m2s_dbg_clkgen_dat;
wire  [3:0] wb_m2s_dbg_clkgen_sel;
wire        wb_m2s_dbg_clkgen_we;
wire        wb_m2s_dbg_clkgen_cyc;
wire        wb_m2s_dbg_clkgen_stb;
wire  [2:0] wb_m2s_dbg_clkgen_cti;
wire  [1:0] wb_m2s_dbg_clkgen_bte;
wire [31:0] wb_s2m_dbg_clkgen_dat;
wire        wb_s2m_dbg_clkgen_ack;
wire        wb_s2m_dbg_clkgen_err;
wire        wb_s2m_dbg_clkgen_rty;

wb_mux
  #(.num_slaves (4),
    .MATCH_ADDR ({32'h40000000, 32'h00000000, 32'h80000000, 32'hf0000100}),
    .MATCH_MASK ({32'hc0000000, 32'hc0000000, 32'hffffe000, 32'hffffffc0}))
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
    .wbs_adr_o ({wb_m2s_or1k_i_hps_ddr3_adr, wb_m2s_or1k_i_fpga_ddr3_adr, wb_m2s_or1k_i_sram0_adr, wb_m2s_rom0_adr}),
    .wbs_dat_o ({wb_m2s_or1k_i_hps_ddr3_dat, wb_m2s_or1k_i_fpga_ddr3_dat, wb_m2s_or1k_i_sram0_dat, wb_m2s_rom0_dat}),
    .wbs_sel_o ({wb_m2s_or1k_i_hps_ddr3_sel, wb_m2s_or1k_i_fpga_ddr3_sel, wb_m2s_or1k_i_sram0_sel, wb_m2s_rom0_sel}),
    .wbs_we_o  ({wb_m2s_or1k_i_hps_ddr3_we, wb_m2s_or1k_i_fpga_ddr3_we, wb_m2s_or1k_i_sram0_we, wb_m2s_rom0_we}),
    .wbs_cyc_o ({wb_m2s_or1k_i_hps_ddr3_cyc, wb_m2s_or1k_i_fpga_ddr3_cyc, wb_m2s_or1k_i_sram0_cyc, wb_m2s_rom0_cyc}),
    .wbs_stb_o ({wb_m2s_or1k_i_hps_ddr3_stb, wb_m2s_or1k_i_fpga_ddr3_stb, wb_m2s_or1k_i_sram0_stb, wb_m2s_rom0_stb}),
    .wbs_cti_o ({wb_m2s_or1k_i_hps_ddr3_cti, wb_m2s_or1k_i_fpga_ddr3_cti, wb_m2s_or1k_i_sram0_cti, wb_m2s_rom0_cti}),
    .wbs_bte_o ({wb_m2s_or1k_i_hps_ddr3_bte, wb_m2s_or1k_i_fpga_ddr3_bte, wb_m2s_or1k_i_sram0_bte, wb_m2s_rom0_bte}),
    .wbs_dat_i ({wb_s2m_or1k_i_hps_ddr3_dat, wb_s2m_or1k_i_fpga_ddr3_dat, wb_s2m_or1k_i_sram0_dat, wb_s2m_rom0_dat}),
    .wbs_ack_i ({wb_s2m_or1k_i_hps_ddr3_ack, wb_s2m_or1k_i_fpga_ddr3_ack, wb_s2m_or1k_i_sram0_ack, wb_s2m_rom0_ack}),
    .wbs_err_i ({wb_s2m_or1k_i_hps_ddr3_err, wb_s2m_or1k_i_fpga_ddr3_err, wb_s2m_or1k_i_sram0_err, wb_s2m_rom0_err}),
    .wbs_rty_i ({wb_s2m_or1k_i_hps_ddr3_rty, wb_s2m_or1k_i_fpga_ddr3_rty, wb_s2m_or1k_i_sram0_rty, wb_s2m_rom0_rty}));

wb_mux
  #(.num_slaves (3),
    .MATCH_ADDR ({32'h90000000, 32'h91000000, 32'h91000100}),
    .MATCH_MASK ({32'hffffffe0, 32'hfffffffe, 32'hffffff00}))
 wb_mux_h2f_lw
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_m2s_h2f_lw_adr),
    .wbm_dat_i (wb_m2s_h2f_lw_dat),
    .wbm_sel_i (wb_m2s_h2f_lw_sel),
    .wbm_we_i  (wb_m2s_h2f_lw_we),
    .wbm_cyc_i (wb_m2s_h2f_lw_cyc),
    .wbm_stb_i (wb_m2s_h2f_lw_stb),
    .wbm_cti_i (wb_m2s_h2f_lw_cti),
    .wbm_bte_i (wb_m2s_h2f_lw_bte),
    .wbm_dat_o (wb_s2m_h2f_lw_dat),
    .wbm_ack_o (wb_s2m_h2f_lw_ack),
    .wbm_err_o (wb_s2m_h2f_lw_err),
    .wbm_rty_o (wb_s2m_h2f_lw_rty),
    .wbs_adr_o ({wb_m2s_h2f_lw_uart0_adr, wb_m2s_h2f_lw_gpio0_adr, wb_m2s_h2f_lw_clkgen_adr}),
    .wbs_dat_o ({wb_m2s_h2f_lw_uart0_dat, wb_m2s_h2f_lw_gpio0_dat, wb_m2s_h2f_lw_clkgen_dat}),
    .wbs_sel_o ({wb_m2s_h2f_lw_uart0_sel, wb_m2s_h2f_lw_gpio0_sel, wb_m2s_h2f_lw_clkgen_sel}),
    .wbs_we_o  ({wb_m2s_h2f_lw_uart0_we, wb_m2s_h2f_lw_gpio0_we, wb_m2s_h2f_lw_clkgen_we}),
    .wbs_cyc_o ({wb_m2s_h2f_lw_uart0_cyc, wb_m2s_h2f_lw_gpio0_cyc, wb_m2s_h2f_lw_clkgen_cyc}),
    .wbs_stb_o ({wb_m2s_h2f_lw_uart0_stb, wb_m2s_h2f_lw_gpio0_stb, wb_m2s_h2f_lw_clkgen_stb}),
    .wbs_cti_o ({wb_m2s_h2f_lw_uart0_cti, wb_m2s_h2f_lw_gpio0_cti, wb_m2s_h2f_lw_clkgen_cti}),
    .wbs_bte_o ({wb_m2s_h2f_lw_uart0_bte, wb_m2s_h2f_lw_gpio0_bte, wb_m2s_h2f_lw_clkgen_bte}),
    .wbs_dat_i ({wb_s2m_h2f_lw_uart0_dat, wb_s2m_h2f_lw_gpio0_dat, wb_s2m_h2f_lw_clkgen_dat}),
    .wbs_ack_i ({wb_s2m_h2f_lw_uart0_ack, wb_s2m_h2f_lw_gpio0_ack, wb_s2m_h2f_lw_clkgen_ack}),
    .wbs_err_i ({wb_s2m_h2f_lw_uart0_err, wb_s2m_h2f_lw_gpio0_err, wb_s2m_h2f_lw_clkgen_err}),
    .wbs_rty_i ({wb_s2m_h2f_lw_uart0_rty, wb_s2m_h2f_lw_gpio0_rty, wb_s2m_h2f_lw_clkgen_rty}));

wb_mux
  #(.num_slaves (6),
    .MATCH_ADDR ({32'h40000000, 32'h00000000, 32'h80000000, 32'h90000000, 32'h91000000, 32'h91000100}),
    .MATCH_MASK ({32'hc0000000, 32'hc0000000, 32'hffffe000, 32'hffffffe0, 32'hfffffffe, 32'hffffff00}))
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
    .wbs_adr_o ({wb_m2s_or1k_d_hps_ddr3_adr, wb_m2s_or1k_d_fpga_ddr3_adr, wb_m2s_or1k_d_sram0_adr, wb_m2s_or1k_d_uart0_adr, wb_m2s_or1k_d_gpio0_adr, wb_m2s_or1k_d_clkgen_adr}),
    .wbs_dat_o ({wb_m2s_or1k_d_hps_ddr3_dat, wb_m2s_or1k_d_fpga_ddr3_dat, wb_m2s_or1k_d_sram0_dat, wb_m2s_or1k_d_uart0_dat, wb_m2s_or1k_d_gpio0_dat, wb_m2s_or1k_d_clkgen_dat}),
    .wbs_sel_o ({wb_m2s_or1k_d_hps_ddr3_sel, wb_m2s_or1k_d_fpga_ddr3_sel, wb_m2s_or1k_d_sram0_sel, wb_m2s_or1k_d_uart0_sel, wb_m2s_or1k_d_gpio0_sel, wb_m2s_or1k_d_clkgen_sel}),
    .wbs_we_o  ({wb_m2s_or1k_d_hps_ddr3_we, wb_m2s_or1k_d_fpga_ddr3_we, wb_m2s_or1k_d_sram0_we, wb_m2s_or1k_d_uart0_we, wb_m2s_or1k_d_gpio0_we, wb_m2s_or1k_d_clkgen_we}),
    .wbs_cyc_o ({wb_m2s_or1k_d_hps_ddr3_cyc, wb_m2s_or1k_d_fpga_ddr3_cyc, wb_m2s_or1k_d_sram0_cyc, wb_m2s_or1k_d_uart0_cyc, wb_m2s_or1k_d_gpio0_cyc, wb_m2s_or1k_d_clkgen_cyc}),
    .wbs_stb_o ({wb_m2s_or1k_d_hps_ddr3_stb, wb_m2s_or1k_d_fpga_ddr3_stb, wb_m2s_or1k_d_sram0_stb, wb_m2s_or1k_d_uart0_stb, wb_m2s_or1k_d_gpio0_stb, wb_m2s_or1k_d_clkgen_stb}),
    .wbs_cti_o ({wb_m2s_or1k_d_hps_ddr3_cti, wb_m2s_or1k_d_fpga_ddr3_cti, wb_m2s_or1k_d_sram0_cti, wb_m2s_or1k_d_uart0_cti, wb_m2s_or1k_d_gpio0_cti, wb_m2s_or1k_d_clkgen_cti}),
    .wbs_bte_o ({wb_m2s_or1k_d_hps_ddr3_bte, wb_m2s_or1k_d_fpga_ddr3_bte, wb_m2s_or1k_d_sram0_bte, wb_m2s_or1k_d_uart0_bte, wb_m2s_or1k_d_gpio0_bte, wb_m2s_or1k_d_clkgen_bte}),
    .wbs_dat_i ({wb_s2m_or1k_d_hps_ddr3_dat, wb_s2m_or1k_d_fpga_ddr3_dat, wb_s2m_or1k_d_sram0_dat, wb_s2m_or1k_d_uart0_dat, wb_s2m_or1k_d_gpio0_dat, wb_s2m_or1k_d_clkgen_dat}),
    .wbs_ack_i ({wb_s2m_or1k_d_hps_ddr3_ack, wb_s2m_or1k_d_fpga_ddr3_ack, wb_s2m_or1k_d_sram0_ack, wb_s2m_or1k_d_uart0_ack, wb_s2m_or1k_d_gpio0_ack, wb_s2m_or1k_d_clkgen_ack}),
    .wbs_err_i ({wb_s2m_or1k_d_hps_ddr3_err, wb_s2m_or1k_d_fpga_ddr3_err, wb_s2m_or1k_d_sram0_err, wb_s2m_or1k_d_uart0_err, wb_s2m_or1k_d_gpio0_err, wb_s2m_or1k_d_clkgen_err}),
    .wbs_rty_i ({wb_s2m_or1k_d_hps_ddr3_rty, wb_s2m_or1k_d_fpga_ddr3_rty, wb_s2m_or1k_d_sram0_rty, wb_s2m_or1k_d_uart0_rty, wb_s2m_or1k_d_gpio0_rty, wb_s2m_or1k_d_clkgen_rty}));

wb_mux
  #(.num_slaves (7),
    .MATCH_ADDR ({32'h40000000, 32'h00000000, 32'h80000000, 32'h90000000, 32'h91000000, 32'h96000000, 32'h91000100}),
    .MATCH_MASK ({32'hc0000000, 32'hc0000000, 32'hffffe000, 32'hffffffe0, 32'hfffffffe, 32'hffb00000, 32'hffffff00}))
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
    .wbs_adr_o ({wb_m2s_dbg_hps_ddr3_adr, wb_m2s_dbg_fpga_ddr3_adr, wb_m2s_dbg_sram0_adr, wb_m2s_dbg_uart0_adr, wb_m2s_dbg_gpio0_adr, wb_m2s_diila_adr, wb_m2s_dbg_clkgen_adr}),
    .wbs_dat_o ({wb_m2s_dbg_hps_ddr3_dat, wb_m2s_dbg_fpga_ddr3_dat, wb_m2s_dbg_sram0_dat, wb_m2s_dbg_uart0_dat, wb_m2s_dbg_gpio0_dat, wb_m2s_diila_dat, wb_m2s_dbg_clkgen_dat}),
    .wbs_sel_o ({wb_m2s_dbg_hps_ddr3_sel, wb_m2s_dbg_fpga_ddr3_sel, wb_m2s_dbg_sram0_sel, wb_m2s_dbg_uart0_sel, wb_m2s_dbg_gpio0_sel, wb_m2s_diila_sel, wb_m2s_dbg_clkgen_sel}),
    .wbs_we_o  ({wb_m2s_dbg_hps_ddr3_we, wb_m2s_dbg_fpga_ddr3_we, wb_m2s_dbg_sram0_we, wb_m2s_dbg_uart0_we, wb_m2s_dbg_gpio0_we, wb_m2s_diila_we, wb_m2s_dbg_clkgen_we}),
    .wbs_cyc_o ({wb_m2s_dbg_hps_ddr3_cyc, wb_m2s_dbg_fpga_ddr3_cyc, wb_m2s_dbg_sram0_cyc, wb_m2s_dbg_uart0_cyc, wb_m2s_dbg_gpio0_cyc, wb_m2s_diila_cyc, wb_m2s_dbg_clkgen_cyc}),
    .wbs_stb_o ({wb_m2s_dbg_hps_ddr3_stb, wb_m2s_dbg_fpga_ddr3_stb, wb_m2s_dbg_sram0_stb, wb_m2s_dbg_uart0_stb, wb_m2s_dbg_gpio0_stb, wb_m2s_diila_stb, wb_m2s_dbg_clkgen_stb}),
    .wbs_cti_o ({wb_m2s_dbg_hps_ddr3_cti, wb_m2s_dbg_fpga_ddr3_cti, wb_m2s_dbg_sram0_cti, wb_m2s_dbg_uart0_cti, wb_m2s_dbg_gpio0_cti, wb_m2s_diila_cti, wb_m2s_dbg_clkgen_cti}),
    .wbs_bte_o ({wb_m2s_dbg_hps_ddr3_bte, wb_m2s_dbg_fpga_ddr3_bte, wb_m2s_dbg_sram0_bte, wb_m2s_dbg_uart0_bte, wb_m2s_dbg_gpio0_bte, wb_m2s_diila_bte, wb_m2s_dbg_clkgen_bte}),
    .wbs_dat_i ({wb_s2m_dbg_hps_ddr3_dat, wb_s2m_dbg_fpga_ddr3_dat, wb_s2m_dbg_sram0_dat, wb_s2m_dbg_uart0_dat, wb_s2m_dbg_gpio0_dat, wb_s2m_diila_dat, wb_s2m_dbg_clkgen_dat}),
    .wbs_ack_i ({wb_s2m_dbg_hps_ddr3_ack, wb_s2m_dbg_fpga_ddr3_ack, wb_s2m_dbg_sram0_ack, wb_s2m_dbg_uart0_ack, wb_s2m_dbg_gpio0_ack, wb_s2m_diila_ack, wb_s2m_dbg_clkgen_ack}),
    .wbs_err_i ({wb_s2m_dbg_hps_ddr3_err, wb_s2m_dbg_fpga_ddr3_err, wb_s2m_dbg_sram0_err, wb_s2m_dbg_uart0_err, wb_s2m_dbg_gpio0_err, wb_s2m_diila_err, wb_s2m_dbg_clkgen_err}),
    .wbs_rty_i ({wb_s2m_dbg_hps_ddr3_rty, wb_s2m_dbg_fpga_ddr3_rty, wb_s2m_dbg_sram0_rty, wb_s2m_dbg_uart0_rty, wb_s2m_dbg_gpio0_rty, wb_s2m_diila_rty, wb_s2m_dbg_clkgen_rty}));

wb_arbiter
  #(.num_masters (3))
 wb_arbiter_fpga_ddr3
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k_i_fpga_ddr3_adr, wb_m2s_or1k_d_fpga_ddr3_adr, wb_m2s_dbg_fpga_ddr3_adr}),
    .wbm_dat_i ({wb_m2s_or1k_i_fpga_ddr3_dat, wb_m2s_or1k_d_fpga_ddr3_dat, wb_m2s_dbg_fpga_ddr3_dat}),
    .wbm_sel_i ({wb_m2s_or1k_i_fpga_ddr3_sel, wb_m2s_or1k_d_fpga_ddr3_sel, wb_m2s_dbg_fpga_ddr3_sel}),
    .wbm_we_i  ({wb_m2s_or1k_i_fpga_ddr3_we, wb_m2s_or1k_d_fpga_ddr3_we, wb_m2s_dbg_fpga_ddr3_we}),
    .wbm_cyc_i ({wb_m2s_or1k_i_fpga_ddr3_cyc, wb_m2s_or1k_d_fpga_ddr3_cyc, wb_m2s_dbg_fpga_ddr3_cyc}),
    .wbm_stb_i ({wb_m2s_or1k_i_fpga_ddr3_stb, wb_m2s_or1k_d_fpga_ddr3_stb, wb_m2s_dbg_fpga_ddr3_stb}),
    .wbm_cti_i ({wb_m2s_or1k_i_fpga_ddr3_cti, wb_m2s_or1k_d_fpga_ddr3_cti, wb_m2s_dbg_fpga_ddr3_cti}),
    .wbm_bte_i ({wb_m2s_or1k_i_fpga_ddr3_bte, wb_m2s_or1k_d_fpga_ddr3_bte, wb_m2s_dbg_fpga_ddr3_bte}),
    .wbm_dat_o ({wb_s2m_or1k_i_fpga_ddr3_dat, wb_s2m_or1k_d_fpga_ddr3_dat, wb_s2m_dbg_fpga_ddr3_dat}),
    .wbm_ack_o ({wb_s2m_or1k_i_fpga_ddr3_ack, wb_s2m_or1k_d_fpga_ddr3_ack, wb_s2m_dbg_fpga_ddr3_ack}),
    .wbm_err_o ({wb_s2m_or1k_i_fpga_ddr3_err, wb_s2m_or1k_d_fpga_ddr3_err, wb_s2m_dbg_fpga_ddr3_err}),
    .wbm_rty_o ({wb_s2m_or1k_i_fpga_ddr3_rty, wb_s2m_or1k_d_fpga_ddr3_rty, wb_s2m_dbg_fpga_ddr3_rty}),
    .wbs_adr_o (wb_m2s_fpga_ddr3_adr),
    .wbs_dat_o (wb_m2s_fpga_ddr3_dat),
    .wbs_sel_o (wb_m2s_fpga_ddr3_sel),
    .wbs_we_o  (wb_m2s_fpga_ddr3_we),
    .wbs_cyc_o (wb_m2s_fpga_ddr3_cyc),
    .wbs_stb_o (wb_m2s_fpga_ddr3_stb),
    .wbs_cti_o (wb_m2s_fpga_ddr3_cti),
    .wbs_bte_o (wb_m2s_fpga_ddr3_bte),
    .wbs_dat_i (wb_s2m_fpga_ddr3_dat),
    .wbs_ack_i (wb_s2m_fpga_ddr3_ack),
    .wbs_err_i (wb_s2m_fpga_ddr3_err),
    .wbs_rty_i (wb_s2m_fpga_ddr3_rty));

wb_arbiter
  #(.num_masters (3))
 wb_arbiter_gpio0
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_h2f_lw_gpio0_adr, wb_m2s_or1k_d_gpio0_adr, wb_m2s_dbg_gpio0_adr}),
    .wbm_dat_i ({wb_m2s_h2f_lw_gpio0_dat, wb_m2s_or1k_d_gpio0_dat, wb_m2s_dbg_gpio0_dat}),
    .wbm_sel_i ({wb_m2s_h2f_lw_gpio0_sel, wb_m2s_or1k_d_gpio0_sel, wb_m2s_dbg_gpio0_sel}),
    .wbm_we_i  ({wb_m2s_h2f_lw_gpio0_we, wb_m2s_or1k_d_gpio0_we, wb_m2s_dbg_gpio0_we}),
    .wbm_cyc_i ({wb_m2s_h2f_lw_gpio0_cyc, wb_m2s_or1k_d_gpio0_cyc, wb_m2s_dbg_gpio0_cyc}),
    .wbm_stb_i ({wb_m2s_h2f_lw_gpio0_stb, wb_m2s_or1k_d_gpio0_stb, wb_m2s_dbg_gpio0_stb}),
    .wbm_cti_i ({wb_m2s_h2f_lw_gpio0_cti, wb_m2s_or1k_d_gpio0_cti, wb_m2s_dbg_gpio0_cti}),
    .wbm_bte_i ({wb_m2s_h2f_lw_gpio0_bte, wb_m2s_or1k_d_gpio0_bte, wb_m2s_dbg_gpio0_bte}),
    .wbm_dat_o ({wb_s2m_h2f_lw_gpio0_dat, wb_s2m_or1k_d_gpio0_dat, wb_s2m_dbg_gpio0_dat}),
    .wbm_ack_o ({wb_s2m_h2f_lw_gpio0_ack, wb_s2m_or1k_d_gpio0_ack, wb_s2m_dbg_gpio0_ack}),
    .wbm_err_o ({wb_s2m_h2f_lw_gpio0_err, wb_s2m_or1k_d_gpio0_err, wb_s2m_dbg_gpio0_err}),
    .wbm_rty_o ({wb_s2m_h2f_lw_gpio0_rty, wb_s2m_or1k_d_gpio0_rty, wb_s2m_dbg_gpio0_rty}),
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
  #(.num_masters (3))
 wb_arbiter_hps_ddr3
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k_i_hps_ddr3_adr, wb_m2s_or1k_d_hps_ddr3_adr, wb_m2s_dbg_hps_ddr3_adr}),
    .wbm_dat_i ({wb_m2s_or1k_i_hps_ddr3_dat, wb_m2s_or1k_d_hps_ddr3_dat, wb_m2s_dbg_hps_ddr3_dat}),
    .wbm_sel_i ({wb_m2s_or1k_i_hps_ddr3_sel, wb_m2s_or1k_d_hps_ddr3_sel, wb_m2s_dbg_hps_ddr3_sel}),
    .wbm_we_i  ({wb_m2s_or1k_i_hps_ddr3_we, wb_m2s_or1k_d_hps_ddr3_we, wb_m2s_dbg_hps_ddr3_we}),
    .wbm_cyc_i ({wb_m2s_or1k_i_hps_ddr3_cyc, wb_m2s_or1k_d_hps_ddr3_cyc, wb_m2s_dbg_hps_ddr3_cyc}),
    .wbm_stb_i ({wb_m2s_or1k_i_hps_ddr3_stb, wb_m2s_or1k_d_hps_ddr3_stb, wb_m2s_dbg_hps_ddr3_stb}),
    .wbm_cti_i ({wb_m2s_or1k_i_hps_ddr3_cti, wb_m2s_or1k_d_hps_ddr3_cti, wb_m2s_dbg_hps_ddr3_cti}),
    .wbm_bte_i ({wb_m2s_or1k_i_hps_ddr3_bte, wb_m2s_or1k_d_hps_ddr3_bte, wb_m2s_dbg_hps_ddr3_bte}),
    .wbm_dat_o ({wb_s2m_or1k_i_hps_ddr3_dat, wb_s2m_or1k_d_hps_ddr3_dat, wb_s2m_dbg_hps_ddr3_dat}),
    .wbm_ack_o ({wb_s2m_or1k_i_hps_ddr3_ack, wb_s2m_or1k_d_hps_ddr3_ack, wb_s2m_dbg_hps_ddr3_ack}),
    .wbm_err_o ({wb_s2m_or1k_i_hps_ddr3_err, wb_s2m_or1k_d_hps_ddr3_err, wb_s2m_dbg_hps_ddr3_err}),
    .wbm_rty_o ({wb_s2m_or1k_i_hps_ddr3_rty, wb_s2m_or1k_d_hps_ddr3_rty, wb_s2m_dbg_hps_ddr3_rty}),
    .wbs_adr_o (wb_m2s_hps_ddr3_adr),
    .wbs_dat_o (wb_m2s_hps_ddr3_dat),
    .wbs_sel_o (wb_m2s_hps_ddr3_sel),
    .wbs_we_o  (wb_m2s_hps_ddr3_we),
    .wbs_cyc_o (wb_m2s_hps_ddr3_cyc),
    .wbs_stb_o (wb_m2s_hps_ddr3_stb),
    .wbs_cti_o (wb_m2s_hps_ddr3_cti),
    .wbs_bte_o (wb_m2s_hps_ddr3_bte),
    .wbs_dat_i (wb_s2m_hps_ddr3_dat),
    .wbs_ack_i (wb_s2m_hps_ddr3_ack),
    .wbs_err_i (wb_s2m_hps_ddr3_err),
    .wbs_rty_i (wb_s2m_hps_ddr3_rty));

wb_arbiter
  #(.num_masters (3))
 wb_arbiter_clkgen
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_h2f_lw_clkgen_adr, wb_m2s_or1k_d_clkgen_adr, wb_m2s_dbg_clkgen_adr}),
    .wbm_dat_i ({wb_m2s_h2f_lw_clkgen_dat, wb_m2s_or1k_d_clkgen_dat, wb_m2s_dbg_clkgen_dat}),
    .wbm_sel_i ({wb_m2s_h2f_lw_clkgen_sel, wb_m2s_or1k_d_clkgen_sel, wb_m2s_dbg_clkgen_sel}),
    .wbm_we_i  ({wb_m2s_h2f_lw_clkgen_we, wb_m2s_or1k_d_clkgen_we, wb_m2s_dbg_clkgen_we}),
    .wbm_cyc_i ({wb_m2s_h2f_lw_clkgen_cyc, wb_m2s_or1k_d_clkgen_cyc, wb_m2s_dbg_clkgen_cyc}),
    .wbm_stb_i ({wb_m2s_h2f_lw_clkgen_stb, wb_m2s_or1k_d_clkgen_stb, wb_m2s_dbg_clkgen_stb}),
    .wbm_cti_i ({wb_m2s_h2f_lw_clkgen_cti, wb_m2s_or1k_d_clkgen_cti, wb_m2s_dbg_clkgen_cti}),
    .wbm_bte_i ({wb_m2s_h2f_lw_clkgen_bte, wb_m2s_or1k_d_clkgen_bte, wb_m2s_dbg_clkgen_bte}),
    .wbm_dat_o ({wb_s2m_h2f_lw_clkgen_dat, wb_s2m_or1k_d_clkgen_dat, wb_s2m_dbg_clkgen_dat}),
    .wbm_ack_o ({wb_s2m_h2f_lw_clkgen_ack, wb_s2m_or1k_d_clkgen_ack, wb_s2m_dbg_clkgen_ack}),
    .wbm_err_o ({wb_s2m_h2f_lw_clkgen_err, wb_s2m_or1k_d_clkgen_err, wb_s2m_dbg_clkgen_err}),
    .wbm_rty_o ({wb_s2m_h2f_lw_clkgen_rty, wb_s2m_or1k_d_clkgen_rty, wb_s2m_dbg_clkgen_rty}),
    .wbs_adr_o (wb_m2s_clkgen_adr),
    .wbs_dat_o (wb_m2s_clkgen_dat),
    .wbs_sel_o (wb_m2s_clkgen_sel),
    .wbs_we_o  (wb_m2s_clkgen_we),
    .wbs_cyc_o (wb_m2s_clkgen_cyc),
    .wbs_stb_o (wb_m2s_clkgen_stb),
    .wbs_cti_o (wb_m2s_clkgen_cti),
    .wbs_bte_o (wb_m2s_clkgen_bte),
    .wbs_dat_i (wb_s2m_clkgen_dat),
    .wbs_ack_i (wb_s2m_clkgen_ack),
    .wbs_err_i (wb_s2m_clkgen_err),
    .wbs_rty_i (wb_s2m_clkgen_rty));

wb_arbiter
  #(.num_masters (3))
 wb_arbiter_uart0
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_h2f_lw_uart0_adr, wb_m2s_or1k_d_uart0_adr, wb_m2s_dbg_uart0_adr}),
    .wbm_dat_i ({wb_m2s_h2f_lw_uart0_dat, wb_m2s_or1k_d_uart0_dat, wb_m2s_dbg_uart0_dat}),
    .wbm_sel_i ({wb_m2s_h2f_lw_uart0_sel, wb_m2s_or1k_d_uart0_sel, wb_m2s_dbg_uart0_sel}),
    .wbm_we_i  ({wb_m2s_h2f_lw_uart0_we, wb_m2s_or1k_d_uart0_we, wb_m2s_dbg_uart0_we}),
    .wbm_cyc_i ({wb_m2s_h2f_lw_uart0_cyc, wb_m2s_or1k_d_uart0_cyc, wb_m2s_dbg_uart0_cyc}),
    .wbm_stb_i ({wb_m2s_h2f_lw_uart0_stb, wb_m2s_or1k_d_uart0_stb, wb_m2s_dbg_uart0_stb}),
    .wbm_cti_i ({wb_m2s_h2f_lw_uart0_cti, wb_m2s_or1k_d_uart0_cti, wb_m2s_dbg_uart0_cti}),
    .wbm_bte_i ({wb_m2s_h2f_lw_uart0_bte, wb_m2s_or1k_d_uart0_bte, wb_m2s_dbg_uart0_bte}),
    .wbm_dat_o ({wb_s2m_h2f_lw_uart0_dat, wb_s2m_or1k_d_uart0_dat, wb_s2m_dbg_uart0_dat}),
    .wbm_ack_o ({wb_s2m_h2f_lw_uart0_ack, wb_s2m_or1k_d_uart0_ack, wb_s2m_dbg_uart0_ack}),
    .wbm_err_o ({wb_s2m_h2f_lw_uart0_err, wb_s2m_or1k_d_uart0_err, wb_s2m_dbg_uart0_err}),
    .wbm_rty_o ({wb_s2m_h2f_lw_uart0_rty, wb_s2m_or1k_d_uart0_rty, wb_s2m_dbg_uart0_rty}),
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
 wb_arbiter_sram0
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k_i_sram0_adr, wb_m2s_or1k_d_sram0_adr, wb_m2s_dbg_sram0_adr}),
    .wbm_dat_i ({wb_m2s_or1k_i_sram0_dat, wb_m2s_or1k_d_sram0_dat, wb_m2s_dbg_sram0_dat}),
    .wbm_sel_i ({wb_m2s_or1k_i_sram0_sel, wb_m2s_or1k_d_sram0_sel, wb_m2s_dbg_sram0_sel}),
    .wbm_we_i  ({wb_m2s_or1k_i_sram0_we, wb_m2s_or1k_d_sram0_we, wb_m2s_dbg_sram0_we}),
    .wbm_cyc_i ({wb_m2s_or1k_i_sram0_cyc, wb_m2s_or1k_d_sram0_cyc, wb_m2s_dbg_sram0_cyc}),
    .wbm_stb_i ({wb_m2s_or1k_i_sram0_stb, wb_m2s_or1k_d_sram0_stb, wb_m2s_dbg_sram0_stb}),
    .wbm_cti_i ({wb_m2s_or1k_i_sram0_cti, wb_m2s_or1k_d_sram0_cti, wb_m2s_dbg_sram0_cti}),
    .wbm_bte_i ({wb_m2s_or1k_i_sram0_bte, wb_m2s_or1k_d_sram0_bte, wb_m2s_dbg_sram0_bte}),
    .wbm_dat_o ({wb_s2m_or1k_i_sram0_dat, wb_s2m_or1k_d_sram0_dat, wb_s2m_dbg_sram0_dat}),
    .wbm_ack_o ({wb_s2m_or1k_i_sram0_ack, wb_s2m_or1k_d_sram0_ack, wb_s2m_dbg_sram0_ack}),
    .wbm_err_o ({wb_s2m_or1k_i_sram0_err, wb_s2m_or1k_d_sram0_err, wb_s2m_dbg_sram0_err}),
    .wbm_rty_o ({wb_s2m_or1k_i_sram0_rty, wb_s2m_or1k_d_sram0_rty, wb_s2m_dbg_sram0_rty}),
    .wbs_adr_o (wb_m2s_sram0_adr),
    .wbs_dat_o (wb_m2s_sram0_dat),
    .wbs_sel_o (wb_m2s_sram0_sel),
    .wbs_we_o  (wb_m2s_sram0_we),
    .wbs_cyc_o (wb_m2s_sram0_cyc),
    .wbs_stb_o (wb_m2s_sram0_stb),
    .wbs_cti_o (wb_m2s_sram0_cti),
    .wbs_bte_o (wb_m2s_sram0_bte),
    .wbs_dat_i (wb_s2m_sram0_dat),
    .wbs_ack_i (wb_s2m_sram0_ack),
    .wbs_err_i (wb_s2m_sram0_err),
    .wbs_rty_i (wb_s2m_sram0_rty));

endmodule
