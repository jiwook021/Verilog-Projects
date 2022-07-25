`timescale 1ns / 1ps
    
    module ringCounter(clk,clr,t);
    
    input clk, clr;
    output [11:0] t;
    reg [11:0] st=0;
    always @(negedge clk, posedge clr) begin
        if (clr==1) st=12'b0;
        else if (st==12'b0) st=st+1;
        else if (st==12'b100000000000) st=12'b000000000001;
        else st=st<<1;
    end
    
    assign t=st;
    
    endmodule
