`timescale 1ns / 1ps
module acc(ah_reset,clr,clk,ah_in,ah_inen,aludata, carry_out,hs,ls,
ah_out,al_out);
input ah_reset,clr,clk,ah_inen,carry_out;
input [1:0] hs;
input [1:0] ls;
input [3:0] aludata;
input [3:0] ah_in;
output [3:0] ah_out;
output [3:0] al_out;
wire [3:0] a;
assign a=(ah_inen)?ah_in : aludata; //MUX
//shregi(carry_msb,carry_lsb,c(선택단자),clr,clk,data_in, data_out)
shreg shreg_ah(.carry_msb(carry_out),.carry_lsb(al_out[3]),.c(hs),
.clr((clr|ah_reset)),.clk(clk),.data_in(a),.data_out(ah_out));
shreg shreg_al(ah_out[0],carry_out,ls,clr,clk,ah_out,al_out);
endmodule