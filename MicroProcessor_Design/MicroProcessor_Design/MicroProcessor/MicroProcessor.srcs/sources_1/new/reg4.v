`timescale 1ns / 1ps
module reg4(output [3:0] data_out,
input [3:0] data_in, input inen, input oen, input clk, input clr
);
reg [3:0] st;
always @(posedge clk, posedge clr) begin
    if(clr) st=4'b0;
    else if(inen) st=data_in;
    else st=st;
end
assign data_out = (oen)?st:4'bz;
endmodule