`timescale 1ns / 1ps

module data_path(
    input clk, reset,                // Clock and reset signals
    input logic branch,              // Control signal from main_control
    input logic mem_write,           // Control signal from main_control
    input logic mem_to_reg,          // Control signal from main_control
    input logic alu_src,             // Control signal from main_control
    input logic reg_write,           // Control signal from main_control
    input logic [3:0] alu_ctrl,      // ALU control signal from main_control
    output logic [6:0] opcode,       // Instruction opcode
    output logic func7,              // func7 signal
    output logic [2:0] func3,         // func3 signal
    input logic pc_sel,
    output logic zero,less

);
    // Instruction fields
    logic [31:0] ins; 
    assign opcode = ins[6:0];
    assign func7 = ins[30];
    assign func3 = ins[14:12];

    // PC and immediate signals
    logic [31:0] pcin, pcout, imm; 
    wire [31:0] pc4, pcoffset;

    // Full adder for PC + 4
    full_adder #(.WIDTH(32)) my_adderpc4 (
        .a(pcout),
        .b(32'd4),
        .cin(0),
        .sum(pc4),
        .cout()
    );

    // Full adder for PC + offset
    full_adder #(.WIDTH(32)) offset (
        .a(pcout),
        .b(imm),
        .cin(0),
        .sum(pcoffset),
        .cout()
    );

    // MUX for PC selection
    mux_2to1 #(.WIDTH(32)) my_mux (
        .in0(pc4),
        .in1(pcoffset),
        .sel(pc_sel),
        .out(pcin)
    );

    // Program counter
    program_counter #(32) pc (
        .clk(clk),
        .reset(reset),
        .adrs(pcin), //imput
        .count(pcout)
    );

    // Instruction memory
    inst_mem #(
        .IMEM_DEPTH(32)
    ) im (
        .pc(pcout),
        .ins_out(ins)
    );

    // Register file
    wire [31:0] regout1, regout2, aluin2, reg_datain;
    register_file #(
        .REGF_WIDTH(8),
        .REGF_DEPTH(32)
    ) rf (
        .clk(clk),
        .reset(reset),
        .RS(ins[19:15]),
        .RT(ins[24:20]),
        .out1(regout1),
        .out2(regout2),
        .RD(ins[11:7]),
        .Data_in(reg_datain),
        .enW(reg_write)
    );

    // Immediate generator
    imm_gen ig (
        .inst(ins),
        .imm(imm)
    );

    // MUX for ALU input
    mux_2to1 #(.WIDTH(32)) alu_in (
        .in0(regout2),
        .in1(imm),
        .sel(alu_src),
        .out(aluin2)
    );

    // ALU module
    wire [31:0] alu_result;
    ALU #(.ALU_WIDTH(32)) alu (
        .rs1(regout1),
        .rs2(aluin2),
        .opcode(alu_ctrl),
        .rd(alu_result),
        .zero(zero),
        .less(less)

    );

     logic [31:0] read_data;
      Data_memory data_memory_inst(
        .clk(clk),
        .resetn(reset),
        .memwrite(mem_write),
        .addr(alu_result),
        .load_type(func3),
        .wdata(regout2),
        .rdata_word(read_data)
    );

    // MUX for register data input
    mux_2to1 #(.WIDTH(32)) Reg_data_in (
        .in0(alu_result),
        .in1(read_data),
        .sel(mem_to_reg),
        .out(reg_datain)
    );

endmodule
