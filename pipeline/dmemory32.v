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
    input   [31:0]  adr,     // 来源于执行单元计算出的访存地址
    output  [31:0]  rd,         // 从存储器中获得的数据
    input           dram_we,    // 来自控制单元的写使能信号
    input   [31:0]  rD2   // rD2 (S型指令的rs2寄存器的值)
    );
    
//wire ram_clk;
//assign ram_clk = !clk; // 因为芯片的固有延迟，DRAM的地址线来不及在时钟上升沿准备好,
// 使得时钟上升沿数据读出有误。所以采用反相时钟，使得读出数据比地址准备好要晚大约半个时钟,
// 从而能够获得正确的数据。


// 64KB DRAM
data_mem dmem (
    .clk    (clk),            // input wire clka
    .a      (adr[15:2]),     // input wire [13:0] addra
    .spo   (rd),        // output wire [31:0] douta
    .we     (dram_we),          // input wire [0:0] wea
    .d      (rD2)         // input wire [31:0] dina
);
    
endmodule
