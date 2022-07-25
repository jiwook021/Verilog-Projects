`timescale 1ns / 1ps


module BCD_Converter_Hz(
input [15:0] data_in,
output [3:0] ten_thousands_o, thousands_o, hunds_o, tens_o, ones_o
    );
    assign ten_thousands_o = data_in / 10000;
    assign thousands_o = (data_in % 10000) / 1000;
    assign hunds_o = (data_in % 1000) / 100;
    assign tens_o = (data_in % 100) / 10;
    assign ones_o = data_in % 10;
    
endmodule
