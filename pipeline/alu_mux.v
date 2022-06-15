//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 11:03:27
// Design Name: 
// Module Name: alu_mux
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

module alu_mux(
    input   [3:0]   alu_op,
    input   [31:0]  mux_i_0,
    input   [31:0]  mux_i_1,
    input   [31:0]  mux_i_2,
    input   [31:0]  mux_i_3,
    output  reg [31:0]  mux_o
    );
    
always @ (*) begin
    case(alu_op)
        `ADD:mux_o=mux_i_0;
        `SUB:mux_o=mux_i_0;
        `AND:mux_o=mux_i_1;
        `OR:mux_o=mux_i_1;
        `XOR:mux_o=mux_i_1;
        `SLL:mux_o=mux_i_2;
        `SRL:mux_o=mux_i_2;
        `SRA:mux_o=mux_i_2;
        `SEL_B:mux_o=mux_i_3;
        default:mux_o=32'b0;
    endcase
end

endmodule
