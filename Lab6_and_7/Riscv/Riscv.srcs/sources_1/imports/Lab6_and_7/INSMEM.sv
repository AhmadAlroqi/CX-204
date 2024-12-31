`timescale 1ns / 1ps


module inst_mem #(parameter IMEM_DEPTH=32 )(
input logic [IMEM_DEPTH -1:0] pc,
output logic [IMEM_DEPTH-1:0] ins_out
    );
         reg [IMEM_DEPTH-1:0] ins [0:255];
 initial begin $readmemh("/home/it/Desktop/fib_im.mem", ins);  end
      
       assign ins_out = ins[pc>>2] ; 


endmodule