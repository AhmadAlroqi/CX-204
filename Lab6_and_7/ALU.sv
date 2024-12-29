`timescale 1ns / 1ps
module ALU #(parameter ALU_WIDTH = 16) (
    input  logic [ALU_WIDTH-1:0] rs1,
    input  logic [ALU_WIDTH-1:0] rs2,
    input  logic [3:0] opcode,
    input  logic [ALU_WIDTH-1:0] imm, // Immediate value for U-Type
   //input  logic [ALU_WIDTH-1:0] pc,  // Program Counter for AUIPC
    output logic [ALU_WIDTH-1:0] rd,
    output logic zero,
    output logic less
);

    always_comb begin
        // Default case to avoid latches
        case (opcode)
            4'b0000: rd = rs1 + rs2;                                  // ADD
            4'b1000: rd = rs1 - rs2;                                  // SUB
            4'b0001: rd = rs1 << rs2[4:0];                            // SLL
           4'b0010: rd = (rs1 < rs2) ? 1 : 0;                        // SLT (Signed Comparison)
        //  4'b0011: if( (rs1 < rs2) rd-=1 ; less=1 else rd=0;less=0 

            4'b0011: rd = ($unsigned(rs1) < $unsigned(rs2)) ? 1 : 0;  // SLTU (Unsigned Comparison)
          //   4'b0011: if( ($unsigned(rs1) < $unsigned(rs2))) rd=1 ; less=1 else rd=0;less=0 
            4'b0100: rd = rs1 ^ rs2;                                  // XOR
            4'b0101: rd = rs1 >> rs2[4:0];                            // SRL
            4'b1101: rd = rs1 >>> rs2[4:0];                           // SRA
            4'b0110: rd = rs1 | rs2;                                  // OR
            4'b0111: rd = rs1 & rs2;                                  // AND
         
            default: rd = 'b0;                                        // Default case
        endcase
    end

    // Output flags
    assign zero = (rd == 0);                                          // Zero flag
    assign less = (opcode == 4'b0010 || opcode == 4'b0011) ? rd[0] : 0; // Less flag for SLT/SLTU

endmodule
