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
    input   rf_we,
    input   [1:0]   wd_sel,
    input   [4:0]   rR1,
    input   [4:0]   rR2,
    input   [4:0]   wR,
    input   [31:0]  alu_c,
    input   [31:0]  npc_pc4,
    input   [31:0]  dram_rd,
    input   [2:0]   sext_op,                //选择哪种类型的指令的符号扩展
    input   [31:0]  inst,           //指令
    output  [31:0]  rD1,
    output  [31:0]  rD2,
    output  [31:0]  ext,         //符号扩展之后的32位数
    output  [31:0]  wD,
    output  [31:0]  rdatax19
    );
    
rf_mux u_rf_mux(
    .wd_sel(wd_sel),
    .alu_c(alu_c),
    .npc_pc4(npc_pc4),
    .dram_rd(dram_rd),
    .wD(wD)
);
    
rf u_rf(
    .clk(clk),
    .rst_n(rst_n),
    .rf_we(rf_we),
    .rR1(rR1),
    .rR2(rR2),
    .wR(wR),
    .wD(wD),
    .rD1(rD1),
    .rD2(rD2),
    .rdatax19(rdatax19)
);


sext u_sext(
    .sext_op(sext_op),
    .inst(inst),
    .ext(ext)
);
    
    
endmodule
