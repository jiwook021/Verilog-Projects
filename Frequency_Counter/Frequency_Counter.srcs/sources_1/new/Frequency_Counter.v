`timescale 1ns / 1ps


module Frequency_Counter(
input clk_1hz,
input slow_signal,
input fast_signal,
output [20:0] result
);

reg [20:0] slow_count = 0;
reg [20:0] slow_freq = 0 ;


reg [20:0] fast_count = 0;
reg [20:0] fast_freq = 0 ;

reg slow_En = 1;
reg fast_En = 1;
reg reset = 0; 

always @(posedge slow_signal) begin 
   if(reset!=slow_En)
       begin
        slow_count <=0;
        slow_En <= ~slow_En;
       end 
              
   else 
       begin 
        slow_count <= slow_count + 1;
       end
end


always @(posedge fast_signal) begin 
   if(reset!=fast_En)
       begin
        fast_count <=0;
       fast_En <= ~fast_En;
       end 
       
   else 
       begin 
        fast_count <= fast_count + 1;
       end
end


always@ (negedge clk_1hz) 
begin 
    slow_freq <=slow_count;
    fast_freq <=fast_count;

    reset <=~reset;
end

    assign result = (fast_freq > 600)? fast_freq: slow_freq; 
    
endmodule
