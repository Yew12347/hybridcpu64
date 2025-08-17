// FAST RISC-V Constants
// Optimized constants for RV64GC implementation

// RISC-V Opcodes (7-bit)
`define RV_OP_LOAD     7'b0000011
`define RV_OP_STORE    7'b0100011
`define RV_OP_MADD     7'b1000011
`define RV_OP_BRANCH   7'b1100011
`define RV_OP_LOAD_FP  7'b0000111
`define RV_OP_STORE_FP 7'b0100111
`define RV_OP_MSUB     7'b1000111
`define RV_OP_JALR     7'b1100111
`define RV_OP_CUSTOM_0 7'b0001011
`define RV_OP_CUSTOM_1 7'b0101011
`define RV_OP_NMSUB    7'b1001011
`define RV_OP_MISC_MEM 7'b0001111
`define RV_OP_AMO      7'b0101111
`define RV_OP_NMADD    7'b1001111
`define RV_OP_JAL      7'b1101111
`define RV_OP_IMM      7'b0010011  // ADDI, XORI, etc.
`define RV_OP_OP       7'b0110011  // ADD, XOR, MUL, etc.
`define RV_OP_AUIPC    7'b0010111
`define RV_OP_IMM_32   7'b0011011
`define RV_OP_OP_32    7'b0111011
`define RV_OP_LUI      7'b0110111
`define RV_OP_OP_FP    7'b1010011
`define RV_OP_SYSTEM   7'b1110011

// RISC-V Funct3 for I-type instructions
`define RV_FUNCT3_ADDI  3'b000
`define RV_FUNCT3_SLLI  3'b001  
`define RV_FUNCT3_SLTI  3'b010
`define RV_FUNCT3_SLTIU 3'b011
`define RV_FUNCT3_XORI  3'b100
`define RV_FUNCT3_SRLI  3'b101  // Also SRAI
`define RV_FUNCT3_ORI   3'b110
`define RV_FUNCT3_ANDI  3'b111

// RISC-V Funct3 for R-type instructions  
`define RV_FUNCT3_ADD   3'b000  // Also SUB, MUL
`define RV_FUNCT3_SLL   3'b001  // Also MULH
`define RV_FUNCT3_SLT   3'b010  // Also MULHSU
`define RV_FUNCT3_SLTU  3'b011  // Also MULHU
`define RV_FUNCT3_XOR   3'b100  // Also DIV
`define RV_FUNCT3_SRL   3'b101  // Also SRA, DIVU
`define RV_FUNCT3_OR    3'b110  // Also REM
`define RV_FUNCT3_AND   3'b111  // Also REMU

// RISC-V Funct7
`define RV_FUNCT7_NORMAL 7'b0000000
`define RV_FUNCT7_ALT    7'b0100000  // SUB, SRA
`define RV_FUNCT7_MULDIV 7'b0000001  // RV64M operations

// ALU Operations (internal)
`define ALU_ADD  4'b0000
`define ALU_SUB  4'b0001
`define ALU_SLL  4'b0010
`define ALU_SLT  4'b0011
`define ALU_SLTU 4'b0100
`define ALU_XOR  4'b0101
`define ALU_SRL  4'b0110
`define ALU_SRA  4'b0111
`define ALU_OR   4'b1000
`define ALU_AND  4'b1001
`define ALU_MUL  4'b1010
`define ALU_DIV  4'b1011
`define ALU_REM  4'b1100

// FAST Special Instructions
`define FASTBOY_MODE_SWITCH 32'hFASTBOY1  // Magic mode switch instruction
`define FASTBOY_RESET       32'hFASTBOY0  // Reset to RISC-V mode
