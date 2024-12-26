`timescale 1ns / 1ps

module mux_2to1 #(
    parameter WIDTH = 32  // Parameter to set the width of the inputs and output
)(
    input logic [WIDTH-1:0] in0,    // First input
    input logic [WIDTH-1:0] in1,    // Second input
    input logic sel,                // Selection signal
    output logic [WIDTH-1:0] out    // Output
);

    // MUX functionality
    always_comb begin
        if (sel)
            out = in1;
        else
            out = in0;
    end

endmodule
