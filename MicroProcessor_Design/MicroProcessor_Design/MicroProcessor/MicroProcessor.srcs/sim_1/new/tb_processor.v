`timescale 1ns / 1ps
module tb_processor;
reg clk;
reg clr;
reg [3:0] data;
reg valid;
// Outputs
wire [3:0] hout;
wire [3:0] lout;
wire [3:0] kout;
integer i,j,k;
processor uut (
.clk(clk),
.clr(clr),
.data(data),
.valid(valid),
.hout(hout),
.lout(lout),
.kout(kout)
);
always #50 clk=~clk;
initial begin
// Initialize Inputs
clk = 0; clr = 1;
#100; clr=0; data = 0;
for (k=10;k<15;k=k+1) begin
for (i=0;i<10;i=i+1) begin
for (j=0;j<10;j=j+1) begin
data=i; valid=1; //first number
#300000; valid=0;
#300000; data=k; valid=1; //operator
#300000; valid=0;
#300000; data=j; valid=1; //second number
#300000; valid=0;
#300000; data=4'b1111; valid=1; //equal key
#300000; valid=0;
#300000; $display("%d %d %d= %d %d : %d \n"
,i,k,j,hout,lout,kout);
end
end
end
$stop;
end
endmodule