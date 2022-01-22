`timescale 1ns / 1ps

module Top_module(
input clk,
input [7:0] tx_data,
input tx_btn,
output TXD
    );
    
    wire tx_clk, tx_en;
    
    Clock_Divider #(2603) m1 (clk, tx_clk);
    Debouncer m2 (clk, tx_btn, tx_en);
    UART_tx m3 (clk, tx_clk, tx_en, tx_data, 4'd8, TXD);
    
endmodule