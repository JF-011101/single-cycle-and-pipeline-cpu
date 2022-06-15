//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 10:18:20
// Design Name: 
// Module Name: alu_bucket_shifter
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

module alu_bucket_shifter(
    input   [3:0]   alu_op,
    input   [31:0]  A,
    input   [31:0]  B,
    output  reg [31:0]  C
    );
    
reg [63:0]  temp;
    
always @ (*) begin
    case(alu_op)
        `SLL:C=A<<B[4:0];
        `SRL:C=A>>B[4:0];
        `SRA:begin
            if(A[31]==1'b1) begin
                temp[63:32]=32'b11111111111111111111111111111111;
                temp[31:0]=A;
                temp=temp>>B[4:0];
                C=temp[31:0];
            end
            else begin
                C=A>>B[4:0];
            end
        end
        default:C=32'b0;
    endcase
end
    
endmodule
