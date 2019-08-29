// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Mon Aug 12 12:04:46 2019
// Host        : DESKTOP-SI7IBPD running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/Users/Docs/2.Vivado_projects/ArtyA7_SDcard_readwrite/ArtyA7_SDcard_readwrite.srcs/sources_1/bd/design_1/ip/design_1_PmodSD_0_0/design_1_PmodSD_0_0_stub.v
// Design      : design_1_PmodSD_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "PmodSD,Vivado 2018.3" *)
module design_1_PmodSD_0_0(AXI_LITE_SDCS_araddr, 
  AXI_LITE_SDCS_arready, AXI_LITE_SDCS_arvalid, AXI_LITE_SDCS_awaddr, 
  AXI_LITE_SDCS_awready, AXI_LITE_SDCS_awvalid, AXI_LITE_SDCS_bready, 
  AXI_LITE_SDCS_bresp, AXI_LITE_SDCS_bvalid, AXI_LITE_SDCS_rdata, AXI_LITE_SDCS_rready, 
  AXI_LITE_SDCS_rresp, AXI_LITE_SDCS_rvalid, AXI_LITE_SDCS_wdata, AXI_LITE_SDCS_wready, 
  AXI_LITE_SDCS_wstrb, AXI_LITE_SDCS_wvalid, AXI_LITE_SPI_araddr, AXI_LITE_SPI_arready, 
  AXI_LITE_SPI_arvalid, AXI_LITE_SPI_awaddr, AXI_LITE_SPI_awready, AXI_LITE_SPI_awvalid, 
  AXI_LITE_SPI_bready, AXI_LITE_SPI_bresp, AXI_LITE_SPI_bvalid, AXI_LITE_SPI_rdata, 
  AXI_LITE_SPI_rready, AXI_LITE_SPI_rresp, AXI_LITE_SPI_rvalid, AXI_LITE_SPI_wdata, 
  AXI_LITE_SPI_wready, AXI_LITE_SPI_wstrb, AXI_LITE_SPI_wvalid, Pmod_out_pin10_i, 
  Pmod_out_pin10_o, Pmod_out_pin10_t, Pmod_out_pin1_i, Pmod_out_pin1_o, Pmod_out_pin1_t, 
  Pmod_out_pin2_i, Pmod_out_pin2_o, Pmod_out_pin2_t, Pmod_out_pin3_i, Pmod_out_pin3_o, 
  Pmod_out_pin3_t, Pmod_out_pin4_i, Pmod_out_pin4_o, Pmod_out_pin4_t, Pmod_out_pin7_i, 
  Pmod_out_pin7_o, Pmod_out_pin7_t, Pmod_out_pin8_i, Pmod_out_pin8_o, Pmod_out_pin8_t, 
  Pmod_out_pin9_i, Pmod_out_pin9_o, Pmod_out_pin9_t, s_axi_aclk, s_axi_aresetn)
