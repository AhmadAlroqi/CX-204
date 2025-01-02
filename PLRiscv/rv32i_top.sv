`timescale 1ns / 1ps
module rv32i_top(
    input logic clk,                // Clock signal
    input logic reset               // Reset signal
);

    // Internal signals for interconnection
    logic [6:0] opcode;             // Instruction opcode
    logic func7;                    // func7 signal
    logic [2:0] func3;              // func3 signal
    logic branch;                   // Branch control signal
    logic mem_write_exmem;                // Memory write control signal
    logic [2:0] mem_to_reg_memwb;               // Memory-to-register control signal
    logic alu_src;                  // ALU source control signal
    logic reg_write_memwb;                // Register write control signal
    logic [3:0] alu_ctrl_idex;           // ALU control signal
    logic less;                     // Indicates if rs1 < rs2 (signed)
    logic zero;                     // Indicates if rs1 == rs2
    logic pc_sel_memwb,reg_write_exmem_out;   
   // logic [6:0] ins;             // Program counter select signal

    // Instantiation of data_path module
    data_path dp (
        .clk(clk),                  // Connect clock signal
        .reset(reset),              // Connect reset signal
        .branch(branch),            // Connect branch control signal from main_control
        .mem_write(mem_write_exmem),      // Connect memory write control signal from main_control
        .mem_to_reg(mem_to_reg_memwb),    // Connect memory-to-register control signal from main_control
        .alu_src(alu_src),          // Connect ALU source control signal from main_control
        .reg_write(reg_write_memwb),      // Connect register write control signal from main_control
        .alu_ctrl(alu_ctrl_idex),        // Connect ALU control signal from main_control
        .opcode(opcode),            // Output instruction opcode to main_control
        .func7(func7),              // Output func7 signal to main_control
        .func3(func3),   
        .pc_sel(pc_sel_memwb),
        .less(less),                // Connect less signal from data_path or ALU
        .zero(zero),
        .reg_write_exmem_out(reg_write_exmem_out)  
                   // Output func3 signal to main_control
    );

    // Instantiation of main_control module (includes branch_controller functionality)
         main_control MC (
            .clk(clk),
            .reset_n(reset),
            .ins(opcode),
            .func7(func7),
            .func3(func3),
            .less(less),
            .zero(zero),
            .mem_write_exmem(mem_write_exmem),
            .mem_to_reg_memwb(mem_to_reg_memwb),
            .reg_write_memwb(reg_write_memwb),
            .alu_ctrl_idex(alu_ctrl_idex),
            .pc_sel_memwb(pc_sel_memwb),
            .reg_write_exmem_out(reg_write_exmem_out),
            .alu_src_idex(alu_src)
        );

endmodule