`timescale 1ns / 1ps

//////////////////////////////////
// Debouncer Module
// Input : 100Hz_Clock, Buttons
// Output : Buttons_out
/////////////////////////////////

module Debouncer_Module(
    input clk100Hz,
    input DU_in, 
    input DD_in,
    input DL_in,
    input DR_in, 
    output reg DU_out,
    output reg DD_out,
    output reg DL_out,
    output reg DR_out
    );
    reg [9:0] temp_DU, temp_DD, temp_DL, temp_DR;
    
    initial
        begin
        temp_DU <= 10'd0;
        temp_DD <= 10'd0;
        temp_DL <= 10'd0;
        temp_DR <= 10'd0;
        DU_out <= 0;
        DD_out <= 0;
        DL_out <= 0;
        DR_out <= 0;
        end
    
    always @ (posedge clk100Hz)
        begin
        temp_DU <= {temp_DU[8:0], DU_in};
        temp_DD <= {temp_DD[8:0], DD_in};
        temp_DL <= {temp_DL[8:0], DL_in};
        temp_DR <= {temp_DR[8:0], DR_in};
        if (temp_DU == 10'b0000000001)
            DU_out <= 1;
        else 
            DU_out <= 0;
        if (temp_DD == 10'b0000000001)
            DD_out <= 1;
        else 
            DD_out <= 0;
        if (temp_DL == 10'b0000000001)
            DL_out <= 1;
        else 
            DL_out <= 0;
        if (temp_DR == 10'b0000000001)
            DR_out <= 1;
        else 
            DR_out <= 0;    
        end
endmodule
