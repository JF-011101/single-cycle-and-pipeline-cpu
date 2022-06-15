//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/30 15:21:16
// Design Name: 
// Module Name: if_module
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


module if_module(
    input   clk,
    input   rst_n,
    input   pc_sel,
    input   npc_op,
    input   [31:0]  alu,                //alu�����
    input   [31:0]  imm,                //������չ֮���32λ������
    output  wire [31:0]  inst,     //ȡ����32λָ��
    output  wire [31:0]  npc,             //npc�����
    output  wire [31:0]  pc4,
    output  wire [31:0]  pc_o
    );
    
//wire    [31:0]  pc_o;     //pc�����
    
pc  u_pc(
    .clk(clk),
    .rst_n(rst_n),
    .pc_sel(pc_sel),
    .npc(npc),
    .alu(alu),
    .pc(pc_o)
);

npc u_npc(
    .clk(clk),
    .rst_n(rst_n),
    .npc_op(npc_op),
    .pc(pc_o),
    .imm(imm),
    .npc(npc),
    .pc4(pc4)
);

imemory32   u_imemory32(
    .clk(clk),
    .rst_n(rst_n),
    .pc_i(pc_o),
    .instruction(inst)
);
endmodule
