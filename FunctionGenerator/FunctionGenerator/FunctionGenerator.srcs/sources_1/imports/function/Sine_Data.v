`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  SINE wave data read from ROM
//
//////////////////////////////////////////////////////////////////////////////////

module Sine_Data(
input [11:0] ROM_addr,
output [9:0] ROM_data
    );
    
    reg [9:0] ROM [4095:0];
    
    initial $readmemb ("exp.txt", ROM, 0, 4095);
    
    assign ROM_data = ROM[ROM_addr];
endmodule
