`timescale 1ns / 1ps

module GeneratePulse_tb;
reg Clk;
reg [11:0] Amp;
reg [7:0] Ratio;
reg [15:0] Hertz;
wire [11:0] Out;

GeneratePulse m1 (Clk,Amp,Ratio,Hertz,Out); 

initial begin
    Clk = 0; Amp = 12'd2048;Ratio = 8'd20;Hertz=16'd2048;  
end

always begin 
#1; Clk= ~Clk;
end 
endmodule
