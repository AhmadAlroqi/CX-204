`timescale 1ns / 1ps

module register_file #(parameter REGF_WIDTH=8    ) (
input logic clk,
input logic [1:0]select1,select2,
output logic [15:0] out1,out2, 
input logic [1:0] select_write , 
input logic [REGF_WIDTH -1:0] Data_in

    );
    
     reg [REGF_WIDTH-1:0] register_file [0:3];
        
   
   initial $readmemb("/home/it/Downloads/CX-204-Lab1/support_files/fib_rf.mem", register_file);  
        
        always @(posedge clk ) begin
            if(select_write != 0)
              register_file[select_write] = Data_in  ; 
            
           end
        
        
        always @(*) begin
         out1 = register_file[select1] ; 
         out2 = register_file[select2] ; 
        end
        


endmodule