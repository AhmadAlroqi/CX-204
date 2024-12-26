`timescale 1ns / 1ps

module ALU #(parameter ALU_WIDTH = 16) (
    input  logic [ALU_WIDTH-1:0] rs1,
    input  logic [ALU_WIDTH-1:0] rs2,
    input  logic [3:0] opcode,
    output logic [ALU_WIDTH-1:0] rd,
    output logic zero,less
);



    always_comb begin
        case (opcode)
            4'b0000: rd = rs1 + rs2;                                  // ADD
            4'b1000: rd = rs1 - rs2;                                  // SUB
            4'b0001: rd = rs1 << rs2[4:0];                           // SLL
            4'b0010: rd = (rs1 < rs2) ? 1 : 0;                       // SLT
            4'b0011: rd = ($unsigned(rs1) < $unsigned(rs2)) ? 1 : 0; // SLTU
            4'b0100: rd = rs1 ^ rs2;                                 // XOR
            4'b0101: rd = rs1 >> rs2[4:0];                           // SRL
            4'b1101: rd = rs1 >>> rs2[4:0];                          // SRA
            4'b0110: rd = rs1 | rs2;                                 // OR
            4'b0111: rd = rs1 & rs2;                                 // AND
            default: rd = 'bx;                                       // Default case
        endcase
    end

    assign zero = !(rd == 0);
    assign less = rs1< rs2;
    

endmodule
