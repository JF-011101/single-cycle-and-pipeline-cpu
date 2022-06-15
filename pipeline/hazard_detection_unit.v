//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/14 14:59:22
// Design Name: 
// Module Name: hazard_detection_unit
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


module hazard_detection_unit(
    input   rst_n,
    input   pc_sel,
    input   npc_op,
    output  reg flush
    );
    
always @ (*) begin
    if(rst_n=='b0) begin
        flush='b0;
    end
    else if(pc_sel=='b1 || npc_op=='b1) begin
        flush='b1;
    end
    else begin
        flush='b0;
    end
end
    
endmodule
