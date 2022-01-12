//`timescale 1ns / 1ps

//module BCD_Converter(input [2:0] F, input [4:0] data, output [3:0] tens, output [3:0] ones);

//    assign tens = (F == 3'b000) ? data / 10 : (F == 3'b001) ? (data[3] == 1) ? 4'ha : 0 : 0;
//    assign ones = (F == 3'b000) ? data % 10 : (F == 3'b001) ? (data[3] == 1) ? {(~data[3:0] + 1)} : {data[3:0]} : 0;

//endmodule


`timescale 1ns / 1ps

module BCD_Converter(input [2:0] F, input [3:0] data, output [3:0] tens, output [3:0] ones);

    assign tens = 0;
    assign ones = (data[3] == 1) ? (~data + 1) % 10 : data % 10;

endmodule
