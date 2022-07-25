`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: jiwook

module GeneratePulse(
input Clk,
input [11:0] Amp,
input [7:0] Ratio,
input [15:0] Hertz,
output [11:0] Out
    );
wire [26:0] Param, ParamPos; 
reg [26:0]Q;
wire [26:0]R;
reg ClkOut;
    
assign Param  = 27'd1_562_500/Hertz/2 -1; 
assign ParamPos = Param * 2 *Ratio/100; 

initial  
    begin 
    Q <= 0;
    ClkOut <=0;
    end

always @(posedge Clk)
begin 
    if(Q<= ParamPos) 
    begin
        ClkOut<=1;
        Q<=R; 
    end 
    
    else if(Q <= (Param*2)) 
    begin
        ClkOut <= 0;
        Q<=R; 
    end
    
    else
    begin
        Q<=0;
    end
end

assign R =Q+1;
assign Out=Amp*ClkOut;
 
endmodule
