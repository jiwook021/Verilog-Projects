`timescale 1ns / 1ps

module Top_Module(
    input [3:0] A, 
    input [3:0] B, 
    input Cin, 
    output [4:0] result,
    
    input clk,
    input [2:0] F,
    output [3:0] AN,
    output CA, CB, CC, CD, CE, CF, CG, CDP,
    
    output N, Z, C, V
    );
    
    wire [3:0] add_result;
    wire [3:0] sub_result;
    wire [3:0] or_result;
    wire [3:0] and_result;
    wire [3:0] shl_result;
    wire [3:0] shr_result;
    wire [3:0] rol_result;
    wire [3:0] ror_result;
    
    wire [3:0] adder_flag, sub_flag;
    wire [3:0] flag_out;
    
    Adder m1 (A, B, Cin, add_result[3:0], adder_flag[3], adder_flag[2], adder_flag[1], adder_flag[0]);
    Subtractor m2 (A, B, Cin, sub_result[3:0], sub_flag[3], sub_flag[2], sub_flag[1], sub_flag[0]);
    ALU_OR m3 (A, B, or_result);
    ALU_AND m4 (A, B, and_result);
    Logical_Shifter_Left m5 (A, B[1:0], shl_result);
    Logical_Shifter_Right m6 (A, B[1:0], shr_result);
    Rotator_Left m7 (A, B[1:0], rol_result);
    Rotator_Right m8 (A, B[1:0], ror_result);
    
    Controller m9 (clk, F, add_result, sub_result, or_result, and_result, shl_result, shr_result, rol_result, ror_result, adder_flag, sub_flag, AN, CA, CB, CC, CD, CE, CF, CG, CDP, result, flag_out);
    
    assign N = flag_out[3];
    assign Z = flag_out[2];
    assign C = flag_out[1];
    assign V = flag_out[0];
    
endmodule
