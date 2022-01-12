`timescale 1ns / 1ps

module Rotator_Left(data, select, out);
input [3:0] data;
input [1:0] select;
output reg [3:0] out;

always@(data, select) // whenever data or select change
    case(select)
        2'b00: 
            begin 
            out[3] = data[3]; 
            out[2] = data[2]; 
            out[1] = data[1]; 
            out[0] = data[0]; 
            end
        2'b01: 
            begin 
            out[3] = data[2]; 
            out[2] = data[1]; 
            out[1] = data[0]; 
            out[0] = data[3]; 
            end
        2'b10: 
            begin 
            out[3] = data[1]; 
            out[2] = data[0]; 
            out[1] = data[3]; 
            out[0] = data[2]; 
            end
        2'b11: 
            begin 
            out[3] = data[0]; 
            out[2] = data[3]; 
            out[1] = data[2]; 
            out[0] = data[1]; 
            end
    endcase
endmodule
