`timescale 1ns / 1ps

module imm_gen(
    input logic [31:0] inst,
    output logic [31:0] imm
    );
     always_comb begin
   case (inst[6:0])
            7'b0010011: imm = { {20{inst[31]}}, inst[31:20] }; // I-type
            7'b0000011: imm = { {20{inst[31]}}, inst[31:20] }; // I-type
            7'b0100011: imm = { {20{inst[31]}}, inst[31:25], inst[11:7] }; // S-type
            7'b1100011: imm = { {20{inst[31]}},  inst[31:25], inst[11:7]}; // B-type
            default: imm = { {20{inst[31]}}, inst[31:20] }; // Default case for unsupported instructions
        endcase
        
//        if(temp[11])
//        imm = {10'b1111111111, temp};
//        //imm = {32 tmep}
//        else 
//         imm = {10'b0000000000, temp};
        
    end
endmodule
