`timescale 1ns / 1ps

module Top_Module(
    input clk,                              // 100MHz Clock
    output MOSI_da4,                        // MOSI for DA4
    output SCLK_da4,                        // SCLK for DA4
    output CS_da4,                          // CS for DA4
    
    input [15:0] Herz,                      // Frequency input from SW0~15
    input DU_in, DD_in, DL_in, DR_in,       // Button inputs
    input RXD,                              // RXD for UART
    output [2:0] signal_led,                // Selected Signal LED (PWM / Sawtooth / Sine) 
    output [9:0] duty_led,                  // Duty Ratio LED display
    output CA, CB, CC, CD, CE, CF, CG, CDP, AN7, AN6, AN5, AN4, AN3, AN2, AN1, AN0      // 7-segment
    );
    
    wire [11:0] signal_out;
    wire [7:0] signal_select;
    wire clk_100Hz, clk_100kHz, clk_pulse;
    
    // da4 SPI Module
    da4 m1 (clk, MOSI_da4, SCLK_da4, CS_da4, signal_out);
    
    // Clock Divider Module
    Clock_Divider #(31) m2 (clk, clk_pulse);
    Clock_Divider #(499999) m3 (clk, clk_100Hz);
    Clock_Divider #(499) m4 (clk, clk_100kHz);
    
    // Function Generator Controller Module
    Function_Generator_Controller m5 (clk_pulse, clk_100kHz, clk_100Hz, Herz, DU_in, DD_in, DL_in, DR_in, signal_out, signal_led, duty_led, signal_select, CA, CB, CC, CD, CE, CF, CG, CDP, AN7, AN6, AN5, AN4, AN3, AN2, AN1, AN0);
    
    // UART RX Module
    UART_RX m6 (1'b0, clk, RXD, signal_select);
    
endmodule
