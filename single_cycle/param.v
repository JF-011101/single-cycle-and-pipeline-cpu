// file: param.v
`ifndef CPU_PARAM
`define CPU_PARAM

    `define RF_ALU_C 'b00
    `define RF_NPC_PC4 'b01
    `define RF_DRAM_RD 'b10
    
    
    `define I 'b001
    `define S 'b010
    `define B 'b011
    `define U 'b100
    `define J 'b101
    
    
    `define ADD 'b0000
    `define SUB 'b0001
    `define AND 'b0010
    `define OR  'b0011
    `define XOR 'b0100
    `define SLL 'b0101
    `define SRL 'b0110
    `define SRA 'b0111
    `define SEL_B   'b1000
    
    `define OPCODE_R    'b0110011
    `define OPCODE_I    'b0010011
    `define OPCODE_S    'b0100011
    `define OPCODE_B    'b1100011
    `define OPCODE_U    'b0110111
    `define OPCODE_J    'b1101111
    `define OPCODE_LW   'b0000011
    `define OPCODE_JALR 'b1100111
    
    `define PC_PLUS_4   'b0
    
    `define EQ  'b00
    `define LT  'b01
    `define GT  'b10
    
`endif
