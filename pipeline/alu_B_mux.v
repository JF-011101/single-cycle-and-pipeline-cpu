//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 17:06:41
// Design Name: 
// Module Name: alu_B_mux
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


module alu_B_mux(
    input   alub_sel,
    input   [31:0]  rD2,
    input   [31:0]  ext,
    output  reg [31:0]  B
    );
    
always @ (*) begin
    case(alub_sel)
        'b0:B=rD2;
        'b1:B=ext;
        default:;
    endcase
end

endmodule

