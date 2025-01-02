`timescale 1ns / 1ps
module main_control(
    input clk, reset_n,
    input logic [6:0] ins,          // 7-bit instruction opcode
    input logic func7,              // func7 input
    input logic [2:0] func3,        // func3 input
    input logic less,               // Indicates if rs1 < rs2 (signed)
    input logic zero,               // Indicates if rs1 == rs2
    output logic mem_write_exmem,         // Memory write control signal
    output logic [2:0] mem_to_reg_memwb,  // Memory-to-register control signal
    output logic reg_write_memwb,         // Register write control signal
    output logic [3:0] alu_ctrl_idex,     // ALU control signal
    output logic pc_sel_memwb,            // Program counter select signal
    output logic reg_write_exmem_out,      // Forwarded reg_write_exmem signal
output logic alu_src_idex
);

    // Internal signals
    logic [1:0] alu_op;                  // ALU operation control signal
    logic branch;               // Control signals from control unit
    logic [3:0] alu_ctrl;                // ALU control signal
    logic mem_write, reg_write;          // Control signals for memory and register write
    logic [2:0] mem_to_reg;              // Memory-to-register control signal
    logic pc_sel;                        // PC select signal from branch controller
logic alu_src ; 
    // Instantiate alu_control module
    alu_control ac(
        .alu_op(alu_op),
        .func7(func7),
        .func3(func3),
        .alu_ctrl(alu_ctrl)
    );

    // Instantiate control_unit module
    control_unit cu(
        .ins(ins),
        .branch(branch),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .alu_op(alu_op)
    );

    // Instantiate branch_controller module
    branch_controller bc(
        .less(less),
        .zero(zero),
        .branch(branch),
        .func3(func3),
        .pc_sel(pc_sel)
    );

    // ------------------------------ ID/EX Pipeline Registers
    logic mem_write_idex, reg_write_idex, pc_sel_idex;
    logic [2:0] mem_to_reg_idex;


  n_bit_reg #(4) idex_alu_src (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(alu_src),
        .data_out(alu_src_idex)
    );






    n_bit_reg #(4) idex_alu_ctrl_reg (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(alu_ctrl),
        .data_out(alu_ctrl_idex)
    );

    n_bit_reg #(1) idex_mem_write (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(mem_write),
        .data_out(mem_write_idex)
    );

    n_bit_reg #(3) idex_mem_to_reg (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(mem_to_reg),
        .data_out(mem_to_reg_idex)
    );

    n_bit_reg #(1) idex_reg_write (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(reg_write),
        .data_out(reg_write_idex)
    );

    n_bit_reg #(1) idex_pc_sel (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(pc_sel),
        .data_out(pc_sel_idex)
    );

    // ------------------------------ EX/MEM Pipeline Registers
   logic [2:0] mem_to_reg_exmem,mem_to_reg_memwb;
    logic pc_sel_exmem;
    logic reg_write_exmem ; 
    n_bit_reg #(1) exmem_mem_write (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(mem_write_idex),
        .data_out(mem_write_exmem)
    );

    n_bit_reg #(3) exmem_mem_to_reg (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(mem_to_reg_idex),
        .data_out(mem_to_reg_exmem)
    );

    n_bit_reg #(1) exmem_reg_write (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(reg_write_idex),
        .data_out(reg_write_exmem)
    );

    assign reg_write_exmem_out = reg_write_exmem;

    n_bit_reg #(1) exmem_pc_sel (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(pc_sel_idex),
        .data_out(pc_sel_exmem)
    );

    // ------------------------------ MEM/WB Pipeline Registers
    n_bit_reg #(3) memwb_mem_to_reg (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(mem_to_reg_exmem),
        .data_out(mem_to_reg_memwb)
    );
        n_bit_reg #(3) memwb_mem_to_reg1 (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(mem_to_reg_memwb),
        .data_out(mem_to_reg_memwb1)
    );

    n_bit_reg #(1) memwb_reg_write (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(reg_write_exmem),
        .data_out(reg_write_memwb)
    );

    n_bit_reg #(1) memwb_pc_sel (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(pc_sel_exmem),
        .data_out(pc_sel_memwb)
    );

endmodule