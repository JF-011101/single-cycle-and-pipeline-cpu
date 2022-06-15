//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/14 14:30:58
// Design Name: 
// Module Name: forwarding_unit
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

module forwarding_unit(
    input   rst_n,
    input   [4:0]   rR1,
    input   [4:0]   rR2,
    input   rf_we_from_ex,
    input   [4:0]   wR_from_ex,
    input   rf_we_from_mem,
    input   [4:0]   wR_from_mem,
    input   [6:0]   opcode_from_ex,
    output  reg [1:0]   rD1_sel,
    output  reg [1:0]   rD2_sel,
    output  load_use_hazard
    );
    
reg load_use_hazard1;
reg load_use_hazard2;
assign  load_use_hazard=load_use_hazard1 | load_use_hazard2;
    
always @ (*) begin
    if(rst_n=='b0) begin
        rD1_sel=`NO_HAZARD;
        rD2_sel=`NO_HAZARD;
        load_use_hazard1='b0;
        load_use_hazard2='b0;
    end
    else begin
        if(rR1==wR_from_ex && rf_we_from_ex=='b1 && rR1!='b0 && opcode_from_ex==`OPCODE_LW) begin
            rD1_sel=`LOAD_USE_HAZARD;
            load_use_hazard1='b1;
        end
        else if(rR1==wR_from_ex && rf_we_from_ex=='b1 && rR1!='b0) begin
            rD1_sel=`HAZARD_1;
            load_use_hazard1='b0;
        end
        else if(rR1==wR_from_mem && rf_we_from_mem=='b1 && rR1!='b0) begin
            rD1_sel=`HAZARD_2;
            load_use_hazard1='b0;
        end
        else begin
            rD1_sel=`NO_HAZARD;
            load_use_hazard1='b0;
        end
        if(rR2==wR_from_ex && rf_we_from_ex=='b1 && rR2!='b0 && opcode_from_ex==`OPCODE_LW) begin
            rD2_sel=`LOAD_USE_HAZARD;
            load_use_hazard2='b1;
        end
        else if(rR2==wR_from_ex && rf_we_from_ex=='b1 && rR2!='b0) begin
            rD2_sel=`HAZARD_1;
            load_use_hazard2='b0;
        end
        else if(rR2==wR_from_mem && rf_we_from_mem=='b1 && rR2!='b0) begin
            rD2_sel=`HAZARD_2;
            load_use_hazard2='b0;
        end
        else begin
            rD2_sel=`NO_HAZARD;
            load_use_hazard2='b0;
        end
    end
end
    
endmodule
