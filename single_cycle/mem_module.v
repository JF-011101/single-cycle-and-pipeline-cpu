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
    input   [31:0]  adr,     // 来源于执行单元计算出的访存地址
    output  [31:0]  rd,         // 从存储器中获得的数据
    input           dram_we,    // 来自控制单元的写使能信号
    input   [31:0]  rD2   // rD2 (S型指令的rs2寄存器的值)
    );
    
dmemory32 u_dmemory32(
    .clk    (clk),
    .adr      (adr),
    .rd   (rd),
    .dram_we     (dram_we),
    .rD2      (rD2)
);
endmodule
