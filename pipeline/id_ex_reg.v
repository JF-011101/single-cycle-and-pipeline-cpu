//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 10:01:42
// Design Name: 
// Module Name: id_ex_reg
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


module id_ex_reg(
    input   clk,
    input   rst_n,
    input   stop,
    input   flush,
    input   [31:0]  id_rD1,
    input   [31:0]  id_rD2,
    input   [31:0]  id_ext,
    input   [4:0]   id_wR,
    input   id_rf_we,
    input   [1:0]   id_wd_sel,
    input   [3:0]   id_alu_op,
    input   id_alub_sel,
    input   id_dram_we,
    input   [31:0]  id_pc4,
    input   [6:0]   id_opcode,
    input   id_pc_sel,
    input   id_npc_op,
    input   [31:0]  id_pc,
    input   id_have_inst,
    output  reg [31:0]  ex_rD1,
    output  reg [31:0]  ex_rD2,
    output  reg [31:0]  ex_ext,         //符号扩展之后的32位数
    output  reg [4:0]   ex_wR,
    output  reg [1:0]   ex_wd_sel,
    output  reg ex_rf_we,
    output  reg [3:0]   ex_alu_op,
    output  reg ex_alub_sel,
    output  reg ex_dram_we,
    output  reg [31:0]  ex_pc4,
    output  reg [6:0]   ex_opcode,
    output  reg ex_pc_sel,
    output  reg ex_npc_op,
    output  reg [31:0]  ex_pc,
    output  reg ex_have_inst
    );
    
wire ram_clk;
assign ram_clk = !clk;
    
always @ (posedge ram_clk) begin
    if(rst_n=='b0) begin
        ex_rf_we<='b0;
        ex_dram_we<='b0;
        ex_pc4<='b0;
        ex_opcode<='b0;
        ex_pc_sel<='b0;
        ex_npc_op<=`PC_PLUS_4;
        ex_have_inst<='b0;
    end
    else if(flush=='b1) begin
        ex_rf_we<='b0;
        ex_dram_we<='b0;
        ex_pc_sel<='b0;
        ex_npc_op<=`PC_PLUS_4;
        ex_have_inst<='b0;
    end
    else if(stop=='b1) begin
        ex_rf_we<='b0;
        ex_dram_we<='b0;
        ex_have_inst<='b0;
    end
    else begin
        ex_rD1<=id_rD1;
        ex_rD2<=id_rD2;
        ex_ext<=id_ext;
        ex_wR<=id_wR;
        ex_rf_we<=id_rf_we;
        ex_wd_sel<=id_wd_sel;
        ex_alu_op<=id_alu_op;
        ex_alub_sel<=id_alub_sel;
        ex_dram_we<=id_dram_we;
        ex_pc4<=id_pc4;
        ex_opcode<=id_opcode;
        ex_pc_sel<=id_pc_sel;
        ex_npc_op<=id_npc_op;
        ex_have_inst<=id_have_inst;
        ex_pc<=id_pc;
    end
end
    
endmodule
