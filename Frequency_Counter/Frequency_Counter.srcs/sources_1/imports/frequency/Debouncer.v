`timescale 1ns / 1ps

module Debouncer(
    input clk_in,
    input signal_in, 
    output reg signal_out
    );
    reg [9:0] temp_signal;
    
    initial
        begin
        temp_signal <= 10'd0;
        signal_out <= 0;
        end
    
always @ (posedge clk_in)
    begin
    temp_signal <= {temp_signal[8:0], signal_in};
    if (temp_signal == 10'b0000000001)
        signal_out <= 1;
    else if (temp_signal == 10'b1111111110)
        signal_out <= 0;
    end
endmodule
