`timescale 1ns / 1ps
module tb_pc();
// Inputs
reg pc_oen;
reg pc_inc;
reg load_pc;
reg [7:0] pc_input;
reg clr;
reg clk;
// Output
wire [7:0] pc_out;
// Instantiate the UUT
pc UUT (
.pc_out(pc_out),
.pc_oen(pc_oen),
.pc_inc(pc_inc),
.load_pc(load_pc),
.pc_input(pc_input),
.clr(clr),
.clk(clk)
);
always #50 clk = ~clk;
initial begin
pc_oen = 1;
pc_inc = 0;
load_pc = 0;
pc_input = 8'h13;
clr = 1;
clk = 0;
#100; clr = 0;
#100; pc_inc = 1;
#500; load_pc = 1;
#100; load_pc = 0;
#400; pc_oen = 0;
#100; pc_oen = 1;
#100; clr = 1;
#100; clr = 0;
#100;
end
endmodule
