`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2024 02:29:18 PM
// Design Name: 
// Module Name: branch_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module branch_controller(
    input logic less,               // Indicates if rs1 < rs2 (signed)
    input logic zero,               // Indicates if rs1 == rs2
    input logic branch,             // Global branch enable signal
    input logic [2:0] func3,        // Function code to determine branch type
    output logic pc_sel             // Program counter select signal; 1 to branch/jump
);

    always_comb begin

        // Evaluate branch condition based on func3
        case (func3)
            3'b000: pc_sel = (zero & branch) ? 1 : 0;         // beq: Branch if equal
            3'b001: pc_sel = (!zero & branch) ? 1 : 0;        // bne: Branch if not equal
            3'b100: pc_sel = (less & branch) ? 1 : 0;         // blt: Branch if less than (signed)
            3'b101: pc_sel = ((!less | zero) & branch) ? 1 : 0; // bge: Branch if greater or equal (signed)
            3'b110: pc_sel = (less & branch) ? 1 : 0;         // bltu: Branch if less than (unsigned)
            3'b111: pc_sel = ((!less | zero) & branch) ? 1 : 0; // bgeu: Branch if greater or equal (unsigned)
            3'b010: pc_sel = branch ? 1 : 0;                  // jal/jalr: Unconditional jump
            default: pc_sel = 0;
        endcase
    end

endmodule