//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 09:56:12
// Design Name: 
// Module Name: alu
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


module alu(
    input   [31:0]  A,
    input   [31:0]  B,
    input   [3:0]   alu_op,
    output  zero,
    output  [31:0]  C
    );
    
wire    [31:0]  B_opposite;
wire    [31:0]  mux_i_0;
wire    [31:0]  mux_i_1;
wire    [31:0]  mux_i_2;


alu_get_opposite u_alu_opposite(
    .alu_op(alu_op),
    .B(B),
    .B_opposite(B_opposite)
);

alu_adder u_alu_adder(
    .A(A),
    .B(B_opposite),
    .C(mux_i_0),
    .zero(zero)
);

alu_logic_arithmetic u_alu_logic_arithmetic(
    .alu_op(alu_op),
    .A(A),
    .B(B),
    .C(mux_i_1)
);

alu_bucket_shifter u_alu_bucket_shifter(
    .alu_op(alu_op),
    .A(A),
    .B(B),
    .C(mux_i_2)
);

alu_mux u_alu_mux(
    .alu_op(alu_op),
    .mux_i_0(mux_i_0),
    .mux_i_1(mux_i_1),
    .mux_i_2(mux_i_2),
    .mux_i_3(B),
    .mux_o(C)
);
    
endmodule
