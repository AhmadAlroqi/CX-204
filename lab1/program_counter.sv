`timescale 1ns / 1ps

module program_counter #(
    parameter  PROG_VALUE = 3,
    parameter n = 8
)
(
    input logic clk,
    input logic reset_n,
    input logic en,
    output logic [n-1:0] count
);

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)      
            count <= 0;     
         else if (en)  
             if (count <= PROG_VALUE -1 )
                count <= count + 1;
            else 
                  count <= 0;     

    end
    
    

endmodule
