`timescale 1ns / 1ps

module program_counter #(parameter n = 32)(
    input logic clk,      
    input logic reset,   
    input logic [n-1:0] adrs,
    output logic [n-1:0] count 
);

    always @(posedge clk or negedge reset) begin
        if (!reset) 
            count <= 0; 
        else 
            count <= adrs; 
    end

endmodule
