//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/13 10:01:42
// Design Name: 
// Module Name: if_id_reg
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


module if_id_reg(
    input   clk,
    input   rst_n,
    //input   stop,
    input   flush,
    input   [31:0]  if_inst,
    input   [31:0]  if_pc4,
    input   [31:0]  if_pc,
    output  reg [31:0]  id_inst,
    output  reg [31:0]  id_pc4,
    output  reg [31:0]  id_pc,
    output  reg id_have_inst
    );
    
wire ram_clk;
assign ram_clk = !clk;

always @ (posedge ram_clk) begin
    if(rst_n=='b0) begin
        id_inst<='b0;
        id_pc4<='b0;
        id_have_inst<='b0;
    end
    else if(flush=='b1) begin
        id_inst<=32'b00000000000000000000000000110011;
        id_pc4<='b0;
        id_have_inst<='b0;
    end
    //else if(stop=='b1) begin
        //id_inst<=id_inst;
        //id_pc4<=id_pc4;
        //id_have_inst<='b0;
    //end
    else begin
        id_inst<=if_inst;
        id_pc4<=if_pc4;
        id_pc<=if_pc;
        id_have_inst<='b1;
    end
end

endmodule