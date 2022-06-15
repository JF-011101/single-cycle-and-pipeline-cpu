//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 11:14:38
// Design Name: 
// Module Name: ex_module
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


module ex_module(
    input   alub_sel,
    input   [31:0]  A,
    input   [31:0]  rD2,
    input   [31:0]  ext,
    input   [3:0]   alu_op,
    output  zero,
    output  [1:0]   branch,
    output  [31:0]  C
    );
    
wire    [31:0]  B;

alu_B_mux u_alu_B_mux(
    .alub_sel(alub_sel),
    .rD2(rD2),
    .ext(ext),
    .B(B)
);
    
alu u_alu(
    .A(A),
    .B(B),
    .alu_op(alu_op),
    .zero(zero),
    .C(C)
);

branch_cmp u_branch_cmp(
    .C(C),
    .branch(branch)
);
    
endmodule
