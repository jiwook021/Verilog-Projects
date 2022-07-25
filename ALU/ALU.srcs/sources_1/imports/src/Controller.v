`timescale 1ns / 1ps

module Controller(
    input clk,
    input [2:0] F,
    input [3:0] add_result,
    input [3:0] sub_result,
    input [3:0] or_result,
    input [3:0] and_result,
    input [3:0] shl_result,
    input [3:0] shr_result,
    input [3:0] rol_result,
    input [3:0] ror_result,
    
    input [3:0] add_flag,
    input [3:0] sub_flag,
    
    output [3:0] AN,
    output CA, CB, CC, CD, CE, CF, CG, CDP,
    output [4:0] result,
    output [3:0] flag_out
    );
    
    reg [3:0] data_in; 
    wire [3:0] tens, ones;
//    wire [3:0] flag_out;
    
    BCD_Converter Con_m1 (F, data_in, tens, ones);
    SS_Decoder Con_m2 (clk, tens, ones, CA, CB, CC, CD, CE, CF, CG, CDP, AN[3], AN[2], AN[1], AN[0]);
    
    always @ (*) begin
        case(F)
            3'b000: data_in = add_result;
            3'b001: data_in = sub_result;
            3'b010: data_in = or_result;
            3'b011: data_in = and_result;
            3'b100: data_in = shl_result;
            3'b101: data_in = shr_result;
            3'b110: data_in = rol_result;
            3'b111: data_in = ror_result;
        endcase
    end
    
    assign result = data_in;
    assign flag_out = (F == 3'b000) ? add_flag : (F == 3'b001) ? sub_flag : 4'b0000;
    
endmodule
