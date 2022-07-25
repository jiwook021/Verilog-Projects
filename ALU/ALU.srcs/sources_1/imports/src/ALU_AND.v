`timescale 1ns / 1ps

module ALU_AND(input [3:0] A, input [3:0] B, output [3:0] result);
    
    assign result = A & B;

endmodule
