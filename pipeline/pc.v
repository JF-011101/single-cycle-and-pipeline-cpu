//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/30 14:35:16
// Design Name: 
// Module Name: pc
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


module pc(
    input   clk,        //ʱ���ź�
    input   rst_n,        //��λ�ź�
    input   stop,
    input   pc_sel,     //pcѡ���,����ѡ�������npc����alu
    input   [31:0]  npc,    //����npc�����
    input   [31:0]  alu,    //����alu�����
    input   [6:0]   opcode,
    output  reg [31:0] pc   //����ĵ�ַ
    );
    
reg start;
    
always @ (posedge clk) begin
    if(rst_n=='b0) begin
        pc<='b0;
        start<='b0;
    end
    else if(stop=='b1) pc<=pc;
    else if(pc_sel=='b0 && start=='b0) start<='b1;
    else if(pc_sel=='b0 && start=='b1) pc<=npc;
    else if(opcode==`OPCODE_JALR) pc<=alu-4;
    else pc<=alu;
end
endmodule
