`timescale 1ns / 1ps

module control_unit(
    input logic [6:0] ins,
    output logic branch,
    output logic mem_write,
    output logic mem_to_reg,
    output logic alu_src,
    output logic reg_write,
    output logic [2:0] alu_op
);
    always_comb begin
//        // Default case: All control signals set to 0
//        reg_write = 0;
//        mem_write = 0;
//        mem_to_reg = 0; // Assume 'x' means don't care but set to 0 here for consistency
//        alu_op = 2'b00;
//        alu_src = 0;
//        branch = 0;

        case (ins)
            // R-type Instruction
            7'b0110011: begin
                reg_write = 1;
                mem_write = 0;
                mem_to_reg = 0;
                alu_op = 3'b010;
                alu_src = 0;
                branch = 0;
            end

            // I-type Immediate Instruction
            7'b0010011: begin
                reg_write = 1;
                mem_write = 0;
                mem_to_reg = 0;
                alu_op = 3'b011;
                alu_src = 1;
                branch = 0;
            end

            // Load Instruction
            7'b0000011: begin
                reg_write = 1;
                mem_write = 0;
                mem_to_reg = 1;
                alu_op = 3'b000;
                alu_src = 1;
                branch = 0;
            end

            // Store Instruction
            7'b0100011: begin
                reg_write = 0;
                mem_write = 1;
                // mem_to_reg is 'x', so we leave it unchanged or set to 0 for consistency
                mem_to_reg = 0;
                alu_op = 3'b000;
                alu_src = 1;
                branch = 0;
            end

            // Branch (beq) Instruction
            7'b1100011: begin
                reg_write = 0;
                mem_write = 0;
                // mem_to_reg is 'x', so we leave it unchanged or set to 0 for consistency
                mem_to_reg = 0;
                alu_op = 3'b001;
                alu_src = 0;
                branch = 1;
            end
// LUI Instruction
            7'b0110111: begin
                reg_write = 1;
                mem_write = 0;
                mem_to_reg = 0;
                alu_op = 3'b100; // ALU passes the immediate (upper 20 bits)
                alu_src = 1;    // Immediate source
                branch = 0;
            end

            // AUIPC Instruction
            7'b0010111: begin
                reg_write = 1;
                mem_write = 0;
                mem_to_reg = 0;
                alu_op = 3'b100; // ALU adds PC + immediate
                alu_src = 1;    // Immediate source
                branch = 0;
            end
            
            
           7'b1101111: begin // JAL
                reg_write = 1;   // Save return address (PC + 4) to rd
                mem_write = 0;   // No memory write
                mem_to_reg = 0;  // Not a memory operation
                alu_op = 3'b000; // ALU calculates PC + immediate (for JAL target)
                alu_src = 1;     // Use immediate as source for target address
                branch = 0;      // Not a branch operation
              end
         
            
            

            
            // Default case (already set to 0 in the beginning)
            default: begin
                reg_write = 0;
                mem_write = 0;
                mem_to_reg = 0;
                alu_op = 2'b00;
                alu_src = 0;
                branch = 0;
            end
        endcase
    end
endmodule