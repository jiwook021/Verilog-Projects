`timescale 1ns / 1ps
module ha8(data_in,data_out,pc_inc);
input [7:0] data_in;
input pc_inc;
output [7:0] data_out;
wire a[7:0];
genvar i;
generate
ha ha0(data_out[0],a[0],pc_inc,data_in[0]);
for(i=1;i<8;i=i+1) begin:hagen
ha ha1(data_out[i],a[i],a[i-1],data_in[i]);
end
endgenerate
endmodule