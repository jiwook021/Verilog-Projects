`timescale 1ns / 1ps
module fa4(x_in,y_in,c_in,sum,cout);
input [3:0] x_in;
input [3:0] y_in;
input c_in;
output [3:0] sum;
output cout;
wire c1,c2,c3;
fa fa0(x_in[0],(y_in[0]^c_in),c_in,sum[0],c1);
fa fa1(x_in[1],(y_in[1]^c_in),c1,sum[1],c2);
fa fa2(x_in[2],(y_in[2]^c_in),c2,sum[2],c3);
fa fa3(x_in[3],(y_in[3]^c_in),c3,sum[3],cout);
endmodule