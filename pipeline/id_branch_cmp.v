//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 11:13:20
// Design Name: 
// Module Name: id_branch_cmp
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


module id_branch_cmp(
    input   [31:0]   rD1,
    input   [31:0]   rD2,
    output  reg [1:0]   branch
    );
    
wire    [31:0]  rD2_opposite;
reg    [31:0]  C;

id_get_opposite u_id_get_opposite(
    .rD2(rD2),
    .rD2_opposite(rD2_opposite)
);
    
always @ (*) begin
    C=rD1+rD2_opposite;
    if(C==32'b0) branch=`EQ;
    else if(C[31]==1'b1) branch=`LT;
    else branch=`GT;
end
    
endmodule
