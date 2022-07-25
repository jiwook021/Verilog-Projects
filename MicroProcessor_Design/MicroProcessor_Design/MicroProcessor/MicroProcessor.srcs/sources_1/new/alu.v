`timescale 1ns / 1ps
module register(d,q,clk,clr,inen);
input d, clk, clr, inen;
output q;
reg st;
always @(posedge clk, posedge clr)
begin
if(clr) st=1'b0;
else if (inen) st=d;
else st=st;
end
assign q=st;
endmodule

module alu(alu_sub,alu_div,AH_in,BREG_in,alu_and,ALU_out,Fa_cout,clk,clr,alu_add,alu_mul,al_lsb,sign_flag,carry_flag,zero_flag);
    input alu_sub, alu_div, alu_and,clk,clr,alu_add,alu_mul,al_lsb;
    input [3:0] AH_in;
    input [3:0] BREG_in;
    output [3:0] ALU_out;
    output Fa_cout,sign_flag,carry_flag,zero_flag;
    wire [3:0] a;
    wire ze;
    fa4 fa4(AH_in,BREG_in,(alu_sub|alu_div),a,Fa_cout);
    assign ALU_out=(alu_and)?(AH_in&BREG_in):a;
    register SIGN_F((!(Fa_cout)&alu_sub),sign_flag,clk,clr,alu_sub);
    register CARRY_F(((alu_add|alu_div|(alu_mul&al_lsb)) &Fa_cout),carry_flag,clk,clr,1'b1);
    assign ze=(a)?1'b0:1'b1;
    register ZERO_F(ze,zero_flag,clk,clr,alu_sub);
endmodule

