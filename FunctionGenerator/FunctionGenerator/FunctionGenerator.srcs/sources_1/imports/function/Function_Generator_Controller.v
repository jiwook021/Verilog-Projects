`timescale 1ns / 1ps

module Function_Generator_Controller(
    input clk_pulse,                        // 1.5625MHz
    input clk_100kHz,                       // 100kHz
    input clk_100Hz,                        // 100Hz
    input [15:0] Herz,                      // Frequency Input
    
    input DU_in,                            // Button Input for Duty Up
    input DD_in,                            //Button Input for Duty Down
    input DL_in,                            //Button Input for Amplitude Up
    input DR_in,                            //Button Input for Amplitude Down
    
    output [11:0] signal_out,               // Output data to DA4 Module
    output [2:0] signal_led,                // Led display for selected signal type (PWM / Sawtooth / Sine)
    output [9:0] duty_led,                  // Led display for duty ratio
    input [7:0] signal_select,              // Signal Select signal from UART
    
    output CA, CB, CC, CD, CE, CF, CG, CDP, AN7, AN6, AN5, AN4, AN3, AN2, AN1, AN0          // 7-segment
    );
    
    wire DU_o, DD_o, DL_o, DR_o;
    wire [11:0] Pulse_out, Sawtooth_out, Sine_out;
    
    reg [7:0] minus = 0, plus = 0;
    reg [7:0] minus_Hz = 0, plus_Hz = 0;
    wire [7:0] ratio;
    
    wire [11:0] din;
    wire [12:0] din_temp;
    wire [4:0] Amp_temp;
    
    wire [3:0] tens_Amp, ones_Amp, ten_thousands_Hz, thousands_Hz, hunds_Hz, tens_Hz, ones_Hz;
    
    // Debouncer Module for button inputs
    Debouncer_Module FG_m1 (clk_100Hz, DU_in, DD_in, DL_in, DR_in, DU_o, DD_o, DL_o, DR_o);
    
    // Generate signals (PWM / Sawtooth / Sine)
    Generate_Pulse FG_m2 (clk_pulse, din, Herz, ratio, Pulse_out);
    Generate_Sawtooth FG_m3 (clk_pulse, din, Herz, ratio, Sawtooth_out);
    Generate_Sine FG_m4 (clk_pulse, din, Herz, Sine_out);
    
    // Display modules
    ratio_led_controller FG_m6 (ratio, duty_led);
    BCD_Converter_Hz FG_m7 (Herz, ten_thousands_Hz, thousands_Hz, hunds_Hz, tens_Hz, ones_Hz);
    BCD_Converter_Amp FG_m8 (Amp_temp, tens_Amp, ones_Amp);
    SS_Decoder FG_m9 (clk_100kHz, tens_Amp, ones_Amp, ten_thousands_Hz, thousands_Hz, hunds_Hz, tens_Hz, ones_Hz, CA, CB, CC, CD, CE, CF, CG, CDP, AN7, AN6, AN5, AN4, AN3, AN2, AN1, AN0);
        
    // Duty Ratio Calculation
    always @ (posedge DD_o)
    begin
        if(ratio > 0)
            minus <= minus + 5;
    end
    
    always @ (posedge DU_o)
    begin
        if (ratio < 100)
            plus <= plus + 5;
    end
    
    // Amplitude Calculation
    always @ (posedge DL_o)
    begin
        if((15 + plus_Hz - minus_Hz) > 0)
            minus_Hz <= minus_Hz + 5;
    end
    
    always @ (posedge DR_o)
    begin
        if((15 + plus_Hz - minus_Hz) < 25)
            plus_Hz <= plus_Hz + 5;
    end

    assign ratio = 8'd50 + plus - minus;
    
    assign din_temp = 4095 * (15 + plus_Hz - minus_Hz) / 25;
    assign din = din_temp;
    
    assign Amp_temp = (15 + plus_Hz - minus_Hz);
    
    // Signal Select
    assign signal_out = (signal_select == 8'h32) ? Sawtooth_out : (signal_select == 8'h33) ? Sine_out : Pulse_out;
    assign signal_led = (signal_select == 8'h31) ? 3'b001 : (signal_select == 8'h32) ? 3'b010 : (signal_select == 8'h33) ? 3'b100 : 3'b000;
endmodule
