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
    input   pc_sel,     //pcѡ���,����ѡ�������npc����alu
    input   [31:0]  npc,    //����npc�����
    input   [31:0]  alu,    //����alu�����
    output  reg [31:0] pc   //����ĵ�ַ
    );
    
reg start;
    
always @ (posedge clk) begin
    if(rst_n=='b0) begin
        pc='b0;
        start='b1;
    end
    else if(pc_sel=='b0 && start=='b1) start='b0;
    else if(pc_sel=='b0 && start=='b0) pc=npc;
    else pc=alu;
end
endmodule
