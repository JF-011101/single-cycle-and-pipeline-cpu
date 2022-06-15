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
    
assign    debug_wb_reg=mem_wb_o_wR;
assign    debug_wb_ena=mem_wb_o_rf_we;
assign    debug_wb_value=mem_wb_o_wD;

wire    pc_sel;
wire    npc_op;
    
wire    [31:0]  if_id_i_inst;
wire    [31:0]  if_id_o_inst;
wire    [31:0]  if_id_i_pc4;
wire    [31:0]  if_id_o_pc4;
wire    [31:0]  if_id_i_pc;
wire    [31:0]  if_id_o_pc;
wire    if_id_o_have_inst;

wire    [31:0]  id_ex_i_rD1;
wire    [31:0]  id_ex_i_rD2;
wire    [31:0]  id_ex_i_ext;
wire    [4:0]   id_ex_i_wR;
wire    id_ex_i_rf_we;
wire    [1:0]   id_ex_i_wd_sel;
wire    [3:0]   id_ex_i_alu_op;
wire    id_ex_i_alub_sel;
wire    id_ex_i_dram_we;
wire    [31:0]  id_ex_i_pc4;
wire    [31:0]  id_ex_o_rD1;
wire    [31:0]  id_ex_o_rD2;
wire    [31:0]  id_ex_o_ext;
wire    [4:0]   id_ex_o_wR;
wire    id_ex_o_rf_we;
wire    [1:0]   id_ex_o_wd_sel;
wire    [3:0]   id_ex_o_alu_op;
wire    id_ex_o_alub_sel;
wire    id_ex_o_dram_we;
wire    [31:0]  id_ex_o_pc4;
wire    [6:0]   id_ex_o_opcode;
wire    id_ex_o_pc_sel;
wire    id_ex_o_npc_op;
wire    [31:0]  id_ex_o_pc;
wire    id_ex_o_have_inst;

wire    [1:0]   rD1_sel;
wire    [1:0]   rD2_sel;

wire    load_use_hazard;
wire    stop;
wire    flush;

wire   [31:0]  ex_mem_i_alu;
wire   ex_mem_i_rf_we;
wire   [1:0]   ex_mem_i_wd_sel;
wire   ex_mem_i_dram_we;
wire   [31:0]  ex_mem_i_pc4;
wire   [4:0]   ex_mem_i_wR;
wire   [31:0]  ex_mem_i_rD2;
wire   [31:0]  ex_mem_o_alu;
wire   ex_mem_o_rf_we;
wire   [1:0]   ex_mem_o_wd_sel;
wire   ex_mem_o_dram_we;
wire   [31:0]  ex_mem_o_pc4;
wire   [4:0]   ex_mem_o_wR;
wire   [31:0]  ex_mem_o_rD2;
wire   [31:0]  ex_mem_o_pc;
wire   ex_mem_o_have_inst;

wire   [31:0]  mem_wb_i_wD;
wire   mem_wb_i_rf_we;
wire   [4:0]   mem_wb_i_wR;
wire   [31:0]  mem_wb_o_wD;
wire   mem_wb_o_rf_we;
wire   [4:0]   mem_wb_o_wR;


    
if_module u_if_module(
    .clk(clk),
    .rst_n(rst_n),
    .stop(stop),
    .pc_sel(id_ex_o_pc_sel),
    .npc_op(id_ex_o_npc_op),
    .alu(ex_mem_i_alu),
    .imm(id_ex_o_ext),
    .opcode(id_ex_o_opcode),
    .inst(if_id_i_inst),
    .pc4(if_id_i_pc4),
    .pc_o(if_id_i_pc)
);

if_id_reg   u_if_id_reg(
    .clk(clk),
    .rst_n(rst_n),
    //.stop(stop),
    .flush(flush),
    .if_inst(if_id_i_inst),
    .if_pc4(if_id_i_pc4),
    .if_pc(if_id_i_pc),
    .id_inst(if_id_o_inst),
    .id_pc4(if_id_o_pc4),
    .id_pc(if_id_o_pc),
    .id_have_inst(if_id_o_have_inst)
);

id_module u_id_module(
    .clk(clk),
    .rst_n(rst_n),
    .wD(mem_wb_o_wD),
    .inst(if_id_o_inst),
    .i_rf_we(mem_wb_o_rf_we),
    .wD_from_ex(ex_mem_i_alu),
    .wD_from_mem(mem_wb_i_wD),
    .rD1_sel(rD1_sel),
    .rD2_sel(rD2_sel),
    .i_wR(mem_wb_o_wR),
    .rD1(id_ex_i_rD1),
    .rD2(id_ex_i_rD2),
    .ext(id_ex_i_ext),
    .pc_sel(pc_sel),
    .npc_op(npc_op),
    .alu_op(id_ex_i_alu_op),
    .alub_sel(id_ex_i_alub_sel),
    .dram_we(id_ex_i_dram_we),
    .wd_sel(id_ex_i_wd_sel),
    .o_wR(id_ex_i_wR),
    .o_rf_we(id_ex_i_rf_we),
    .rdatax19(rdatax19)
);

hazard_detection_unit u_hazard_detection_unit(
    .rst_n(rst_n),
    .pc_sel(id_ex_o_pc_sel),
    .npc_op(id_ex_o_npc_op),
    .flush(flush)
);

