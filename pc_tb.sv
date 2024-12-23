`timescale 1ns / 1ps


module pc_tb;
    parameter PROG_VALUE = 3;
    parameter n = 8;
        logic clk;
        logic reset_n;
        logic load;
        logic en;
        logic [n-1:0] load_data;
        logic  [3:0] count;

    program_counter #(
        .PROG_VALUE(PROG_VALUE)   
         ) uut (
        .clk(clk),
        .reset_n(reset_n),
        .en(en),
        .count(count)
    );

    initial clk = 0;
    always #5 clk = ~clk; 

    initial begin
        reset_n = 0;
        en = 0;

        #10 reset_n = 1;

             en = 1;
            #10
            


        #500 $finish;
    end

endmodule
