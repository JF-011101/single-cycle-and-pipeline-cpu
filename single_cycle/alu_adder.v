//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 10:16:41
// Design Name: 
// Module Name: alu_adder
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


module alu_adder(
    input   [31:0]  A,
    input   [31:0]  B,
    output  reg [31:0]  C,
    output  reg zero
    );
    
always @ (*) begin
    C=A+B;
    if(C==32'b0) zero=1'b1;
    else zero=1'b0;
end
    
endmodule
