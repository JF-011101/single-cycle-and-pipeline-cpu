//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/06/30 15:18:15
// Design Name: 
// Module Name: imemory32
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


module imemory32(
    input   clk,
    input   rst_n,
    input   [31:0]  pc_i,               //pc的输出
    output  reg [31:0]  instruction    //取出的32位指令
    );

wire [31:0] instruction_wire;

always @ (*) begin
    if(rst_n=='b0) instruction=0;
    else instruction=instruction_wire;
end

    // 64KB IROM
    inst_mem imem (
        .a      (pc_i[15:2]),   // input wire [13:0] a
        .spo    (instruction_wire)   // output wire [31:0] spo
    );

endmodule
