`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/08 20:38:00
// Design Name: 
// Module Name: Subtractor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Subtractor(input [3:0] A, input [3:0] B, input Cin, output [3:0] Sum, output N, Z, Cout, V);
    
    wire C1, C2, C3;
    
    FA1 Sub_m1 (A[0], ~B[0], 1'b1, Sum[0], C1);
    FA1 Sub_m2 (A[1], ~B[1], C1, Sum[1], C2);
    FA1 Sub_m3 (A[2], ~B[2], C2, Sum[2], C3);
    FA1 Sub_m4 (A[3], ~B[3], C3, Sum[3], Cout);
    
    assign N = Sum[3];
    assign Z = (Sum == 4'd0) ? 1 : 0;
    assign V = C3 ^ Cout;
endmodule
