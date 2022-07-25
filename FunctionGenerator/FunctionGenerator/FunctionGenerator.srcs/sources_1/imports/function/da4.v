`timescale 1ns / 1ps


module da4(clk, MOSI_da4, SCLK_da4, CS_da4, din
    );
    
    input clk;
    output reg MOSI_da4;
    output SCLK_da4;
    output CS_da4;
    input [11:0] din;                           // data to send
    
    Clock_Divider_DAC da_m1 (clk, SCLK_da4);    // Generate SCLK
    
    reg [6:0] FSM_State = 0;
    reg cs_value = 1;
    reg [31:0] init_data = 32'h08000001;
    reg [5:0] data_count = 30;
    reg init_flag = 0;
    reg [31:0] data = 32'h030fff00;
    
    assign CS_da4 = cs_value;
         
    always @ (posedge SCLK_da4)
    begin
    if (cs_value == 1 && FSM_State == 0) begin        
        cs_value <= 0;
        MOSI_da4 <= 0;
        data <= {12'h030, din, 8'h00};
        FSM_State = FSM_State + 1;
        end
    
     else if (FSM_State < 32 && cs_value == 0)
        begin
            MOSI_da4 <= (init_flag) ? data[data_count] : init_data[data_count];                
            FSM_State <= FSM_State + 1;
            data_count = data_count - 1;
        end
        
        else if (FSM_State == 32)
        begin
            FSM_State <= 0;
            cs_value <= 1;
            data_count = 30;
            if(init_flag == 0)
                init_flag <= 1;    
        end
    end
endmodule