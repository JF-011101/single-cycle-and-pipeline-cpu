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
    input   [31:0]  adr,     // ��Դ��ִ�е�Ԫ������ķô��ַ
    output  [31:0]  rd,         // �Ӵ洢���л�õ�����
    input           dram_we,    // ���Կ��Ƶ�Ԫ��дʹ���ź�
    input   [31:0]  rD2   // rD2 (S��ָ���rs2�Ĵ�����ֵ)
    );
    
dmemory32 u_dmemory32(
    .clk    (clk),
    .adr      (adr),
    .rd   (rd),
    .dram_we     (dram_we),
    .rD2      (rD2)
);
endmodule
