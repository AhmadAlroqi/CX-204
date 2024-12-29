`timescale 1ns / 1ps

module register_file #(parameter REGF_WIDTH=8,REGF_DEPTH = 32) (
    input logic clk,
    input logic reset,
    input logic [4:0] RS, RT,
    output logic [15:0] out1, out2,
    input logic [1:0] RD,
    input logic [REGF_WIDTH - 1:0] Data_in,
    input logic enW
);
    
    reg [REGF_WIDTH-1:0] register_file [0:3];
    
    initial $readmemb("/home/it/Downloads/CX-204-Lab1/support_files/fib_rf.mem", register_file);  
    
    always @(posedge clk or negedge reset) begin
        if (!reset) begin
           int i;
            for (i = 0; i < REGF_DEPTH; i = i + 1) begin
                register_file[i] <= {REGF_WIDTH{1'b0}};
            end
        end
        else if (enW) begin
            register_file[RD] <= Data_in;
        end
    end
    
    always @(*) begin
        out1 = register_file[RS];
        out2 = register_file[RT];
    end

endmodule
