`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/02/2025 09:20:08 AM
// Design Name: 
// Module Name: n_bit_reg
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
