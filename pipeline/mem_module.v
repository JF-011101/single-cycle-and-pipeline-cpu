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
    input   [31:0]  alu,     // ��Դ��ִ�е�Ԫ������ķô��ַ
    input           dram_we,    // ���Կ��Ƶ�Ԫ��дʹ���ź�
    input   [31:0]  rD2,   // rD2 (S��ָ���rs2�Ĵ�����ֵ)
	input	[1:0]	wd_sel,
	input   [31:0]  pc4,
	output  [31:0]  wD         // Ҫд�ص�����
    );
	
wire	[31:0]	dram_rd;		// �Ӵ洢���ж�ȡ����������
    
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

