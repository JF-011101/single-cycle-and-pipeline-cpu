//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/14 15:08:00
// Design Name: 
// Module Name: rD1_mux
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

module rD1_mux(
    input   rst_n,
    input   [1:0]   rD1_sel,
    input   [31:0]  rD1,
    input   [31:0]  wD_from_ex,
    input   [31:0]  wD_from_mem,
    output  reg [31:0]  real_rD1
    );
    
always @ (*) begin
    if(rst_n=='b0) begin
        real_rD1=rD1;
    end
    else begin
        case(rD1_sel)
            `NO_HAZARD:real_rD1=rD1;
            `HAZARD_1:real_rD1=wD_from_ex;
            `HAZARD_2:real_rD1=wD_from_mem;
            `LOAD_USE_HAZARD:real_rD1=wD_from_mem;
            default:real_rD1=rD1;
        endcase
    end
end
    
endmodule