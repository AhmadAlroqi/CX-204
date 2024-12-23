`timescale 1ns / 1ps

module top #(
    parameter  IMEM_DEPTH = 4,       
    parameter  REGF_WIDTH = 16,     
    parameter  ALU_WIDTH = 16,       
    parameter  PROG_VALUE = 3)
    (
    input logic clk,                    
    input logic reset_n               

);
    
    logic [ALU_WIDTH-1:0] op1, op2;      
    logic [7:0]ins_out;
    logic [ALU_WIDTH-1:0] alu_result;
     logic [IMEM_DEPTH-1:0] pc ;
     
     Inst_Mem #(.IMEM_DEPTH(IMEM_DEPTH),.PROG_VALUE(PROG_VALUE))
         inst_mem (
        .pc(pc),          
        .ins_out(ins_out) 
    );
    
        register_file #(.REGF_WIDTH(REGF_WIDTH)) rf (
        .clk(clk),              
        .select1(ins_out[3:2]),        
        .select2(ins_out[5:4]),        
        .out1(op1),              
        .out2(op2),              
        .select_write(ins_out[7:6]),  
        .Data_in(alu_result)        
    );
    
      
   alu #(.ALU_WIDTH(ALU_WIDTH)) alu_ins (
        .a(op1),
        .b(op2),
        .opcode(ins_out[1:0]),
        .result(alu_result)
    );
    
    
     program_counter #(.PROG_VALUE(PROG_VALUE)) pc_counter (
        .clk(clk),
        .reset_n(reset_n),
        .en(1),
        .count(pc)
    );
    



  
endmodule

