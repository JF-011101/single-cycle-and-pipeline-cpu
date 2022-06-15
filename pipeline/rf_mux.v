//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/08 12:03:33
// Design Name: 
// Module Name: rf_mux
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


module rf_mux(
    input   [1:0]   wd_sel,
    input   [31:0]  alu_c,
    input   [31:0]  npc_pc4,
    input   [31:0]  dram_rd,
    output  reg [31:0]  wD
    );
    
always @ (*) begin
    case(wd_sel)
        `RF_ALU_C:begin 
            wD=alu_c;
        end
        `RF_NPC_PC4:begin
            wD=npc_pc4;
        end
        `RF_DRAM_RD:begin
            wD=dram_rd;
        end
        default:begin
            wD=0;
        end
    endcase
end
    
endmodule
