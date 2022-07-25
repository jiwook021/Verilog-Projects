`timescale 1ns / 1ps
module hex2dec(h, dec_h, dec_l);
input [7:0] h;
output [3:0]dec_h, dec_l;
wire [3:0] a,b,c,d,e,f,innerdata;
wire cout,overten;
assign a[3]=h[6]&h[4];
assign a[2]=(h[5]&h[4])|(h[6]&~h[4]);
assign a[1]=(~h[4])&(h[6]^h[5]);
assign a[0]=(~h[6])&(h[5]^h[4]);
assign b[3]=h[5]&h[4];
assign b[2]=(~h[5])&(h[6]^h[4]);
assign b[1]=(~h[6])&(h[5]^h[4]);
assign b[0]=0;
assign c[3:1]=0;
assign c[0]=h[3]&(h[2]|h[1]);
assign d[3]=h[3]&~(h[2]|h[1]);
assign d[2]=h[2]&((~h[3])|(h[3]&h[1]));
assign
d[1]=((~h[3])&h[1])|(h[3]&h[2]&(~h[1
]));
assign d[0]=h[0];
assign e = a+c;
assign {cout,f} = b+d;
assign innerdata =
{1'b0,{2{overten|cout}},1'b0};
assign overten = (f>9);
assign dec_h = (overten|cout)+e;
assign dec_l = f+innerdata;
endmodule
