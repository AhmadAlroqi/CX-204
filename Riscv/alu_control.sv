`timescale 1ns / 1ps
module alu_control(
    input [1:0] alu_op,          // ALU operation type from main control
    input logic func7,           // Function 7 bit from instruction
    input logic [2:0] func3,     // Function 3 field from instruction
    output logic [3:0] alu_ctrl  // ALU control signal
);

    always_comb begin
        // Default case: No operation
//        alu_ctrl = 0;

        // Decode ALU operation based on alu_op
        case (alu_op)
            2'b10: // R-type instructions
                case (func3)
                    3'b000: begin 
                        alu_ctrl = func7 ? 1 : 0; // ADD or SUB
                    end
                    3'b001: alu_ctrl = 2;         // SLL
                    3'b010: alu_ctrl = 3;         // SLT
                    3'b011: alu_ctrl = 4;         // SLTU
                    3'b100: alu_ctrl = 5;         // XOR
                    3'b101: begin 
                        alu_ctrl = func7 ? 6 : 7; // SRL or SRA
                    end
                    3'b110: alu_ctrl = 8;         // OR
                    3'b111: alu_ctrl = 9;         // AND
                endcase

            2'b01: // BEQ (Branch Equal)
                alu_ctrl = 1; // SUB (used for comparison)

            2'b00: // Load/Store instructions (S-type)
                alu_ctrl = 0; // ADD (address calculation)

            2'b11: // I-type instructions
                case (func3)
                    3'b000: alu_ctrl = 0;         // ADDI
                    3'b010: alu_ctrl = 3;         // SLTI
                    3'b011: alu_ctrl = 4;         // SLTIU
                    3'b100: alu_ctrl = 5;         // XORI
                    3'b110: alu_ctrl = 8;         // ORI
                    3'b111: alu_ctrl = 9;         // ANDI
                    3'b001: alu_ctrl = 2;         // SLLI
                    3'b101: alu_ctrl = func7 ? 7 : 6; // SRLI or SRAI
                endcase
                default:alu_ctrl = 0;
        endcase
    end

endmodule