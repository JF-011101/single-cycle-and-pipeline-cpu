//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 09:39:17
// Design Name: 
// Module Name: id_module
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


module id_module(
    input   clk,
    input   rst_n,
    //input   branch,
    input   [31:0]  wD,
    input   [31:0]  inst,           //指令
    input   [4:0]   i_wR,
    input   i_rf_we,
    input   [31:0]  wD_from_ex,
    input   [31:0]  wD_from_mem,
    input   [1:0]   rD1_sel,
    input   [1:0]   rD2_sel,
    output  [31:0]  rD1,
    output  [31:0]  rD2,
    output  [31:0]  ext,         //符号扩展之后的32位数
    output  pc_sel,
    output  npc_op,
    output  [3:0]   alu_op,
    output  alub_sel,
    output  dram_we,
    output  [1:0]  wd_sel,
    output  reg [4:0]   o_wR,
    output  o_rf_we,
    output [31:0] rdatax19
    );
    
wire    [2:0]   sext_op;
wire    [31:0]  rD1_tmp;
wire    [31:0]  rD2_tmp;
wire    [1:0]   branch;
    
/*rf_mux u_rf_mux(
    .wd_sel(wd_sel),
    .alu_c(alu_c),
    .npc_pc4(npc_pc4),
    .dram_rd(dram_rd),
    .wD(wD)
);*/

always @ (inst) begin
    o_wR=inst[11:7];
end
    
rf u_rf(
    .clk(clk),
    .rst_n(rst_n),
    .rf_we(i_rf_we),
    .rR1(inst[19:15]),
    .rR2(inst[24:20]),
    .wR(i_wR),
    .wD(wD),
    .rD1(rD1_tmp),
    .rD2(rD2_tmp),
    .rdatax19(rdatax19)
);

rD1_mux u_rD1_mux(
    .rst_n(rst_n),
    .rD1_sel(rD1_sel),
    .rD1(rD1_tmp),
    .wD_from_ex(wD_from_ex),
    .wD_from_mem(wD_from_mem),
    .real_rD1(rD1)
);

rD2_mux u_rD2_mux(
    .rst_n(rst_n),
    .rD2_sel(rD2_sel),
    .rD2(rD2_tmp),
    .wD_from_ex(wD_from_ex),
    .wD_from_mem(wD_from_mem),
    .real_rD2(rD2)
);

id_branch_cmp u_id_branch_cmp(
    .rD1(rD1),
    .rD2(rD2),
    .branch(branch)
);

cu u_cu(
    .rst_n(rst_n),
    .inst(inst),
    .branch(branch),
    .pc_sel(pc_sel),
    .npc_op(npc_op),
    .rf_we(o_rf_we),
    .wd_sel(wd_sel),
    .sext_op(sext_op),
    .alu_op(alu_op),
    .alub_sel(alub_sel),
    .dram_we(dram_we)
);

sext u_sext(
    .sext_op(sext_op),
    .inst(inst),
    .ext(ext)
);
    
    
endmodule
