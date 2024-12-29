`timescale 1ns / 1ps

module imm_gen(
    input logic [31:0] inst,
    output logic [31:0] imm
    );
     always_comb begin
  case (inst[6:0])
    7'b0010011: imm = { {20{inst[31]}}, inst[31:20] };             // I-type
    7'b0000011: imm = { {20{inst[31]}}, inst[31:20] };             // I-type
    7'b0100011: imm = { {20{inst[31]}}, inst[31:25], inst[11:7] }; // S-type
    7'b1100011: imm = { {20{inst[31]}}, inst[31:25], inst[11:7] }; // B-type
    7'b0110111: imm = {inst[31:12], 12'b0};                        // U-type (LUI)
    7'b0010111: imm = {inst[31:12], 12'b0};                        // U-type (AUIPC)
    default: imm = { {20{inst[31]}}, inst[31:20] };                // Default case for unsupported instructions
endcase

    end
    
    endmodule