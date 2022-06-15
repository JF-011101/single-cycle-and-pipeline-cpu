//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 10:01:42
// Design Name: 
// Module Name: ex_mem_reg
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


module ex_mem_reg(
    input   clk,
    input   rst_n,
    input   [31:0]  ex_alu,
    input   ex_rf_we,
    input   [1:0]   ex_wd_sel,
    input   ex_dram_we,
    input   [31:0]  ex_pc4,
    input   [4:0]   ex_wR,
    input   [31:0]  ex_rD2,
    input   [31:0]  ex_pc,
    input   ex_have_inst,
    output  reg [31:0]  mem_alu,
    output  reg mem_rf_we,
    output  reg [1:0]   mem_wd_sel,
    output  reg mem_dram_we,
    output  reg [31:0]  mem_pc4,
    output  reg [4:0]   mem_wR,
    output  reg [31:0]  mem_rD2,
    output  reg [31:0]  mem_pc,
    output  reg mem_have_inst
    );
    
wire ram_clk;
assign ram_clk = !clk;
    
always @ (posedge ram_clk) begin
    if(rst_n=='b0) begin
        mem_rf_we<='b0;
        mem_dram_we<='b0;
        mem_pc4<='b0;
        mem_have_inst<='b0;
    end
    else begin
        mem_alu<=ex_alu;
        mem_rf_we<=ex_rf_we;
        mem_wd_sel<=ex_wd_sel;
        mem_dram_we<=ex_dram_we;
        mem_pc4<=ex_pc4;
        mem_wR<=ex_wR;
        mem_rD2<=ex_rD2;
        mem_have_inst<=ex_have_inst;
        mem_pc<=ex_pc;
    end
end

endmodule
