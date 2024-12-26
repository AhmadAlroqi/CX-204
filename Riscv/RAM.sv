`timescale 1ns / 1ps

module data_mem(
  
    input logic clk,
    input logic  write_enable,
    input logic [31:0]address,
    input logic [31:0]data_in,
    input logic read_enable ,
    output logic  [31:0]data_out
    );
   

logic [31:0]ram_block[31:0];

always @(posedge clk) begin
        if(write_enable)
            ram_block[address] <= data_in;
         if (read_enable)
               data_out <= ram_block[address];
end

endmodule