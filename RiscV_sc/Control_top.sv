`timescale 1ns / 1ps
module main_control(
    input logic [6:0] ins,          // 7-bit instruction opcode
    input logic func7,              // func7 input
    input logic [2:0] func3,        // func3 input
    input logic less,               // Indicates if rs1 < rs2 (signed)
    input logic zero,               // Indicates if rs1 == rs2
    output logic branch,            // Branch control signal
    output logic mem_write,         // Memory write control signal
    output logic [2:0]mem_to_reg,        // Memory-to-register control signal
    output logic alu_src,           // ALU source control signal
    output logic reg_write,         // Register write control signal
    output logic [3:0] alu_ctrl,    // ALU control signal
    output logic pc_sel             // Program counter select signal; 1 to branch
);
    logic [1:0] alu_op;      // ALU operation control signal


    // Instantiation of alu_control module
    alu_control ac(
        .alu_op(alu_op),
        .func7(func7),            // Connect func7 input
        .func3(func3),            // Connect func3 input
        .alu_ctrl(alu_ctrl)       // Connect ALU control output
    );

    // Instantiation of control_unit module
    control_unit cu (
        .ins(ins),                // Connect instruction opcode
        .branch(branch),          // Connect branch control signal
        .mem_write(mem_write),    // Connect memory write control signal
        .mem_to_reg(mem_to_reg),  // Connect memory-to-register control signal
        .alu_src(alu_src),        // Connect ALU source control signal
        .reg_write(reg_write),    // Connect register write control signal
        .alu_op(alu_op)           // Connect ALU operation control signal
    );

    // Instantiation of branch_controller module
    branch_controller bc (
        .less(less),              // Connect to the signal indicating rs1 < rs2 (signed)
        .zero(zero),              // Connect to the signal indicating rs1 == rs2
        .branch(branch),          // Connect branch enable signal from control_unit
        .func3(func3),            // Connect func3 field from instruction
        .pc_sel(pc_sel)           // Connect to the program counter select output
    );

endmodule