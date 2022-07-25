`timescale 1ns / 1ps

module Generate_Sawtooth(
    input clk,
    input [11:0] din,
    input [15:0] Herz,
    input [7:0] ratio,
    
    output [11:0] out   
    );
    
    reg [27:0] cnt = 0;
    wire [26:0] N;
    wire [27:0] N_param;
    reg [38:0] out_temp;
    wire clk_ost;
       
    assign N = 27'd1_562_500 / Herz;
    assign N_param = N * ratio / 100;
    assign out = out_temp;
    
    always @ (posedge clk)
    begin
    
        if(cnt <= N_param)
        begin
            out_temp = (din * cnt) / (N_param);
            cnt <= cnt+ 1;
        end
        else if (cnt < N && N != N_param)
        begin
            out_temp = (din * (N - cnt)) / (N - N_param);
            cnt <= cnt+ 1;
         end
         else
            cnt <= 0;   
    end
    
endmodule
