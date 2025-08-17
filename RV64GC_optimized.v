// FAST OPTIMIZED HYBRID CPU - RV64GC + x86-64
// Modularized and optimized for better performance and readability

`include "rv_constants.vh"
`include "x86_constants.vh"

module RV64GC_optimized (
    input clk,
    input rst,
    
    // RISC-V outputs
    output reg [63:0] pc,
    output reg [63:0] reg_out,
    output reg [31:0] debug_instr,
    output reg [6:0] debug_opcode,
    output reg [4:0] debug_rd,
    output reg [4:0] debug_rs1,
    output reg [63:0] debug_imm,
    output reg [63:0] debug_alu_result,
    
    // x86 outputs (optimized)
    output reg [63:0] x86_rip,
    output reg [63:0] x86_rflags,
    output wire [63:0] x86_rax,
    output wire [63:0] x86_rcx,
    output wire [63:0] x86_rdx,
    output wire [63:0] x86_rbx,
    output reg [1:0] x86_mode,
    output reg x86_long_mode,
    output reg x86_cf, x86_zf, x86_sf, x86_of
);

    // === REGISTER FILES (Optimized) ===
    reg [63:0] regs [0:31];           // RISC-V integer registers
    reg [63:0] fregs [0:31];          // RISC-V floating-point registers  
    reg [63:0] x86_regs [0:15];       // x86 general-purpose registers
    
    // Optimized x86 register access
    assign x86_rax = x86_regs[0];
    assign x86_rcx = x86_regs[1]; 
    assign x86_rdx = x86_regs[2];
    assign x86_rbx = x86_regs[3];
    
    // === MEMORY (Optimized sizes) ===
    reg [31:0] instr_mem [0:127];     // Reduced from 256 to 128
    reg [7:0] data_mem [0:511];       // Reduced from 1024 to 512
    
    // === CONTROL SIGNALS (Consolidated) ===
    reg [2:0] funct3;
    reg [6:0] funct7;
    reg [63:0] rs1_data, rs2_data, alu_result;
    reg [3:0] alu_op;
    reg mem_read, mem_write, reg_write;
    
    // === EXECUTION STATE ===
    reg x86_mode_active;
    reg [3:0] execution_stage;
    
    // === INITIALIZATION (Optimized) ===
    initial begin
        // Fast initialization using generate blocks would be better
        // but keeping simple for compatibility
        
        // RISC-V state
        pc = 0;
        reg_out = 0;
        debug_instr = 0;
        
        // x86 state  
        x86_rip = 64'h400000;
        x86_rflags = 64'h202;  // IF=1, Reserved=1
        x86_mode = 2'b10;      // Long mode
        x86_long_mode = 1;
        x86_mode_active = 0;
        
        // Initialize key registers with interesting FAST values
        x86_regs[0] = 64'h1234567890ABCDEF; // RAX - FAST signature!
        x86_regs[1] = 64'hBEEFCAFE12345678; // RCX 
        x86_regs[2] = 64'hDEADBEEF87654321; // RDX
        x86_regs[3] = 64'hCAFEBABE13579BDF; // RBX
        
        // Optimized test program (reduced size)
        load_fast_boy_program();
    end
    
    // === OPTIMIZED PROGRAM LOADER ===
    task load_fast_boy_program;
        begin
            // Essential RISC-V instructions only
            instr_mem[0]  = 32'h00100093; // ADDI x1,x0,1
            instr_mem[1]  = 32'h00200113; // ADDI x2,x0,2  
            instr_mem[2]  = 32'h002081b3; // ADD x3,x1,x2
            instr_mem[3]  = 32'h0020c3b3; // XOR x7,x1,x2
            instr_mem[4]  = 32'h002083b3; // MUL x7,x1,x2 (RV64M)
            
            // FAST MODE SWITCH!
            instr_mem[5]  = 32'hDEADBEEF; // MAGIC FAST SWITCH!
            
            // Essential x86 instructions
            instr_mem[6]  = 32'h48C7C001; // MOV RAX, 1 (x86-64)
            instr_mem[7]  = 32'h48C7C102; // MOV RCX, 2
            instr_mem[8]  = 32'h4801C8;   // ADD RAX, RCX
            instr_mem[9]  = 32'h90;       // NOP
            
            // Fill rest with NOPs
            for (integer i = 10; i < 128; i = i + 1) begin
                instr_mem[i] = 32'h00000013; // RISC-V NOP
            end
        end
    endtask
    
    // === MAIN EXECUTION (Optimized Pipeline) ===
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            fast_boy_reset();
        end else begin
            if (x86_mode_active) begin
                execute_x86_fast();
            end else begin
                execute_riscv_fast();
            end
        end
    end
    
    // === FAST RESET ===
    task fast_boy_reset;
        begin
            pc <= 0;
            reg_out <= 0;
            x86_mode_active <= 0;
            execution_stage <= 0;
            // Registers stay initialized from initial block
        end
    endtask
    
    // === OPTIMIZED RISC-V EXECUTION ===
    task execute_riscv_fast;
        reg [31:0] instr;
        begin
            // Fetch (optimized)
            instr = instr_mem[pc[8:2]]; // Direct indexing, no masking overhead
            
            // Decode + Execute (combined for speed)
            case (instr)
                32'hDEADBEEF: begin // FAST MODE SWITCH!
                    x86_mode_active <= 1;
                    x86_rip <= pc + 4;
                    pc <= pc + 4; // Continue execution in x86 mode
                end
                
                default: begin
                    case (instr[6:0])
                        7'b0010011: begin // I-type (ADDI, etc.)
                            fast_alu_op(instr);
                            pc <= pc + 4;
                        end
                        
                        7'b0110011: begin // R-type (ADD, XOR, MUL, etc.)
                            fast_alu_op(instr);
                            pc <= pc + 4;
                        end
                        
                        default: begin
                            pc <= pc + 4; // Skip unknown instructions
                        end
                    endcase
                end
            endcase
            
            // Update debug outputs
            debug_instr <= instr;
            debug_opcode <= instr[6:0];
            debug_rd <= instr[11:7];
            debug_rs1 <= instr[19:15];
        end
    endtask
    
    // === OPTIMIZED x86 EXECUTION ===
    task execute_x86_fast;
        reg [31:0] instr;
        begin
            // Simplified x86 execution for FAST mode
            instr = instr_mem[x86_rip[8:2]];
            
            // Basic x86 decode (simplified for performance)
            case (instr[7:0])
                8'h48: begin // REX.W prefix - 64-bit operation
                    fast_x86_alu(instr);
                    x86_rip <= x86_rip + 4; // Simplified length
                end
                
                8'h90: begin // NOP  
                    x86_rip <= x86_rip + 1;
                end
                
                default: begin
                    x86_rip <= x86_rip + 1; // Skip unknown
                end
            endcase
            
            // Update x86 flags (simplified)
            update_x86_flags();
        end
    endtask
    
    // === FAST ALU OPERATIONS ===
    task fast_alu_op;
        input [31:0] instr;
        reg [4:0] rd, rs1, rs2;
        reg [63:0] imm;
        begin
            rd = instr[11:7];
            rs1 = instr[19:15];
            rs2 = instr[24:20];
            imm = {{52{instr[31]}}, instr[31:20]};
            
            case ({instr[31:25], instr[14:12]})
                10'b0000000000: regs[rd] <= regs[rs1] + imm; // ADDI
                10'b0000000100: regs[rd] <= regs[rs1] ^ imm; // XORI  
                10'b0000000000: regs[rd] <= regs[rs1] + regs[rs2]; // ADD (R-type)
                10'b0000001000: regs[rd] <= regs[rs1] * regs[rs2]; // MUL
                default: regs[rd] <= regs[rs1]; // Default case
            endcase
            
            if (rd != 0) reg_out <= regs[rd]; // x0 is always 0
        end
    endtask
    
    // === FAST x86 ALU ===  
    task fast_x86_alu;
        input [31:0] instr;
        begin
            // Simplified x86 ALU for FAST operations
            case (instr[15:8])
                8'hC7: begin // MOV immediate
                    case (instr[18:16]) // ModR/M reg field
                        3'b000: x86_regs[0] <= {32'h0, instr[31:16]}; // RAX
                        3'b001: x86_regs[1] <= {32'h0, instr[31:16]}; // RCX
                        default: x86_regs[0] <= {32'h0, instr[31:16]};
                    endcase
                end
                
                8'h01: begin // ADD reg, reg
                    x86_regs[0] <= x86_regs[0] + x86_regs[1]; // RAX += RCX
                end
            endcase
        end
    endtask
    
    // === FAST x86 FLAGS UPDATE ===
    task update_x86_flags;
        begin
            // Simplified flag update for FAST mode
            x86_zf <= (x86_regs[0] == 0);
            x86_sf <= x86_regs[0][63];
            x86_cf <= 0; // Simplified
            x86_of <= 0; // Simplified
            
            // Pack into RFLAGS
            x86_rflags <= {52'h0, x86_of, 3'h0, x86_sf, x86_zf, 1'b0, 1'b0, 1'b0, x86_cf, 1'b1};
        end
    endtask

endmodule
