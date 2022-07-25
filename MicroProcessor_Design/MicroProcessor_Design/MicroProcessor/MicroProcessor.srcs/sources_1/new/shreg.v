`timescale 1ns / 1ps
module shreg(carry_msb,carry_lsb,c,clr,clk,data_in, data_out);
input carry_msb, carry_lsb, clr, clk;
input [1:0] c;
input [3:0] data_in;
output [3:0] data_out;
wire [3:0] a;
mx4to1 mx0({data_in[3],data_out[2],carry_msb,data_out[3]},c,a[3]);
mx4to1 mx1({data_in[2],data_out[1],data_out[3],data_out[2]},c,a[2]);
mx4to1 mx2({data_in[1],data_out[0],data_out[2],data_out[1]},c,a[1]);
mx4to1 mx3({data_in[0],carry_lsb,data_out[1],data_out[0]},c,a[0]);
reg4 reg4(data_out,a,1'b1, 1'b1, clk, clr);
endmodule
