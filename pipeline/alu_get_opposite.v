//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 10:16:17
// Design Name: 
// Module Name: alu_get_opposite
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

module alu_get_opposite(
    input   [3:0]   alu_op,
    input   [31:0]  B,
    output  reg [31:0]  B_opposite
    );
    
wire  [30:0]  tmp;
wire    tmp31;
assign tmp=~B[30:0]+1;
assign  tmp31=(B==0 || B==32'h80000000)?B[31]:~B[31];
    
always @ (*) begin
    if(alu_op==`SUB) B_opposite={tmp31,tmp};
    else B_opposite=B;
end
    
endmodule
