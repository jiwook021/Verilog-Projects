`timescale 1ns / 1ps

module Clock_Divider_DAC(
    input clk_in,
    output reg clk_out
    );
    
    initial clk_out <= 1'b0;
    
    always @ (posedge clk_in)
        clk_out <= ~clk_out;
            
endmodule
