`timescale 1ns / 1ps
module mx4to1(n,s,dout);
input [3:0] n;
input [1:0] s;
output dout;
reg a;
always @(s, n) begin
case(s)
2'b00 : a=n[0];
2'b01 : a=n[1];
2'b10 : a=n[2];
2'b11 : a=n[3];
endcase
end
assign dout = a;
endmodule