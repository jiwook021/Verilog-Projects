`timescale 1ns / 1ps

module Generate_Sine(
    input clk,
    input [11:0] din,
    input [15:0] Herz,
    
    output [11:0] out
    );
    
    reg [26:0] cnt = 0;
    wire [26:0] N;
    reg [33:0] addr_temp;
    wire clk_ost;
    wire [11:0] addr;
    wire [9:0] sine_data;
    wire [21:0] out_temp;
    
    // Data Read From ROM
    Sine_Data sine_m2 (addr, sine_data);
    
    assign N = 27'd1_562_500 / Herz;
    assign addr = addr_temp;
    assign out_temp = din * sine_data / 1000;
    assign out = out_temp;
    
    always @ (posedge clk)
    begin
        if(cnt >= N)
        begin
            cnt <= 0;
        end
        cnt = cnt + 1;
        addr_temp = (4095 * cnt) / N;
    end
    
    
endmodule