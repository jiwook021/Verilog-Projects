`timescale 1ns / 1ps

module SinData 
(input [11:0] BRAM_Address, 
output[9:0] BRAM_Data);
    
reg [9:0] BRAM [4096:0]; 
    
initial $readmemb ("exp.txt", BRAM, 0,4095);

assign BRAM_Data = BRAM[BRAM_Address];    
        
endmodule