forwarding_unit u_forwarding_unit(
    .rst_n(rst_n),
    .rR1(if_id_o_inst[19:15]),
    .rR2(if_id_o_inst[24:20]),
    .rf_we_from_ex(id_ex_o_rf_we),
    .wR_from_ex(id_ex_o_wR),
    .rf_we_from_mem(ex_mem_o_rf_we),
    .wR_from_mem(ex_mem_o_wR),
    .opcode_from_ex(id_ex_o_opcode),
    .rD1_sel(rD1_sel),
    .rD2_sel(rD2_sel),
    .load_use_hazard(load_use_hazard)
);

stop_pipelined_unit u_stop_pipelined_unit(
    .rst_n(rst_n),
    .load_use_hazard(load_use_hazard),
    .stop(stop)
);

assign  id_ex_i_pc4=if_id_o_pc4;

id_ex_reg   u_id_ex_reg(
    .clk(clk),
    .rst_n(rst_n),
    .stop(stop),
    .flush(flush),
    .id_rD1(id_ex_i_rD1),
    .id_rD2(id_ex_i_rD2),
    .id_ext(id_ex_i_ext),
    .id_wR(id_ex_i_wR),
    .id_rf_we(id_ex_i_rf_we),
    .id_wd_sel(id_ex_i_wd_sel),
    .id_alu_op(id_ex_i_alu_op),
    .id_alub_sel(id_ex_i_alub_sel),
    .id_dram_we(id_ex_i_dram_we),
    .id_pc4(id_ex_i_pc4),
    .id_opcode(if_id_o_inst[6:0]),
    .id_pc_sel(pc_sel),
    .id_npc_op(npc_op),
    .id_pc(if_id_o_pc),
    .id_have_inst(if_id_o_have_inst),
    .ex_rD1(id_ex_o_rD1),
    .ex_rD2(id_ex_o_rD2),
    .ex_ext(id_ex_o_ext),
    .ex_wR(id_ex_o_wR),
    .ex_rf_we(id_ex_o_rf_we),
    .ex_wd_sel(id_ex_o_wd_sel),
    .ex_alu_op(id_ex_o_alu_op),
    .ex_alub_sel(id_ex_o_alub_sel),
    .ex_dram_we(id_ex_o_dram_we),
    .ex_pc4(id_ex_o_pc4),
    .ex_opcode(id_ex_o_opcode),
    .ex_pc_sel(id_ex_o_pc_sel),
    .ex_npc_op(id_ex_o_npc_op),
    .ex_pc(id_ex_o_pc),
    .ex_have_inst(id_ex_o_have_inst)
);

ex_module u_ex_module(
    .alub_sel(id_ex_o_alub_sel),
    .A(id_ex_o_rD1),
    .rD2(id_ex_o_rD2),
    .ext(id_ex_o_ext),
    .alu_op(id_ex_o_alu_op),
    .zero(zero),
    .branch(branch),
    .C(ex_mem_i_alu)
);

assign  ex_mem_i_rf_we=id_ex_o_rf_we;
assign  ex_mem_i_wd_sel=id_ex_o_wd_sel;
assign  ex_mem_i_dram_we=id_ex_o_dram_we;
assign  ex_mem_i_pc4=id_ex_o_pc4;
assign  ex_mem_i_wR=id_ex_o_wR;
assign  ex_mem_i_rD2=id_ex_o_rD2;

ex_mem_reg  u_ex_mem_reg(
    .clk(clk),
    .rst_n(rst_n),
    .ex_alu(ex_mem_i_alu),
    .ex_rf_we(ex_mem_i_rf_we),
    .ex_wd_sel(ex_mem_i_wd_sel),
    .ex_dram_we(ex_mem_i_dram_we),
    .ex_pc4(ex_mem_i_pc4),
    .ex_wR(ex_mem_i_wR),
    .ex_rD2(ex_mem_i_rD2),
    .ex_pc(id_ex_o_pc),
    .ex_have_inst(id_ex_o_have_inst),
    .mem_alu(ex_mem_o_alu),
    .mem_rf_we(ex_mem_o_rf_we),
    .mem_wd_sel(ex_mem_o_wd_sel),
    .mem_dram_we(ex_mem_o_dram_we),
    .mem_pc4(ex_mem_o_pc4),
    .mem_wR(ex_mem_o_wR),
    .mem_rD2(ex_mem_o_rD2),
    .mem_pc(ex_mem_o_pc),
    .mem_have_inst(ex_mem_o_have_inst)
);

mem_module u_mem_module(
    .clk(clk),
    .alu(ex_mem_o_alu),
    .dram_we(ex_mem_o_dram_we),
    .rD2(ex_mem_o_rD2),
    .wd_sel(ex_mem_o_wd_sel),
    .pc4(ex_mem_o_pc4),
    .wD(mem_wb_i_wD)
);

assign  mem_wb_i_rf_we=ex_mem_o_rf_we;
assign  mem_wb_i_wR=ex_mem_o_wR;

mem_wb_reg  u_mem_wb_reg(
    .clk(clk),
    .rst_n(rst_n),
    .mem_wD(mem_wb_i_wD),
    .mem_rf_we(mem_wb_i_rf_we),
    .mem_wR(mem_wb_i_wR),
    .mem_pc(ex_mem_o_pc),
    .mem_have_inst(ex_mem_o_have_inst),
    .wb_wD(mem_wb_o_wD),
    .wb_rf_we(mem_wb_o_rf_we),
    .wb_wR(mem_wb_o_wR),
    .wb_pc(debug_wb_pc),
    .wb_have_inst(debug_wb_have_inst)
);
    
endmodule
