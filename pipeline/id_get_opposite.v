//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 12:06:03
// Design Name: 
// Module Name: id_get_opposite
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


module id_get_opposite(
    input   [31:0]  rD2,
    output  reg [31:0]  rD2_opposite
    );
    
wire  [30:0]  tmp;
wire    tmp31;
assign tmp=~rD2[30:0]+1;
assign  tmp31=(rD2==0 || rD2==32'h80000000)?rD2[31]:~rD2[31];
    
always @ (*) begin
    rD2_opposite={tmp31,tmp};
end
    
endmodule
