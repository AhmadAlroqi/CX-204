`timescale 1ns / 1ps


module inst_mem #(parameter IMEM_DEPTH=$clog2(64) ,parameter PROG_VALUE=3)(
input logic [PROG_VALUE -1:0] pc,
output logic [8-1:0] ins_out
    );
         reg [7:0] ins [0:3];

 initial $readmemb("/home/it/Downloads/CX-204-Lab1/support_files/fib_im.mem", ins);  
      
       assign ins_out = ins[pc] ; 


endmodule