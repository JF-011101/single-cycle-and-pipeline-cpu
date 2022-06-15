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
    input   clk,        //时钟信号
    input   rst_n,        //复位信号
    input   pc_sel,     //pc选择端,用于选择输出是npc还是alu
    input   [31:0]  npc,    //来自npc的输出
    input   [31:0]  alu,    //来自alu的输出
    output  reg [31:0] pc   //输出的地址
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
