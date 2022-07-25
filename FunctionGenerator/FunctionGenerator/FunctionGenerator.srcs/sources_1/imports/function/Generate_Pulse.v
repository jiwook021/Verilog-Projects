
`timescale 1ns / 1ps

module Generate_Pulse(
    input clk_in,
    input [11:0] din,
    input [15:0] Herz,
    input [7:0] ratio,
    output [11:0] out
    );
    
    reg clk_out;

    reg [25:0] q;
    wire [25:0] r;
    
    wire [26:0] param;
    wire [25:0] param_pos;
    
    wire clk_ost;
    
    assign param = 27'd1_562_500 / Herz / 2 - 1;
    assign param_pos = param * 2 * ratio / 100;
        
    initial
    begin
        q <= 0;
        clk_out <= 0;
    end 
    
    always @(posedge clk_in)
        begin
        if (q <(param_pos + 1))
            begin
            clk_out <= 1;
            q <= r;
            end
        else if (q < (param * 2 + 1))
        begin
            clk_out <= 0 ;
            q <= r;
        end
        else
            q <= 0;
        end
    assign r = q + 1;   
    
    assign out = din * clk_out;
endmodule