/* synthesis syn_black_box black_box_pad_pin="AXI_LITE_SDCS_araddr[8:0],AXI_LITE_SDCS_arready,AXI_LITE_SDCS_arvalid,AXI_LITE_SDCS_awaddr[8:0],AXI_LITE_SDCS_awready,AXI_LITE_SDCS_awvalid,AXI_LITE_SDCS_bready,AXI_LITE_SDCS_bresp[1:0],AXI_LITE_SDCS_bvalid,AXI_LITE_SDCS_rdata[31:0],AXI_LITE_SDCS_rready,AXI_LITE_SDCS_rresp[1:0],AXI_LITE_SDCS_rvalid,AXI_LITE_SDCS_wdata[31:0],AXI_LITE_SDCS_wready,AXI_LITE_SDCS_wstrb[3:0],AXI_LITE_SDCS_wvalid,AXI_LITE_SPI_araddr[6:0],AXI_LITE_SPI_arready,AXI_LITE_SPI_arvalid,AXI_LITE_SPI_awaddr[6:0],AXI_LITE_SPI_awready,AXI_LITE_SPI_awvalid,AXI_LITE_SPI_bready,AXI_LITE_SPI_bresp[1:0],AXI_LITE_SPI_bvalid,AXI_LITE_SPI_rdata[31:0],AXI_LITE_SPI_rready,AXI_LITE_SPI_rresp[1:0],AXI_LITE_SPI_rvalid,AXI_LITE_SPI_wdata[31:0],AXI_LITE_SPI_wready,AXI_LITE_SPI_wstrb[3:0],AXI_LITE_SPI_wvalid,Pmod_out_pin10_i,Pmod_out_pin10_o,Pmod_out_pin10_t,Pmod_out_pin1_i,Pmod_out_pin1_o,Pmod_out_pin1_t,Pmod_out_pin2_i,Pmod_out_pin2_o,Pmod_out_pin2_t,Pmod_out_pin3_i,Pmod_out_pin3_o,Pmod_out_pin3_t,Pmod_out_pin4_i,Pmod_out_pin4_o,Pmod_out_pin4_t,Pmod_out_pin7_i,Pmod_out_pin7_o,Pmod_out_pin7_t,Pmod_out_pin8_i,Pmod_out_pin8_o,Pmod_out_pin8_t,Pmod_out_pin9_i,Pmod_out_pin9_o,Pmod_out_pin9_t,s_axi_aclk,s_axi_aresetn" */;
  input [8:0]AXI_LITE_SDCS_araddr;
  output AXI_LITE_SDCS_arready;
  input AXI_LITE_SDCS_arvalid;
  input [8:0]AXI_LITE_SDCS_awaddr;
  output AXI_LITE_SDCS_awready;
  input AXI_LITE_SDCS_awvalid;
  input AXI_LITE_SDCS_bready;
  output [1:0]AXI_LITE_SDCS_bresp;
  output AXI_LITE_SDCS_bvalid;
  output [31:0]AXI_LITE_SDCS_rdata;
  input AXI_LITE_SDCS_rready;
  output [1:0]AXI_LITE_SDCS_rresp;
  output AXI_LITE_SDCS_rvalid;
  input [31:0]AXI_LITE_SDCS_wdata;
  output AXI_LITE_SDCS_wready;
  input [3:0]AXI_LITE_SDCS_wstrb;
  input AXI_LITE_SDCS_wvalid;
  input [6:0]AXI_LITE_SPI_araddr;
  output AXI_LITE_SPI_arready;
  input AXI_LITE_SPI_arvalid;
  input [6:0]AXI_LITE_SPI_awaddr;
  output AXI_LITE_SPI_awready;
  input AXI_LITE_SPI_awvalid;
  input AXI_LITE_SPI_bready;
  output [1:0]AXI_LITE_SPI_bresp;
  output AXI_LITE_SPI_bvalid;
  output [31:0]AXI_LITE_SPI_rdata;
  input AXI_LITE_SPI_rready;
  output [1:0]AXI_LITE_SPI_rresp;
  output AXI_LITE_SPI_rvalid;
  input [31:0]AXI_LITE_SPI_wdata;
  output AXI_LITE_SPI_wready;
  input [3:0]AXI_LITE_SPI_wstrb;
  input AXI_LITE_SPI_wvalid;
  input Pmod_out_pin10_i;
  output Pmod_out_pin10_o;
  output Pmod_out_pin10_t;
  input Pmod_out_pin1_i;
  output Pmod_out_pin1_o;
  output Pmod_out_pin1_t;
  input Pmod_out_pin2_i;
  output Pmod_out_pin2_o;
  output Pmod_out_pin2_t;
  input Pmod_out_pin3_i;
  output Pmod_out_pin3_o;
  output Pmod_out_pin3_t;
  input Pmod_out_pin4_i;
  output Pmod_out_pin4_o;
  output Pmod_out_pin4_t;
  input Pmod_out_pin7_i;
  output Pmod_out_pin7_o;
  output Pmod_out_pin7_t;
  input Pmod_out_pin8_i;
  output Pmod_out_pin8_o;
  output Pmod_out_pin8_t;
  input Pmod_out_pin9_i;
  output Pmod_out_pin9_o;
  output Pmod_out_pin9_t;
  input s_axi_aclk;
  input s_axi_aresetn;
endmodule
