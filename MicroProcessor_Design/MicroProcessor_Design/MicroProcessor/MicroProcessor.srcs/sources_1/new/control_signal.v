`timescale 1ns / 1ps
module control_signal (t,s_flag,z_flag,
nop,outb,outs,add_s,sub_s,and_s,div_s,
mul_s,shl,clr_s,psah,shr,load,jz,jmp,jge,
mov_ah_cr,mov_ah_dr,mov_tmp_ah,
mov_tmp_br,mov_tmp_cr,mov_tmp_dr,
mov_tmp_rr,mov_cr_ah, mov_cr_br,
mov_dr_ah,mov_dr_tmp,mov_dr_br,
mov_rr_ah,mov_key_ah,mov_inr_tmp,
mov_inr_rr,pc_oen,mar_inen,rom_en,
mdr_inen,pc_inc,mdr_oen,ir_inen,
tmp_inen,tmp_oen,creg_inen,creg_oen,
dreg_inen,dreg_oen,rreg_inen,rreg_oen,
breg_inen,inreg_oen,keych_oen,
outreg_inen,keyout_inen,load_pc,
acc_oen,ah_inen,ah_reset,adds,subs,
ands,divs,muls,hs,ls );

input [11:0] t;
input s_flag,z_flag, nop, outb, outs,
add_s, sub_s, and_s, div_s, mul_s,
shl, clr_s, psah, shr,load,
jz, jmp, jge, mov_ah_cr, mov_ah_dr,
mov_tmp_ah, mov_tmp_br, mov_tmp_cr,
mov_tmp_dr, mov_tmp_rr,
mov_cr_ah, mov_cr_br,
mov_dr_ah, mov_dr_br, mov_dr_tmp,
mov_rr_ah, mov_key_ah,
mov_inr_tmp, mov_inr_rr;
output pc_oen,mar_inen,rom_en,mdr_inen,
pc_inc,mdr_oen,ir_inen,tmp_inen,tmp_oen,creg_inen,creg_oen,dreg_inen,dreg_oen
,rreg_inen,rreg_oen,breg_inen,inreg_oen,keych_oen,outreg_inen,keyout_inen,
load_pc,acc_oen,ah_inen,ah_reset,adds,
subs,ands,divs,muls;
output [1:0] hs;
output [1:0] ls;
assign pc_oen = t[0]|((load|jz|jmp|jge)&t[3]);
assign mar_inen = t[0]|((load|jz|jmp|jge)&t[3]);
assign rom_en = ~(t[1]|((load|jz|jmp|jge)&t[4]));
assign mdr_inen = t[1]|((load|jz|jmp|jge)&t[4]);
assign pc_inc = t[1]|((load|jz|jmp|jge)&t[4]);
assign mdr_oen = t[2]|((load|(z_flag&jz)|(~s_flag&jge)|jmp)&t[5]);
assign ir_inen = t[2];
assign tmp_inen = (t[3]&(mov_dr_tmp|mov_inr_tmp))|(t[5]&load);
assign tmp_oen = t[3]&(outb|mov_tmp_ah|mov_tmp_br|mov_tmp_cr |
mov_tmp_dr|mov_tmp_rr);
assign creg_inen = t[3]&(mov_ah_cr|mov_tmp_cr);
assign creg_oen = t[3]&(mov_cr_ah|mov_cr_br);
assign dreg_inen = t[3]&(mov_ah_dr|mov_tmp_dr);
assign dreg_oen = t[3]&(mov_dr_ah|mov_dr_br|mov_dr_tmp);
assign rreg_inen = t[3]&(mov_tmp_rr|mov_inr_rr);
assign rreg_oen = t[3]&mov_rr_ah;
assign breg_inen = t[3]&(mov_tmp_br|mov_cr_br|mov_dr_br);
assign inreg_oen = t[3]&(mov_inr_tmp|mov_inr_rr);
assign keych_oen = t[3]&mov_key_ah;
assign outreg_inen = t[3]&outs;
assign keyout_inen = t[3]&outb;
assign load_pc = t[5]&((z_flag&jz)|(~s_flag&jge)|jmp);
assign acc_oen = t[3]&(outs|mov_ah_cr|mov_ah_dr);
assign ah_inen = t[3]&(mov_tmp_ah|mov_cr_ah|mov_rr_ah|mov_key_ah|mov_dr_ah);
assign ah_reset = t[3]&clr_s;
assign hs[1] = (t[3]&(add_s|sub_s|and_s|div_s|mul_s|shl|mov_tmp_ah|mov_cr_ah|
mov_rr_ah|mov_key_ah|mov_dr_ah))|(mul_s&(t[5]|t[7]|t[9]))|
(div_s&(t[4]|t[5]|t[6]|t[7]|t[8]|t[9]|t[10]));
assign hs[0] = (t[3]&(add_s|sub_s|and_s|mul_s|shr|mov_tmp_ah|mov_cr_ah|mov_rr_ah|
mov_key_ah|mov_dr_ah))|(t[4]&(add_s|div_s|mul_s))|
(mul_s&(t[5]|t[6]|t[7]|t[8]|t[9]|t[10]))| (div_s&(t[6]|t[8]|t[10]));
assign ls[1] = (t[3]&(div_s|psah|shl))|(div_s&(t[5]|t[7]|t[9]|t[11]));
assign ls[0] = (t[3]&(psah|shr))|(t[4]&(add_s|mul_s))|(mul_s&(t[6]|t[8]|t[10]));
assign adds = t[3]&add_s;
assign subs = t[3]&sub_s;
assign ands = t[3]&and_s;
assign divs = div_s&(t[4]|t[6]|t[8]|t[10]);
assign muls = mul_s&(t[3]|t[5]|t[7]|t[9]);
endmodule