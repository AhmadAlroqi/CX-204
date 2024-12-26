`timescale 1ns / 1ps

module control_unit(
    input logic [6:0] ins,
    output logic branch,
    output logic mem_write,
    output logic mem_to_reg,
    output logic alu_src,
    output logic reg_write,
    output logic [1:0] alu_op
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
                alu_op = 2'b10;
                alu_src = 0;
                branch = 0;
            end

            // I-type Immediate Instruction
            7'b0010011: begin
                reg_write = 1;
                mem_write = 0;
                mem_to_reg = 0;
                alu_op = 2'b11;
                alu_src = 1;
                branch = 0;
            end

            // Load Instruction
            7'b0000011: begin
                reg_write = 1;
                mem_write = 0;
                mem_to_reg = 1;
                alu_op = 2'b00;
                alu_src = 1;
                branch = 0;
            end

            // Store Instruction
            7'b0100011: begin
                reg_write = 0;
                mem_write = 1;
                // mem_to_reg is 'x', so we leave it unchanged or set to 0 for consistency
                mem_to_reg = 0;
                alu_op = 2'b00;
                alu_src = 1;
                branch = 0;
            end

            // Branch (beq) Instruction
            7'b1100011: begin
                reg_write = 0;
                mem_write = 0;
                // mem_to_reg is 'x', so we leave it unchanged or set to 0 for consistency
                mem_to_reg = 0;
                alu_op = 2'b01;
                alu_src = 0;
                branch = 1;
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
