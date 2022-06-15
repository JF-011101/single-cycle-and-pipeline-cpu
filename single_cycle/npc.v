//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/30 15:05:32
// Design Name: 
// Module Name: npc
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
`include "param.v"

module npc(
    input   clk,
    input   rst_n,
    input   npc_op,     //npc�����źţ�����npc�����pc+4����pc+imm
    input   [31:0]  pc,         //pc�����
    input   [31:0]  imm,        //������չ֮���������
    output  reg [31:0]  pc4,    //��ǰ��PC��4
    output  reg [31:0]  npc         //npc�����
    );
    
always @ (*) begin
    pc4=pc+4;
    if(rst_n=='b0) npc=4;
    else if(npc_op==`PC_PLUS_4) npc=pc4;
    else npc=pc+imm;
end
endmodule
