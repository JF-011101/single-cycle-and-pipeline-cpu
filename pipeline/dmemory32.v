//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 11:27:46
// Design Name: 
// Module Name: dmemory32
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


module dmemory32(
    input           clk,
    input   [31:0]  adr,     // ��Դ��ִ�е�Ԫ������ķô��ַ
    output  [31:0]  rd,         // �Ӵ洢���л�õ�����
    input           dram_we,    // ���Կ��Ƶ�Ԫ��дʹ���ź�
    input   [31:0]  rD2   // rD2 (S��ָ���rs2�Ĵ�����ֵ)
    );
    
//wire ram_clk;
//assign ram_clk = !clk; // ��ΪоƬ�Ĺ����ӳ٣�DRAM�ĵ�ַ����������ʱ��������׼����,
// ʹ��ʱ�����������ݶ����������Բ��÷���ʱ�ӣ�ʹ�ö������ݱȵ�ַ׼����Ҫ���Լ���ʱ��,
// �Ӷ��ܹ������ȷ�����ݡ�


// 64KB DRAM
data_mem dmem (
    .clk    (clk),            // input wire clka
    .a      (adr[15:2]),     // input wire [13:0] addra
    .spo   (rd),        // output wire [31:0] douta
    .we     (dram_we),          // input wire [0:0] wea
    .d      (rD2)         // input wire [31:0] dina
);
    
endmodule
