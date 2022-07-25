`timescale 1ns / 1ps

module BCD_Converter_Amp(
input [4:0] data_in,
output [3:0] tens_o, ones_o
    );
    assign tens_o = (data_in / 10) + 10;
    assign ones_o = data_in % 10;
    
endmodule
