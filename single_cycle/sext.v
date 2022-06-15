//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 08:45:51
// Design Name: 
// Module Name: sext
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

module sext(
    input   [2:0]   sext_op,                //选择哪种类型的指令的符号扩展
    input   [31:0]  inst,           //指令
    output  reg [31:0]  ext         //符号扩展之后的32位数
    );
    
always @ (*) begin
    if(inst[31]=='b0)
        case(sext_op)
            `I:begin
                if(inst[14:12]=='b001 || inst[14:12]=='b101) ext={27'b0,inst[24:20]};
                else ext={20'b0,inst[31:20]};
            end
            `S:ext={20'b0,inst[31:25],inst[11:7]};
            `B:ext={19'b0,inst[31],inst[7],inst[30:25],inst[11:8],1'b0};
            `U:ext={inst[31:12],12'b0};
            `J:ext={11'b0,inst[31],inst[19:12],inst[20],inst[30:21],1'b0};
            default:ext=32'b0;
        endcase
    else
        case(sext_op)
            `I:begin
                if(inst[14:12]=='b001 || inst[14:12]=='b101) ext={27'b0,inst[24:20]};
                else ext={20'b11111111111111111111,inst[31:20]};
            end
            `S:ext={20'b11111111111111111111,inst[31:25],inst[11:7]};
            `B:ext={19'b1111111111111111111,inst[31],inst[7],inst[30:25],inst[11:8],1'b0};
            `U:ext={inst[31:12],12'b0};
            `J:ext={11'b11111111111,inst[31],inst[19:12],inst[20],inst[30:21],1'b0};
            default:ext=32'b11111111111111111111111111111111;
        endcase
end
    
endmodule