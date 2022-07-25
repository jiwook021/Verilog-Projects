`timescale 1ns / 1ps



module ad1(clk, MISO, SCLK, CS, x, DONE
    );
    
    input clk;
    input MISO;
    output SCLK;
    output CS;
    output reg [11:0] x;
    output reg DONE;
    
    Clock_Divider #(1) ad_m1 (clk, SCLK);
    
    reg [6:0] FSM_State = 0;
    reg cs_value = 1;
    reg [11:0] x_data;
    reg [3:0] data_count = 11;
        
    assign CS = cs_value;
    //assign x = x_data;
        
    always @ (negedge SCLK)
    begin
    if (cs_value == 1 && FSM_State == 0) begin        
        x = x_data;
        cs_value <= 0;
        DONE <= 0;
        end
    
     else if (FSM_State < 4 && cs_value == 0)
        begin                
            FSM_State = FSM_State + 1;
        end
        
        else if (FSM_State < 16)
        begin
            FSM_State = FSM_State + 1;
            x_data[data_count] = MISO;
            data_count = data_count -1;    
        end
        
        else if (FSM_State == 16 && cs_value == 0) begin
            FSM_State <= 0;
            cs_value <= 1;
            data_count <= 11;
            DONE <= 1;
        end
    end
    
endmodule
