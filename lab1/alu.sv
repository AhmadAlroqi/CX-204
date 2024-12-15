`timescale 1ns / 1ps


module alu  #(parameter  ALU_WIDTH = 16 ) 
(
    input  logic [ALU_WIDTH-1:0] a, 
    input  logic [ALU_WIDTH-1:0] b, 
    input  logic [1:0] opcode,     
    output logic [ALU_WIDTH-1:0] result

    );
    
    
     always_comb begin
        case (opcode)
            2'b00: result = a + b; 
            2'b01: result = a - b; 
            2'b10: result = a & b; 
            2'b11: result = a | b;
            default: result = 'bx; 
        endcase
    end
   
    
endmodule
