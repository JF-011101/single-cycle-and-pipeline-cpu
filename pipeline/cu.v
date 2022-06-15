//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/06 14:08:59
// Design Name: 
// Module Name: cu
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

module cu(
    input   rst_n,
    input   [31:0]  inst,
    input   [1:0]   branch,
    output  reg pc_sel,
    output  reg npc_op,
    output  reg rf_we,
    output  reg [1:0]   wd_sel,
    output  reg [2:0]   sext_op,
    output  reg [3:0]   alu_op,
    output  reg alub_sel,
    output  reg dram_we
    );
    
reg need_branch;
reg npc_op1;
reg npc_op2;

always @ (npc_op1 or npc_op2 or rst_n) begin
    if(rst_n=='b0) npc_op='b0;
    else if(inst[6:0]==`OPCODE_B) npc_op=npc_op2;
    else npc_op=npc_op1;
end

always @ (*) begin
    if(rst_n=='b0) npc_op2='b0;
    else if(inst[6:0]==`OPCODE_B) begin
        case(inst[14:12])
            'b000:begin
                if(branch==`EQ) npc_op2='b1;
                else npc_op2='b0;
            end
            'b001:begin
                if(branch!=`EQ) npc_op2='b1;
                else npc_op2='b0;
            end
            'b100:begin
                if(branch==`LT) npc_op2='b1;
                else npc_op2='b0;
            end
            'b101:begin
                if(branch==`GT || branch==`EQ) npc_op2='b1;
                else npc_op2='b0;
            end
            default:npc_op2='b0;
        endcase
    end
    else npc_op2='b0;
end

always @ (*) begin
    if(rst_n=='b0) begin
        pc_sel='b0;
        npc_op1=`PC_PLUS_4;
        need_branch=1'b0;
    end
    else
    case(inst[6:0])
        `OPCODE_R:begin
            pc_sel='b0;
            npc_op1=`PC_PLUS_4;
            rf_we='b1;
            wd_sel=`RF_ALU_C;
            alub_sel='b0;
            need_branch='b0;
            dram_we='b0;
            case(inst[14:12])
                'b000:begin
                    if(inst[30]=='b0) alu_op=`ADD;
                    else alu_op=`SUB;
                end
                'b111:begin
                    alu_op=`AND;
                end
                'b110:begin
                    alu_op=`OR;
                end
                'b100:begin
                    alu_op=`XOR;
                end
                'b001:begin
                    alu_op=`SLL;
                end
                'b101:begin
                    if(inst[30]=='b0) alu_op=`SRL;
                    else alu_op=`SRA;
                end
                default:;
            endcase
        end
        `OPCODE_I:begin
            pc_sel='b0;
            wd_sel=`RF_ALU_C;
            npc_op1=`PC_PLUS_4;
            rf_we='b1;
            alub_sel='b1;
            need_branch='b0;
            dram_we='b0;
            sext_op=`I;
            case(inst[14:12])
                'b000:begin
                    alu_op=`ADD;
                end
                'b111:begin
                    alu_op=`AND;
                end
                'b110:begin
                    alu_op=`OR;
                end
                'b100:begin
                    alu_op=`XOR;
                end
                'b001:begin
                    alu_op=`SLL;
                end
                'b101:begin
                    if(inst[30]=='b0) alu_op=`SRL;
                    else alu_op=`SRA;
                end
                'b010:begin
                    alu_op=`ADD;
                end
                default:;
            endcase
        end
        `OPCODE_LW:begin
            pc_sel='b0;
            wd_sel=`RF_DRAM_RD;
            npc_op1=`PC_PLUS_4;
            rf_we='b1;
            alub_sel='b1;
            need_branch='b0;
            dram_we='b0;
            sext_op=`I;
            alu_op=`ADD;
        end
        `OPCODE_JALR:begin
            pc_sel='b1;
            wd_sel=`RF_NPC_PC4;
            npc_op1=`PC_PLUS_4;
            rf_we='b1;
            alub_sel='b1;
            need_branch='b0;
            dram_we='b0;
            sext_op=`I;
            alu_op=`ADD;
        end
        `OPCODE_S:begin
            pc_sel='b0;
            npc_op1=`PC_PLUS_4;
            rf_we='b0;
            alub_sel='b1;
            need_branch='b0;
            dram_we='b1;
            sext_op=`S;
            alu_op=`ADD;
        end
        `OPCODE_B:begin
            pc_sel='b0;
            npc_op1='b1;
            rf_we='b0;
            alub_sel='b0;
            need_branch='b1;
            dram_we='b0;
            sext_op=`B;
            alu_op=`SUB;
        end
        `OPCODE_U:begin
            pc_sel='b0;
            npc_op1=`PC_PLUS_4;
            rf_we='b1;
            wd_sel=`RF_ALU_C;
            alub_sel='b1;
            need_branch='b0;
            dram_we='b0;
            sext_op=`U;
            alu_op=`SEL_B;
        end
        `OPCODE_J:begin
            pc_sel='b0;
            npc_op1='b1;
            rf_we='b1;
            wd_sel=`RF_NPC_PC4;
            need_branch='b0;
            dram_we='b0;
            sext_op=`J;
        end
        default:begin
            rf_we='b0;
            dram_we='b0;
            pc_sel='b0;
            npc_op1=`PC_PLUS_4;
        end
    endcase
end
    
endmodule
