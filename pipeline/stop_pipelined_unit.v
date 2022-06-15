//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/16 09:06:52
// Design Name: 
// Module Name: stop_pipelined_unit
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


module stop_pipelined_unit(
    input   rst_n,
    input   load_use_hazard,
    output  reg stop
    );
    
always @ (*) begin
    if(rst_n=='b0) begin
        stop='b0;
    end
    else if(load_use_hazard=='b1) begin
        stop='b1;
    end
    else begin
        stop='b0;
    end
end
    
endmodule
