`timescale 1ns / 1ps
module reg8(data_out, data_in, inen, oen, clk, clr);
input [7:0] data_in;
input inen, oen, clk, clr;
output [7:0] data_out;
reg [7:0] st;
always @(posedge clk, posedge clr) begin
    if(clr) st=8'b0;
    else if(inen) st=data_in;
    else st=st;
end
assign data_out = (oen)?st:8'bz;
endmodule
