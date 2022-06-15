//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 10:19:00
// Design Name: 
// Module Name: alu_logic_arithmetic
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

module alu_logic_arithmetic(
    input   [3:0]   alu_op,
    input   [31:0]  A,
    input   [31:0]  B,
    output  reg [31:0]  C
    );
    
always @ (*) begin
    case(alu_op)
        `AND:C=A & B;
        `OR:C=A | B;
        `XOR:C=A ^ B;
        default:C=32'b0;
    endcase
end
    
endmodule
