`timescale 1ns / 1ps
module decoder(input [7:0] ir_in,
    output reg nop,outb,outs,add_s,sub_s,and_s,div_s,mul_s,shl,
    clr_s, psah,shr,load,jz,jmp,jge,mov_ah_cr,mov_ah_dr,
    mov_tmp_ah, mov_tmp_br,mov_tmp_cr,mov_tmp_dr,
    mov_tmp_rr,mov_cr_ah,mov_cr_br,mov_dr_ah, mov_dr_tmp,
    mov_dr_br,mov_rr_ah,mov_key_ah,mov_inr_tmp,mov_inr_rr);
    always @(ir_in) begin
    {nop,outb,outs,add_s,sub_s,and_s,div_s,mul_s,shl,clr_s,
    psah,shr,load,jz,jmp,jge,mov_ah_cr,mov_ah_dr,
    mov_tmp_ah,mov_tmp_br,mov_tmp_cr,mov_tmp_dr,
    mov_tmp_rr,mov_cr_ah, mov_cr_br,mov_dr_ah,
    mov_dr_tmp,mov_dr_br,mov_rr_ah,mov_key_ah,
    mov_inr_tmp,mov_inr_rr}=0;

case(ir_in)
8'h00: nop=1;
8'h0B: outb=1;
8'h07: outs=1;
8'h50: add_s=1;
8'h52: sub_s=1;
8'h54: and_s=1;
8'h55: div_s=1;
8'h51: mul_s=1;
8'h15: shl=1;
8'h10: clr_s=1;
8'h14: psah=1;
8'h16: shr=1;
8'hD6: load=1;
8'hD0: jz=1;
8'hD4: jmp=1;
8'hD2: jge=1;
8'h83: mov_ah_cr=1;
8'h84: mov_ah_dr=1;
8'h88: mov_tmp_ah=1;
8'h8A: mov_tmp_br=1;
8'h8B: mov_tmp_cr=1;
8'h8C: mov_tmp_dr=1;
8'h8D: mov_tmp_rr=1;
8'h98: mov_cr_ah=1;
8'h9A: mov_cr_br=1;
8'hA0: mov_dr_ah=1;
8'hA1: mov_dr_tmp=1;
8'hA2: mov_dr_br=1;
8'hA8: mov_rr_ah=1;
8'hB0: mov_key_ah=1;
8'hB9: mov_inr_tmp=1;
8'hBD: mov_inr_rr=1;
default : nop=1;
endcase
end
endmodule