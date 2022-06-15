//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 08:45:51
// Design Name: 
// Module Name: rf
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
`include "param.v"

module rf(
    input   clk,
    input   rst_n,
    input   rf_we,
    input   [4:0]   rR1,
    input   [4:0]   rR2,
    input   [4:0]   wR,
    input   [31:0]  wD,
    output  reg [31:0]  rD1,
    output  reg [31:0]  rD2,
    output reg [31:0] rdatax19
    );
    
//寄存器堆数组
reg [31:0]  reg_file    [0:31];
     
always @ (*) begin    //这里如果使用trace测试的话是可以使用rR1 or rR2 or rst_n的
    //读寄存器堆的组合逻辑
    if(rst_n=='b0) begin
        rD1=32'b0;
        rD2=32'b0;
    end
    else begin
        rD1=reg_file[rR1];
        rD2=reg_file[rR2];
    end
end 

always @ (posedge clk) begin
    //写寄存器堆的时序逻辑
    if(rst_n=='b0) begin
        reg_file[0]<=32'b0;
        reg_file[1]<=32'b0;
        reg_file[2]<=32'b0;
        reg_file[3]<=32'b0;
        reg_file[4]<=32'b0;
        reg_file[5]<=32'b0;
        reg_file[6]<=32'b0;
        reg_file[7]<=32'b0;
        reg_file[8]<=32'b0;
        reg_file[9]<=32'b0;
        reg_file[10]<=32'b0;
        reg_file[11]<=32'b0;
        reg_file[12]<=32'b0;
        reg_file[13]<=32'b0;
        reg_file[14]<=32'b0;
        reg_file[15]<=32'b0;
        reg_file[16]<=32'b0;
        reg_file[17]<=32'b0;
        reg_file[18]<=32'b0;
        reg_file[19]<=32'b0;
        reg_file[20]<=32'b0;
        reg_file[21]<=32'b0;
        reg_file[22]<=32'b0;
        reg_file[23]<=32'b0;
        reg_file[24]<=32'b0;
        reg_file[25]<=32'b0;
        reg_file[26]<=32'b0;
        reg_file[27]<=32'b0;
        reg_file[28]<=32'b0;
        reg_file[29]<=32'b0;
        reg_file[30]<=32'b0;
        reg_file[31]<=32'b0;
    end
    else if(rf_we==1'b1 && wR!=4'b0000) begin
        reg_file[wR]<=wD;
    end
    else ;
end

always@(*) begin
    rdatax19 = reg_file[19];
end

endmodule
