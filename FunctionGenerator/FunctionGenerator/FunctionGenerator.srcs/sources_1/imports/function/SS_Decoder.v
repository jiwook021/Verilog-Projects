//////////////////////////////////
// Seven-Segment Decoder
// Input : clock, [3:0] hundreds, tens, ones
// Output : [7:0] seg, [3:0] AN
/////////////////////////////////

module SS_Decoder(
    input clock,
    input [3:0] tens_Amp, ones_Amp, ten_thousands_Hz, thousands_Hz, hunds_Hz, tens_Hz, ones_Hz,
    output CA, CB, CC, CD, CE, CF, CG, CDP, AN7, AN6, AN5, AN4, AN3, AN2, AN1, AN0
    );
    
    // 7-segment part
    reg [7:0] cathodedata; //cathode data
    reg [7:0] anodedata; //anode data
    reg [3:0] digit = 1;
    reg [6:0] data;
    reg setdp;
    reg [19:0] counter = 0;
    
    
    assign CA = cathodedata [7];
    assign CB = cathodedata [6];
    assign CC = cathodedata [5];
    assign CD = cathodedata [4];
    assign CE = cathodedata [3];
    assign CF = cathodedata [2];
    assign CG = cathodedata [1];
    assign CDP = cathodedata [0];
    assign AN7 = anodedata [7];
    assign AN6 = anodedata [6];
    assign AN5 = anodedata [5];
    assign AN4 = anodedata [4];
    assign AN3 = anodedata [3];
    assign AN2 = anodedata [2];
    assign AN1 = anodedata [1];
    assign AN0 = anodedata [0];
    //USED FOR SEVEN SEG
    
    always@(negedge clock)
    begin
    
        if (digit == 1)
            begin
                if (counter == 20)
                    begin
                        digit = 2;
                    end
                else
                    begin
                    counter = counter + 1;
                    data = tens_Amp;
                 
                    end
            end
            
        else if (digit == 2)
            begin
                if (counter == 40)
                    begin
                        digit = 3;
                    end
                else
                    begin
                        counter = counter + 1;
                        data = ones_Amp;
                    end
            end
            
        else if (digit == 3)
            begin
                if (counter == 60)
                    begin
                        digit = 4;
                    end
                else
                    begin
                        counter = counter + 1;
                        data = 0;
                    end
            end
            
        else if (digit == 4)
            begin
                if (counter == 80)
                    begin
                        digit = 5;
                    end 
                else
                    begin
                        counter = counter + 1;
                        data = ten_thousands_Hz;
                    end
            end
            
            else if (digit == 5)
            begin
                if (counter == 100)
                    begin
                        digit = 6;
                    end 
                else
                    begin
                        counter = counter + 1;
                        data = thousands_Hz;
                    end
            end 
            
            else if (digit == 6)
            begin
                if (counter == 120)
                    begin
                        digit = 7;
                    end 
                else
                    begin
                        counter = counter + 1;
                        data = hunds_Hz;
                    end
            end
            
            else if (digit == 7)
            begin
                if (counter == 140)
                    begin
                        digit = 8;
                    end 
                else
                    begin
                        counter = counter + 1;
                        data = tens_Hz;
                    end
            end
            
            else if (digit == 8)
            begin
                if (counter == 160)
                    begin
                        digit = 1;
                        counter = 0;
                    end 
                else
                    begin
                        counter = counter + 1;
                        data = ones_Hz;
                    end
            end
    end
    
    
    always @ (*)
    begin
        case (data)
            4'd0: cathodedata = 8'b00000011; //0
            4'd1: cathodedata = 8'b10011111; //1
            4'd2: cathodedata = 8'b00100101; //2
            4'd3: cathodedata = 8'b00001101; //3
            4'd4: cathodedata = 8'b10011001; //4
            4'd5: cathodedata = 8'b01001001; //5
            4'd6: cathodedata = 8'b01000001; //6
            4'd7: cathodedata = 8'b00011111; //7
            4'd8: cathodedata = 8'b00000001; //8
            4'd9: cathodedata = 8'b00001001; //9
            4'd10: cathodedata = 8'b00000010; //0.
            4'd11: cathodedata = 8'b10011110; //1.
            4'd12: cathodedata = 8'b00100100; //2.
            default: cathodedata = 8'b11111111; //default all off
        endcase
    
        if (setdp == 1) //decimal point
            cathodedata = cathodedata & 8'hFE;
    
        case(digit)
            0: anodedata = 8'b1111_1111; //all OFF
            8: anodedata = 8'b1111_1110; //AN0
            7: anodedata = 8'b1111_1101; //AN1
            6: anodedata = 8'b1111_1011; //AN2
            5: anodedata = 8'b1111_0111; //AN3
            4: anodedata = 8'b1110_1111; //AN4
            3: anodedata = 8'b1111_1111; //AN5
            2: anodedata = 8'b1011_1111; //AN6
            1: anodedata = 8'b0111_1111; //AN7
            default:
            anodedata = 8'b1111_1111; //all OFF
        endcase
    end 
    
endmodule
