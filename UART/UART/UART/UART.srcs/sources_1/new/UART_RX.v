`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/13/2022 07:44:07 PM
// Design Name: 
// Module Name: UART_RX
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module UART_RX(
    input RESET,
    input CLK,
    input RXD,
    output [7:0] out//LED DISP
    );
         
    parameter CLOCKS_PER_BIT = 5208;         // baud rate : 19200, Clock : 100MHz, 10ns
    parameter CLOCKS_WAIT_FOR_RECEIVE = 2604;

    reg [7:0] rx_data;
    reg [3:0] rx_bit_count;
    reg [14:0] rx_clk_count;
    
    reg state_rx;

    // Receiver Processs
    // at every rising edge of the clock
    always @ (posedge CLK)
    begin
        if (RESET == 1) begin
            rx_clk_count = 0;
            rx_bit_count = 0;
            state_rx = 0;
        end
        else begin
            // if not receive mode and start bit is detected
            if (state_rx == 0 && RXD == 0) begin
                state_rx = 1;       // enter receive mode
                rx_bit_count = 0;
                rx_clk_count = 0;
            end
            // if receive mode
            else if (state_rx == 1) begin
                 
                if(rx_bit_count == 0 && rx_clk_count == CLOCKS_WAIT_FOR_RECEIVE) begin
                    rx_bit_count = 1;
                    rx_clk_count = 0;
                end
                else if(rx_bit_count < 9 && rx_clk_count == CLOCKS_PER_BIT) begin
                    rx_data[rx_bit_count-1] = RXD;
                    rx_bit_count = rx_bit_count + 1;
                    rx_clk_count = 0;
                end
                // stop receiving
                else if(rx_bit_count == 9 && rx_clk_count == CLOCKS_PER_BIT && RXD == 1) begin
                    state_rx = 0;
                    rx_clk_count = 0;
                    rx_bit_count = 0;                    
                end
                // if stop bit is not received, clear the received data
                else if(rx_bit_count == 9 && rx_clk_count == CLOCKS_PER_BIT && RXD != 1) begin
                    state_rx = 0;
                    rx_clk_count = 0;
                    rx_bit_count = 0;
                    rx_data = 8'b00000000;      // invalidate
                end
                rx_clk_count = rx_clk_count + 1;
            end
        end
         
    end
     
    assign out = rx_data;
     
endmodule
