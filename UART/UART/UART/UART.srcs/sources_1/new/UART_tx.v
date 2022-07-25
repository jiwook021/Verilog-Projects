`timescale 1ns / 1ps

`define WAIT_FOR_TRIGGER 2'b00
`define IDLE 2'b01
`define TRANSMITTING 2'b10
`define STOP 2'b11

module UART_tx(
input clk,
input tx_clk,
input En,
input [7:0] tx_data,
input [3:0] databit,
output TXD
    );
    
    reg [1:0] state, nextstate;
    reg [3:0] countbit = 0;
    reg tx_buffer = 1;
    reg [7:0] transmit_buffer = 0;
    reg start = 0;
    
    initial begin
        state <= `WAIT_FOR_TRIGGER;
        nextstate <= `WAIT_FOR_TRIGGER;
    end
    
    always @ (posedge clk) begin
        state <= nextstate;
    end
    
    always @ (posedge tx_clk) begin
        case(state)
        `WAIT_FOR_TRIGGER:
        if(start != En) begin
            if(countbit == 0) begin
                countbit = 1;
                tx_buffer = 1;
                transmit_buffer = tx_data;
                nextstate = `IDLE;
            end
        end
        
        `IDLE:
        begin
            nextstate = `TRANSMITTING;
            tx_buffer = 0;
            countbit = 2;
        end
        
        `TRANSMITTING:
        begin
            if(countbit <= (databit + 1)) 
            begin
                tx_buffer = transmit_buffer[0];
                transmit_buffer = {1'b0, transmit_buffer[7:1]};
                countbit = countbit + 1;
            end
            else if (countbit == (databit + 2)) begin
                nextstate = `STOP;
                tx_buffer <= 1;
            end
        end
        
        `STOP:
        begin
            nextstate <= `WAIT_FOR_TRIGGER;
            start = En;
            countbit = 0;
        end
        endcase
    end
        
assign TXD = tx_buffer;


endmodule