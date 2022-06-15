//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 11:43:14
// Design Name: 
// Module Name: mem_module
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


module mem_module(
    input           clk,
    input   [31:0]  alu,     // 来源于执行单元计算出的访存地址
    input           dram_we,    // 来自控制单元的写使能信号
    input   [31:0]  rD2,   // rD2 (S型指令的rs2寄存器的值)
	input	[1:0]	wd_sel,
	input   [31:0]  pc4,
	output  [31:0]  wD         // 要写回的数据
    );
	
wire	[31:0]	dram_rd;		// 从存储器中读取出来的数据
    
dmemory32 u_dmemory32(
    .clk    (clk),
    .adr      (alu),
    .rd   (dram_rd),
    .dram_we     (dram_we),
    .rD2      (rD2)
);

rf_mux u_rf_mux(
    .wd_sel(wd_sel),
    .alu_c(alu),
    .npc_pc4(pc4),
    .dram_rd(dram_rd),
    .wD(wD)
);
endmodule

