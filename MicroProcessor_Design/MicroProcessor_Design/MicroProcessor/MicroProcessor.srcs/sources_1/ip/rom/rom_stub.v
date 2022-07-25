// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Sun Apr 17 17:03:05 2022
// Host        : DESKTOP-9NPK4EB running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/jiwoo/Desktop/MicroProcessor_Design/MicroProcessor/MicroProcessor.srcs/sources_1/ip/rom/rom_stub.v
// Design      : rom
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a50tcsg324-3
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2019.2" *)
module rom(a, qspo_ce, spo)
/* synthesis syn_black_box black_box_pad_pin="a[7:0],qspo_ce,spo[7:0]" */;
  input [7:0]a;
  input qspo_ce;
  output [7:0]spo;
endmodule
