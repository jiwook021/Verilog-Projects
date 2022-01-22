`timescale 1ns / 1ps

module UART_TX_tb;

reg clk;
reg tx_clk;
reg En;
reg [7:0] tx_data;
reg [3:0] databit;
wire TXD;
//wire [1:0] state;
//wire [3:0] cnt;

UART_tx tb_m1 (clk, tx_clk, En, tx_data, databit, TXD);

initial begin
    clk = 0;
    tx_clk = 0;
    En = 1;
    tx_data = 8'b10110101;
    databit = 4'd8;
end

always begin
    #1; clk = ~clk;
end

always begin
     #10; tx_clk = ~tx_clk;
end

endmodule