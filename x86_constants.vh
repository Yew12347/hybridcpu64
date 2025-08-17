// FAST x86 Constants  
// Optimized constants for x86-64 implementation

// x86 Register Indices
`define X86_REG_RAX 4'd0
`define X86_REG_RCX 4'd1  
`define X86_REG_RDX 4'd2
`define X86_REG_RBX 4'd3
`define X86_REG_RSP 4'd4
`define X86_REG_RBP 4'd5
`define X86_REG_RSI 4'd6
`define X86_REG_RDI 4'd7
`define X86_REG_R8  4'd8
`define X86_REG_R9  4'd9
`define X86_REG_R10 4'd10
`define X86_REG_R11 4'd11
`define X86_REG_R12 4'd12
`define X86_REG_R13 4'd13
`define X86_REG_R14 4'd14
`define X86_REG_R15 4'd15

// x86 RFLAGS Bit Positions
`define X86_FLAG_CF  0   // Carry Flag
`define X86_FLAG_PF  2   // Parity Flag  
`define X86_FLAG_AF  4   // Auxiliary Carry Flag
`define X86_FLAG_ZF  6   // Zero Flag
`define X86_FLAG_SF  7   // Sign Flag
`define X86_FLAG_TF  8   // Trap Flag
`define X86_FLAG_IF  9   // Interrupt Enable Flag
`define X86_FLAG_DF  10  // Direction Flag
`define X86_FLAG_OF  11  // Overflow Flag

// x86 Opcodes (simplified for FAST)
`define X86_OP_MOV_IMM   8'hC7    // MOV r/m, imm32
`define X86_OP_ADD_REG   8'h01    // ADD r/m, r
`define X86_OP_SUB_REG   8'h29    // SUB r/m, r  
`define X86_OP_XOR_REG   8'h31    // XOR r/m, r
`define X86_OP_CMP_REG   8'h39    // CMP r/m, r
`define X86_OP_NOP       8'h90    // NOP
`define X86_OP_PUSH_REG  8'h50    // PUSH r (+ reg in low 3 bits)
`define X86_OP_POP_REG   8'h58    // POP r (+ reg in low 3 bits)

// x86 Prefixes
`define X86_PREFIX_REX_W 8'h48    // REX.W (64-bit operand)
`define X86_PREFIX_LOCK  8'hF0    // LOCK prefix
`define X86_PREFIX_REP   8'hF3    // REP prefix

// x86 ModR/M byte fields
`define X86_MOD_REG      2'b11    // Register addressing
`define X86_MOD_MEM      2'b00    // Memory addressing (no displacement)
`define X86_MOD_MEM_DISP8  2'b01  // Memory + 8-bit displacement
`define X86_MOD_MEM_DISP32 2'b10  // Memory + 32-bit displacement

// x86 ALU Operations (internal)
`define X86_ALU_ADD  4'b0000
`define X86_ALU_ADC  4'b0001
`define X86_ALU_SUB  4'b0010
`define X86_ALU_SBB  4'b0011
`define X86_ALU_AND  4'b0100
`define X86_ALU_OR   4'b0101
`define X86_ALU_XOR  4'b0110
`define X86_ALU_CMP  4'b0111
`define X86_ALU_MOV  4'b1000
`define X86_ALU_TEST 4'b1001
`define X86_ALU_INC  4'b1010
`define X86_ALU_DEC  4'b1011

// x86 Addressing Modes (simplified)
`define X86_ADDR_REG     2'b00    // Register direct
`define X86_ADDR_MEM     2'b01    // Memory direct  
`define X86_ADDR_DISP    2'b10    // Memory + displacement
`define X86_ADDR_IMM     2'b11    // Immediate

// FAST x86 Magic Values
`define X86_FASTBOY_SIG  64'hFASTB01234567890  // FAST signature in RAX
