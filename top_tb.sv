`timescale 1ns / 1ps


module top_tb;


    localparam IMEM_DEPTH = 4;       
    localparam REGF_WIDTH = 16;     
    localparam ALU_WIDTH = 16;       
    localparam PROG_VALUE = 3;

    logic clk;                    
    logic reset_n;                

    

    top #(
        .IMEM_DEPTH(IMEM_DEPTH),       
        .REGF_WIDTH(REGF_WIDTH),     
        .ALU_WIDTH(ALU_WIDTH),       
        .PROG_VALUE(PROG_VALUE)
    ) uut (
        .clk(clk),                    
        .reset_n(reset_n)
        );


    always begin
        #5 clk = ~clk;
    end

    
    initial begin
    
        clk = 0;
        reset_n = 0;
        
    
        #10;
        reset_n = 1;
        
  
        
        #100;
        $finish;
    end


endmodule
