//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 10:01:42
// Design Name: 
// Module Name: mem_wb_reg
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


module mem_wb_reg(
    input   clk,
    input   rst_n,
    input   [31:0]  mem_wD,
    input   mem_rf_we,
    input   [4:0]   mem_wR,
    input   [31:0]  mem_pc,
    input   mem_have_inst,
    output  reg [31:0]  wb_wD,
    output  reg wb_rf_we,
    output  reg [4:0]   wb_wR,
    output  reg [31:0]  wb_pc,
    output  reg wb_have_inst
    );
    
wire ram_clk;
assign ram_clk = !clk;
    
always @ (posedge ram_clk) begin
    if(rst_n=='b0) begin
        wb_rf_we<='b0;
        wb_have_inst<='b0;
    end
    else begin
        wb_rf_we<=mem_rf_we;
        wb_wD<=mem_wD;
        wb_wR<=mem_wR;
        wb_have_inst<=mem_have_inst;
        wb_pc<=mem_pc;
    end
end
    
endmodule
