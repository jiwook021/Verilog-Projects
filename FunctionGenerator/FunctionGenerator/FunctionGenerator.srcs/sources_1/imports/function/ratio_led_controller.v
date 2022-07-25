`timescale 1ns / 1ps


module ratio_led_controller(
    input [7:0] duty_in,
    
    output reg [9:0] led_duty
    );
    
    // duty cycle ���
    always @ (*)
    begin
        case (duty_in)
            8'd0 : led_duty = 10'b00_0000_0000;
            8'd5 : led_duty = 10'b00_0000_0000;
            8'd10 : led_duty = 10'b00_0000_0001;
            8'd15 : led_duty = 10'b00_0000_0001;
            8'd20 : led_duty = 10'b00_0000_0011;
            8'd25 : led_duty = 10'b00_0000_0011;
            8'd30 : led_duty = 10'b00_0000_0111;
            8'd35 : led_duty = 10'b00_0000_0111;
            8'd40 : led_duty = 10'b00_0000_1111;
            8'd45 : led_duty = 10'b00_0000_1111;
            8'd50 : led_duty = 10'b00_0001_1111;
            8'd55 : led_duty = 10'b00_0001_1111;
            8'd60 : led_duty = 10'b00_0011_1111;
            8'd65 : led_duty = 10'b00_0011_1111;
            8'd70 : led_duty = 10'b00_0111_1111;
            8'd75 : led_duty = 10'b00_0111_1111;
            8'd80 : led_duty = 10'b00_1111_1111;
            8'd85 : led_duty = 10'b00_1111_1111;
            8'd90 : led_duty = 10'b01_1111_1111;
            8'd95 : led_duty = 10'b01_1111_1111;
            8'd100 : led_duty = 10'b11_1111_1111;
            default : led_duty = 10'b00_0000_0000;
        endcase
    end
    
    
endmodule
