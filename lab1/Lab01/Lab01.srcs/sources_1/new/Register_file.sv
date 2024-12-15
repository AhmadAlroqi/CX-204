`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/15/2024 02:03:21 PM
// Design Name: 
// Module Name: Register_file
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


module Reg_file #(parameter REGF_WIDTH=8    ) (
input logic clk,reset,write,
input logic [1:0]select1,select2,
output logic [3:0] out1,out2, 
input logic [1:0] select_write , 
input logic [REGF_WIDTH -1:0] Data_in
//input logic [REGF_WIDTH -1:0] Data_out

    );
    
     reg [REGF_WIDTH-1:0] register_file [4];
        
   
   initial $readmemb("/home/it/Downloads/CX-204-Lab1/support_files/register_data.bin", register_file);  
        
always @(posedge clk , negedge reset)  begin
   if(~reset)begin
    register_file [0] =0 ; 
    register_file [1] =0 ; 
    register_file [2] =0 ; 
    register_file [3] =0 ; end

   if(write & ~ (select_write ==0) )
   register_file[select_write] = Data_in  ; 
    
    end



assign out1 = register_file[select1] ; 
assign out2 = register_file[select2] ; 




endmodule
