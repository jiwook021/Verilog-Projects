`timescale 1ns / 1ps

module Debouncer(
    input clk, input tx_in,
    output tx_out
);

reg [9:0] temp_tx;
reg de_tx, clk1KHz;
reg [16:0] q;
wire [16:0] r;

initial
begin
    clk1KHz <= 0;
    temp_tx <= 10'd0;
    de_tx <= 0;
    q <= 0;
end

always @(posedge clk)
begin
    if (q == 17'd50000)
    begin
        clk1KHz <= ~clk1KHz;
        q <= 0;
    end  
    else
        q <= r;
    end

always @ (posedge clk1KHz)
begin
    temp_tx = {temp_tx[8:0],tx_in};
   
    if (temp_tx == 10'b0000000001)
        de_tx = ~de_tx;
    else
        de_tx = de_tx;
end
    
assign r = q + 1;
assign tx_out = de_tx;

endmodule