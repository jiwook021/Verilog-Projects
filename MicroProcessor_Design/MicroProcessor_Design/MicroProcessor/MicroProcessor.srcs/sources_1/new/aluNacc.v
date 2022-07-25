`timescale 1ns / 1ps
module aluNacc(ah_reset,ah_inen,s_sub,s_and,s_div, s_add,s_mul,
clr,acc_oen,clk,breg_in,bus_in,hs,ls,sign_flag,zero_flag,acc_out);

input ah_reset,ah_inen,s_sub,s_and,s_div,s_add, s_mul,clr,acc_oen,clk;
input [3:0] breg_in;
input [3:0] bus_in;
input [1:0] hs;
input [1:0] ls;
output sign_flag, zero_flag;
output [7:0] acc_out;
wire [3:0] ah_out, al_out, aluout;
wire c_out;
wire [1:0] acc_hs;
assign acc_hs[1]=(s_mul|s_div)?(s_mul&al_out[0])| (s_div&c_out) : hs[1];
assign acc_hs[0]=(s_mul|s_div)?(s_mul&al_out[0])| (s_div&c_out) : hs[0];
acc u0(ah_reset,clr,clk,bus_in,ah_inen,aluout,carry_flag,acc_hs,ls,ah_out,al_out);
assign acc_out=(acc_oen)?{ah_out, al_out} : 8'bz; //Tri-state buffer
alu u1(s_sub,s_div,ah_out,breg_in,s_and,aluout, c_out,clk,clr,s_add, s_mul,al_out[0],sign_flag,carry_flag,zero_flag);
endmodule