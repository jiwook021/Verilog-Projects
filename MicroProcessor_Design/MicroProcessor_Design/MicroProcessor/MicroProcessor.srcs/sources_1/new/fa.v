`timescale 1ns / 1ps
module fa(c_in,x_in,y_in,sum,carry);
input c_in, x_in, y_in;
output sum, carry;
assign sum=x_in^y_in^c_in;
assign carry=(x_in&y_in&c_in)|(x_in&y_in)|(x_in&c_in)|(y_in&c_in);
endmodule