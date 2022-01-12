`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2022 07:44:13 PM
// Design Name: 
// Module Name: traffic_light_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define S0 4'd0  
`define S1 4'd1
`define S2 4'd2
`define S3 4'd3
`define S4 4'd4
`define S5 4'd5
`define S6 4'd6
`define S7 4'd7
`define S8 4'd8
`define S9 4'd9
`define S10 4'd10
`define S11 4'd11
`define S12 4'd12 

module traffic_light_controller(
input clk, 
input Sa,
input Sb, 
output [2:0] lightA,
output [2:0] lightB,
output clk_1Hz_disp,
output [3:0]state_disp
);

wire clk_1Hz;
reg [3:0]state,nextstate; 
reg [2:0] la,lb;

parameter R = 3'b100;
parameter Y = 3'b010;
parameter G = 3'b001; 
//1hz clock 
Clock_Divider #(49000000) m1(clk, clk_1Hz);

// 1. initial value
initial begin 
    state <= `S0; nextstate <= `S0; 
end 


// 2. state update logic
always @(posedge clk_1Hz)begin
state<=nextstate; 
end 
// 3. nextstate update logic 
always @(state,Sa,Sb)begin
    
    case(state)
        `S0: nextstate <= `S1;
        `S1: nextstate <= `S2;
        `S2: nextstate <= `S3;
        `S3: nextstate <= `S4;
        `S4: nextstate <= `S5;
        `S5: nextstate <= (Sb) ?`S6:`S5; 
        `S6: nextstate <= `S7;        
        `S7: nextstate <= `S8;
        `S8: nextstate <= `S9;
        `S9: nextstate <= `S10;
        `S10: nextstate <= `S11;
        `S11: nextstate <= (!(Sa)&Sb) ? `S11:`S12;
        `S12: nextstate <= `S0;
        default:nextstate<= `S0;
        endcase           
end 


// 4. output logic 
always @ (state) begin 
    case(state)
        `S0: begin la =G;lb =R; end
        `S1: begin la =G;lb =R; end
        `S2: begin la =G;lb =R; end
        `S3: begin la =G;lb =R; end
        `S4: begin la =G;lb =R; end
        `S5: begin la =G;lb =R; end
        `S6: begin la =Y;lb =R; end
        `S7: begin la =R;lb =G; end
        `S8: begin la =R;lb =G; end
        `S9: begin la =R;lb =G; end
        `S10: begin la =R;lb =G; end
        `S11: begin la =R;lb =G; end
        `S12: begin la =R;lb =Y; end
    endcase
end
assign lightA = la; 
assign lightB = lb; 

assign clk_1Hz_disp =clk_1Hz;
assign state_disp = state; 

endmodule
