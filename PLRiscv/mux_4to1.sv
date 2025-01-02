`timescale 1ns / 1ps
module mux_4to1 #(
    parameter WIDTH = 32  // Default width is 32 bits
)(
    input logic [WIDTH-1:0] in0,   // Input 0
    input logic [WIDTH-1:0] in1,   // Input 1
    input logic [WIDTH-1:0] in2,   // Input 2
    input logic [WIDTH-1:0] in3,   // Input 3
    input logic [1:0] sel,         // 2-bit selector (to select one of the 4 inputs)
    output logic [WIDTH-1:0] out   // Output
);

    always_comb begin
        case(sel)
            2'b00: out = in0;  // Select input 0
            2'b01: out = in1;  // Select input 1
            2'b10: out = in2;  // Select input 2
            2'b11: out = in3;  // Select input 3
            default: out = {WIDTH{1'b0}}; // Default output (zero)
        endcase
    end

endmodule
