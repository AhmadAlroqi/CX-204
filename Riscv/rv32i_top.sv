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
    logic mem_write;                // Memory write control signal
    logic [2:0] mem_to_reg;               // Memory-to-register control signal
    logic alu_src;                  // ALU source control signal
    logic reg_write;                // Register write control signal
    logic [3:0] alu_ctrl;           // ALU control signal
    logic less;                     // Indicates if rs1 < rs2 (signed)
    logic zero;                     // Indicates if rs1 == rs2
    logic pc_sel;                   // Program counter select signal

    // Instantiation of data_path module
    data_path dp (
        .clk(clk),                  // Connect clock signal
        .reset(reset),              // Connect reset signal
        .branch(branch),            // Connect branch control signal from main_control
        .mem_write(mem_write),      // Connect memory write control signal from main_control
        .mem_to_reg(mem_to_reg),    // Connect memory-to-register control signal from main_control
        .alu_src(alu_src),          // Connect ALU source control signal from main_control
        .reg_write(reg_write),      // Connect register write control signal from main_control
        .alu_ctrl(alu_ctrl),        // Connect ALU control signal from main_control
        .opcode(opcode),            // Output instruction opcode to main_control
        .func7(func7),              // Output func7 signal to main_control
        .func3(func3),   
        .pc_sel(pc_sel),
        .less(less),                // Connect less signal from data_path or ALU
        .zero(zero)  
                   // Output func3 signal to main_control
    );

    // Instantiation of main_control module (includes branch_controller functionality)
    main_control mc (
        .ins(opcode),               // Connect instruction opcode from data_path
        .func7(func7),              // Connect func7 signal from data_path
        .func3(func3),              // Connect func3 signal from data_path
        .less(less),                // Connect less signal from data_path or ALU
        .zero(zero),                // Connect zero signal from data_path or ALU
        .branch(branch),            // Output branch control signal to data_path
        .mem_write(mem_write),      // Output memory write control signal to data_path
        .mem_to_reg(mem_to_reg),    // Output memory-to-register control signal to data_path
        .alu_src(alu_src),          // Output ALU source control signal to data_path
        .reg_write(reg_write),      // Output register write control signal to data_path
        .alu_ctrl(alu_ctrl),        // Output ALU control signal to data_path
        .pc_sel(pc_sel)             // Output program counter select signal
    );

endmodule