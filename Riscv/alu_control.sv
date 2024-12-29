`timescale 1ns / 1ps
module alu_control(
    input logic [1:0] alu_op,          // ALU operation type from main control
    input logic func7,           // Function 7 bit from instruction
    input logic [2:0] func3,     // Function 3 field from instruction
    output logic [3:0] alu_ctrl  // ALU control signal
);

    always_comb begin
        // Default case: No operation

        // Decode ALU operation based on alu_op
        case (alu_op)
            2'b10: // R-type instructions
                case (func3)
                    3'b000: alu_ctrl = func7 ? 4'b1000 : 4'b0000; // ADD (0000) or SUB (1000)
                    3'b001: alu_ctrl = 4'b0001;                   // SLL
                    3'b010: alu_ctrl = 4'b0010;                   // SLT (Signed)
                    3'b011: alu_ctrl = 4'b0011;                   // SLTU (Unsigned)
                    3'b100: alu_ctrl = 4'b0100;                   // XOR
                    3'b101: alu_ctrl = func7 ? 4'b1101 : 4'b0101; // SRA (1101) or SRL (0101)
                    3'b110: alu_ctrl = 4'b0110;                   // OR
                    3'b111: alu_ctrl = 4'b0111;                   // AND
                endcase

            2'b01: // Branch instructions
                case (func3)
                    3'b000: alu_ctrl = 4'b1000; // BEQ (uses SUB for comparison)
                    3'b001: alu_ctrl = 4'b1000; // BNE (uses SUB for comparison)
                    3'b100: alu_ctrl = 4'b0010; // BLT (uses SLT for comparison)
                    3'b101: alu_ctrl = 4'b0010; // BGE (uses SLT, inverted result handled outside)
                    3'b110: alu_ctrl = 4'b0011; // BLTU (uses SLTU for comparison)
                    3'b111: alu_ctrl = 4'b0011; // BGEU (uses SLTU, inverted result handled outside)
                endcase

            2'b00: // Load/Store instructions (S-type)
                alu_ctrl = 4'b0000; // ADD (address calculation)

            2'b11: // I-type instructions
                case (func3)
                    3'b000: alu_ctrl = 4'b0000;                   // ADDI
                    3'b010: alu_ctrl = 4'b0010;                   // SLTI
                    3'b011: alu_ctrl = 4'b0011;                   // SLTIU
                    3'b100: alu_ctrl = 4'b0100;                   // XORI
                    3'b110: alu_ctrl = 4'b0110;                   // ORI
                    3'b111: alu_ctrl = 4'b0111;                   // ANDI
                    3'b001: alu_ctrl = 4'b0001;                   // SLLI
                    3'b101: alu_ctrl = func7 ? 4'b1101 : 4'b0101; // SRAI or SRLI
                endcase

//            3'b100: // U-type instructions
//                alu_ctrl = 4'b0000; // Use ADD for LUI or AUIPC

            default:
                alu_ctrl = 4'b0000; // Default case
        endcase
    end

endmodule