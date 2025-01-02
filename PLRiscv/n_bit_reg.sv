`timescale 1ns / 1ps

module n_bit_reg #(parameter n = 64) (
    input wire clk,               
    input wire reset_n,           
    input wire [n-1:0] data_in,   
    output reg [n-1:0] data_out   
);
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            data_out <= {n{1'b0}}; 
        else
            data_out <= data_in;   
    end
endmodule
