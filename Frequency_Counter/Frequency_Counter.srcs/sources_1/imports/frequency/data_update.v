`timescale 1ns / 1ps

module data_update(
input clk_in,
input DONE,
input [11:0] data_in,
output reg [11:0] data_out
    );
    
    always @ (DONE)
    if(DONE)
        data_out <= data_in;

    
endmodule
