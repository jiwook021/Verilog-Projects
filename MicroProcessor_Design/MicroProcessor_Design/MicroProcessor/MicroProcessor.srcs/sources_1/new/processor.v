`timescale 1ns / 1ps
module processor(clk,clr,data,valid,hout,lout,kout);

    input clk,clr;
    input [3:0] data;
    input valid;
    output [3:0] hout,lout,kout;
    wire [7:0] int_bus;
    wire [3:0] kout, hout, lout;
    wire s_f,z_f;
    wire pc_oen,mar_inen,rom_en,mdr_inen,pc_inc,mdr_oen,ir_inen,tmp_inen,tmp_oen,creg_inen, creg_oen,reg_inen,dreg_oen,rreg_inen, rreg_oen, breg_inen,inreg_oen,keych_oen,outreg_inen,
    keyout_inen, load_pc,acc_oen,ah_inen, ah_reset, adds,subs,ands,divs,muls;
    wire [1:0] hs,ls;
    wire valid;
    wire [3:0] keych_in;
    assign keych_in=(valid)?4'b1111:4'b0000;

    reg4 inreg(
    .data_out(int_bus[7:4]),
    .data_in(data), //keyboard intpu
    .inen(1'b1),
    .oen(inreg_oen),
    .clk(clk),
    .clr(clr)
    );
    
    reg4 keych_reg(
    .data_out(int_bus[7:4]),
    .data_in(keych_in),
    .inen(1'b1),
    .oen(keych_oen),
    .clk(clk),
    .clr(clr)
    );

    wire [7:0] mar_out;

    reg8 mar(
    .data_out(mar_out),
    .data_in(int_bus),
    .inen(mar_inen),
    .oen(1'b1),
    .clk(clk),
    .clr(clr)
    );

    wire [7:0] rom_out;
    
    rom ROM(
    .a(mar_out), // input wire [7 : 0] a
    .qspo_ce(rom_en), // input wire qspo_ce
    .spo(rom_out)
    ); 

    reg8 mdr(.data_out(int_bus),
    .data_in(rom_out),
    .inen(mdr_inen),
    .oen(mdr_oen),
    .clk(clk),
    .clr(clr)
    );

    wire [7:0] ir_out;

    reg8 ir (
    .data_out(ir_out),
    .data_in(int_bus),
    .inen(ir_inen),
    .oen(1'b1),
    .clk(clk),
    .clr(clr)
    );

    control_block ctrl_block(
    .z_f(z_f),
    .s_f(s_f),
    .clk(clk),
    .clr(clr),
    .opcode(ir_out),
    .pc_oen(pc_oen),
    .mar_inen(mar_inen),
    .rom_en(rom_en),
    .mdr_inen(mdr_inen),
    .pc_inc(pc_inc),
    .mdr_oen(mdr_oen),
    .ir_inen(ir_inen),
    .tmp_inen(tmp_inen),
    .tmp_oen(tmp_oen),
    .creg_inen(creg_inen),
    .creg_oen(creg_oen),
    .dreg_inen(dreg_inen),
    .dreg_oen(dreg_oen),
    .rreg_inen(rreg_inen),
    .rreg_oen(rreg_oen),
    .breg_inen(breg_inen),
    .inreg_oen(inreg_oen),
    .keych_oen(keych_oen),
    .outreg_inen(outreg_inen),
    .keyout_inen(keyout_inen),
    .load_pc(load_pc),
    .acc_oen(acc_oen),
    .ah_inen(ah_inen),
    .ah_reset(ah_reset),
    .adds(adds),
    .subs(subs),
    .ands(ands),
    .divs(divs),
    .muls(muls),
    .hs(hs), .ls(ls)
    );
    pc pc(
    .clk(clk),
    .clr(clr),
    .pc_inc(pc_inc),
    .load_pc(load_pc),
    .pc_oen(pc_oen),
    .pc_input(int_bus),
    .pc_out(int_bus)
    );
    
    wire [3:0] breg_out;
    
    reg4 breg(
    .data_out(breg_out),
    .data_in(int_bus[7:4]),
    .inen(breg_inen),
    .oen(1'b1),
    .clk(clk),
    .clr(clr));
    
    aluNacc alunacc(
    .ah_reset(ah_reset),
    .ah_inen(ah_inen),
    .s_sub(subs),
    .s_and(ands),
    .s_div(divs),
    .s_add(adds),
    .s_mul(muls),
    .clr(clr),
    .acc_oen(acc_oen),
    .clk(clk),
    .breg_in(breg_out),
    .bus_in(int_bus[7:4]),
    .hs(hs),
    .ls(ls),
    .sign_flag(s_f),
    .zero_flag(z_f),
    .acc_out(int_bus)
    );
    reg4 tmp_reg(
    .data_out(int_bus[7:4]),
    .data_in(int_bus[7:4]),
    .inen(tmp_inen),
    .oen(tmp_oen),
    .clk(clk),
    .clr(clr)
    );
    
    reg4 creg(
    .data_out(int_bus[7:4]),
    .data_in(int_bus[7:4]),
    .inen(creg_inen),
    .oen(creg_oen),
    .clk(clk),
    .clr(clr)
    );
    
    reg4 dreg(
    .data_out(int_bus[7:4]),
    .data_in(int_bus[7:4]),
    .inen(dreg_inen),
    .oen(dreg_oen),
    .clk(clk),
    .clr(clr)
    );
    
    reg4 rreg(
    .data_out(int_bus[7:4]),
    .data_in(int_bus[7:4]),
    .inen(rreg_inen), 
    .oen(rreg_oen),
    .clk(clk),
    .clr(clr)
    );
    
    wire [7:0] outreg_out;
    
    reg8 outreg(
    .data_out(outreg_out),
    .data_in(int_bus),
    .inen(outreg_inen),
    .oen(1'b1),
    .clk(clk),
    .clr(clr)
    );
    hex2dec hex2dec(
    .h(outreg_out),
    .dec_h(hout),
    .dec_l(lout)
    );
    reg4 keyout(
    .data_out(kout),
    .data_in(int_bus[7:4]),
    .inen(keyout_inen),
    .oen(1'b1),
    .clk(clk),
    .clr(clr)
    );
endmodule
