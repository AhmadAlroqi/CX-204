`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 02:59:06 PM
// Design Name: 
// Module Name: Inst_Mem
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


module Inst_Mem  #(parameter IMEM_DEPTH=8 ,parameter PROG_VALUE=8)(
input logic clk,reset,
input logic [PROG_VALUE -1:0] pc,
output logic [IMEM_DEPTH-1:0] ins_out
    );
         reg [IMEM_DEPTH-1:0] ins [PROG_VALUE];

 initial $readmemb("/home/it/Downloads/CX-204-Lab1/support_files/fib_im.mem", ins);  

    
    always @(posedge clk , negedge reset)  begin
   if(~reset)begin
   
   ins_out = ins[pc] ; 
   
   
   
   end end
    
    
endmodule
