//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 17:12:19
// Design Name: 
// Module Name: branch_cmp
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
`include    "param.v"

module branch_cmp(
    input   [31:0]  C,
    output  reg [1:0]   branch
    );
    
always @ (*) begin
    if(C==32'b0) branch=`EQ;
    else if(C[31]==1'b1) branch=`LT;
    else branch=`GT;
end
    
endmodule
