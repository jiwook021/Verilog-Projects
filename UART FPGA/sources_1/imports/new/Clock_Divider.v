// d49 = 1Mhz
// d2 = 16.66667MHz

// Instantiation -> Clock_Divider m1 #(25)(clk_in, clk_out);

`timescale 1ns / 1ps

module Clock_Divider
#(parameter param = 1)
    (
    input clk_in,
    output reg clk_out
    );

    reg [25:0] q;
    wire [25:0] r;
    
    initial
    begin
        q <= 0;
        clk_out <= 0;
    end 
    
    always @(posedge clk_in)
        begin
        if (q == param)
            begin
            clk_out <= ~clk_out;
            q <= 0;
            end
        else
            q <= r;
        end
        
    assign r = q + 1;   
endmodule