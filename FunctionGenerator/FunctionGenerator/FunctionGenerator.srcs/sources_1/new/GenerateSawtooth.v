`timescale 1ns / 1ps


module GenerateSawtooth(
input Clk,
input [11:0] Amp,
input [7:0] Ratio,
input [15:0] Hertz,
output [11:0] Out);

    reg [27:0] Count = 0;
    reg [38:0] TempOut;
    wire [26:0] N;
    wire [27:0] NParam;
 
    assign N = 27'd1562500/Hertz;
    assign NParam = N*Ratio/100;
    assign Out= TempOut; 
    
    always@(posedge Clk) 
    begin 
        if(Count <= NParam)
        begin
        TempOut = Amp*Count/NParam;
        Count <= Count + 1;
        end
        else if(Count < N && N !=NParam)
        begin
        TempOut = Amp*(N-Count)/(N-NParam);
        Count <= Count + 1;
        end
        else
        begin
        Count <=0;
        end
    end 
endmodule
