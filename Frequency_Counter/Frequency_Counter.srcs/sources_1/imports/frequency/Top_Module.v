`timescale 1ns / 1ps


module Top_Module(
    // 100MHz Clock
    input clk,
    
    // For AD1 Module
    input MISO_ad1,
    output SCLK_ad1,
    output CS_ad1,

    // 7-segment
    output CA, CB, CC, CD, CE, CF, CG, CDP, AN0, AN1, AN2, AN3, AN4, AN5, AN6, AN7      
    );
    
    wire [11:0] data, data_o;
    wire [20:0] freq;
    wire [3:0] DG1, DG2, DG3, DG4, DG5, DG6, DG7, DG8;
    wire clk_o; // 1_562_500 Hz
    wire clk_1Hz;
    wire clk_70kHz;
    reg signal;
    wire DONE;
    wire signal_fast, signal_slow;

    // AD1 SPI Module
    ad1 m1 (clk, MISO_ad1, SCLK_ad1, CS_ad1, data, DONE);    
    data_update m2 (clk, DONE, data, data_o);
    
    // Freuqncy Counter Module
    Frequency_Counter m3 (clk_1Hz, freq, signal_fast, signal_slow);
    
    // Display Modules 
    BCD_Converter m4 (freq, DG1, DG2, DG3, DG4, DG5, DG6, DG7, DG8);
    SS_Decoder m5 (clk_o, DG1, DG2, DG3, DG4, DG5, DG6, DG7, DG8, CA, CB, CC, CD, CE, CF, CG, CDP, AN7, AN6, AN5, AN4, AN3, AN2, AN1, AN0);
    
    // Clock Divider Modules
    Clock_Divider #(31) m6 (clk, clk_o);
    Clock_Divider #(781249) m7 (clk_o, clk_1Hz);
    Clock_Divider #(9) m8 (clk_o, clk_70kHz);
    
    // Debouncer Modules for signal filtering
    Debouncer m9 (clk, signal, signal_fast);
    Debouncer m10 (clk_70kHz, signal, signal_slow);

    // Pulse Generator Module
    always @ (data_o)
    begin
        if(data_o > 12'b0111_1111_1111)
            signal = 1;
        else
            signal = 0;
    end
    
endmodule
