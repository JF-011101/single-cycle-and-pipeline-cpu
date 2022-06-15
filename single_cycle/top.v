//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 15:11:13
// Design Name: 
// Module Name: cpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input   clk,
    input   rst_n,
    output        debug_wb_have_inst,   // WB阶段是否有指令 (对单周期CPU，此flag恒为1)
    output [31:0] debug_wb_pc,          // WB阶段的PC (若wb_have_inst=0，此项可为任意值)
    output        debug_wb_ena,         // WB阶段的寄存器写使能 (若wb_have_inst=0，此项可为任意值)
    output [4:0]  debug_wb_reg,         // WB阶段写入的寄存器号 (若wb_ena或wb_have_inst=0，此项可为任意值)
    output [31:0] debug_wb_value,        // WB阶段写入寄存器的值 (若wb_ena或wb_have_inst=0，此项可为任意值)
    output [31:0] rdatax19
    );
    
assign    debug_wb_have_inst='b1;
assign    debug_wb_ena=rf_we;
assign    debug_wb_reg=inst[11:7];
    
wire    [31:0]  inst;
wire    pc_sel;
wire    alub_sel;
wire    [1:0]   branch;
wire    dram_we;
wire    [1:0]   wd_sel;
wire    rf_we;
wire    [1:0]   npc_op;
wire    [2:0]   sext_op;
wire    [3:0]   alu_op;
wire    [31:0]  npc;
wire    [31:0]  pc4;
wire    [31:0]  imm;
wire    [31:0]  alu;
wire    [31:0]  rD1;
wire    [31:0]  rD2;
wire    [31:0]  rd;
wire    zero;
    
if_module u_if_module(
    .clk(clk),
    .rst_n(rst_n),
    .pc_sel(pc_sel),
    .npc_op(npc_op),
    .alu(alu),
    .imm(imm),
    .inst(inst),
    .npc(npc),
    .pc4(pc4),
    .pc_o(debug_wb_pc)
);

cu u_cu(
    .rst_n(rst_n),
    .inst(inst),
    .branch(branch),
    .pc_sel(pc_sel),
    .npc_op(npc_op),
    .rf_we(rf_we),
    .wd_sel(wd_sel),
    .sext_op(sext_op),
    .alu_op(alu_op),
    .alub_sel(alub_sel),
    .dram_we(dram_we)
);

id_module u_id_module(
    .clk(clk),
    .rst_n(rst_n),
    .rf_we(rf_we),
    .wd_sel(wd_sel),
    .rR1(inst[19:15]),
    .rR2(inst[24:20]),
    .wR(inst[11:7]),
    .alu_c(alu),
    .npc_pc4(pc4),
    .dram_rd(rd),
    .sext_op(sext_op),
    .inst(inst),
    .rD1(rD1),
    .rD2(rD2),
    .ext(imm),
    .wD(debug_wb_value),
    .rdatax19(rdatax19)
);

ex_module u_ex_module(
    .alub_sel(alub_sel),
    .A(rD1),
    .rD2(rD2),
    .ext(imm),
    .alu_op(alu_op),
    .zero(zero),
    .branch(branch),
    .C(alu)
);

mem_module u_mem_module(
    .clk(clk),
    .adr(alu),
    .rd(rd),
    .dram_we(dram_we),
    .rD2(rD2)
);
    
endmodule
