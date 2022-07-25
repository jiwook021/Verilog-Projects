`timescale 1ns / 1ps

module BCD_Converter(
input [20:0] data_in,
output [3:0] DG1, DG2, DG3, DG4, DG5, DG6, DG7, DG8
    );
       
    assign DG8 = data_in / 10_000_000;
    assign DG7 = (data_in % 10_000_000) / 1_000_000;
    assign DG6 = (data_in % 1_000_000) / 100_000;
    assign DG5 = (data_in % 100_000) / 10_000;
    assign DG4 = (data_in % 10_000) / 1000;
    assign DG3 = (data_in % 1000) / 100;
    assign DG2 = (data_in % 100) / 10;
    assign DG1 = data_in % 10;
    
endmodule
