`timescale 1ns / 1ps

module data_path(
    input clk, reset,                // Clock and reset signals
    input logic branch,              // Control signal from main_control
    input logic mem_write,           // Control signal from main_control
    input logic [2:0]mem_to_reg,          // Control signal from main_control
    input logic alu_src,             // Control signal from main_control
    input logic reg_write,           // Control signal from main_control
    input logic [3:0] alu_ctrl,      // ALU control signal from main_control
    output logic [6:0] opcode,       // Instruction opcode
    output logic func7,              // func7 signal
    output logic [2:0] func3,         // func3 signal
    input logic pc_sel,
    output logic zero,less

);

    logic [31:0]inst_id, current_pc_id,inst_if, current_pc_if,mem_pc,ex_alu_result,web_read_data;
    wire [31:0] regout1, regout2, aluin2, reg_datain;
    logic[4:0] mem_web_imm;

    // Instruction fields
    logic [31:0] ins; 
    assign opcode = inst_id[6:0];
    assign func7  = inst_id[30];
    assign func3 =  inst_id[14:12];
    // PC and immediate signals
    logic [31:0] pcin, pcout, imm; 
    wire [31:0] pc4, pcoffset;


    //                                  first PART
    
    // Full adder for PC + 4
    full_adder #(.WIDTH(32)) my_adderpc4 (
        .a(pcout),
        .b(32'd4),
        .cin(0),
        .sum(pc4),
        .cout()
    );
    
    // Instruction memory
    inst_mem #(
        .IMEM_DEPTH(32)
    ) im (
        .pc(pcout),
        .ins_out(ins)
    ); 
    
    // Program counter
    program_counter #(32) pc (
        .clk(clk),
        .reset(reset),
        .adrs(pcin), //imput
        .count(pcout)
    );

    n_bit_reg #(.n(32)) if_id_pc (
        .clk(clk),
        .reset_n(reset),
        .data_in(pcout),
        .data_out( current_pc_id)
        );

   n_bit_reg #(.n(32)) if_id_ins (
        .clk(clk),
        .reset_n(reset),
        .data_in(ins),
        .data_out(inst_id)
        );

    // DONE FIRST PART
    //  OUTPUT current_pc_id , inst_id
   

    //                                  second PART
    
    
     // immadete gen 
        imm_gen ig (
        .inst(inst_id),
        .imm(imm)
    );
    
       // Register file
    register_file #(
        .REGF_WIDTH(8),
        .REGF_DEPTH(32)
    ) rf (
        .clk(clk),
        .reset(reset),
        .RS(inst_id[19:15]),
        .RT(inst_id[24:20]),
        .out1(regout1),
        .out2(regout2),
        .RD(mem_web_imm),// latter RDWB inst_id[11:7]
        .Data_in(reg_datain),
        .enW(reg_write)// check sginal !!!!!!!!!!!!!!!!!!!!!!!!!
    );
    
   
    logic [31:0]ex_reg1, ex_reg2,ex_imm,ex_pc ;
    
        n_bit_reg #(.n(32)) id_ex_pc (
        .clk(clk),
        .reset_n(reset),
        .data_in(current_pc_id),
        .data_out(ex_pc) );
        
        
           n_bit_reg #(.n(32)) id_ex_reg1 (
        .clk(clk),
        .reset_n(reset),
        .data_in(regout1),
        .data_out(ex_reg1) );
        
        
          n_bit_reg #(.n(32)) id_ex_reg2 (
        .clk(clk),
        .reset_n(reset),
        .data_in(regout2),
        .data_out(ex_reg2) );
        
        
          n_bit_reg #(.n(32)) id_ex_imm (
        .clk(clk),
        .reset_n(reset),
        .data_in(imm),
        .data_out(ex_imm) );
        
        logic[4:0]rd_ex_imm;
           n_bit_reg #(.n(5)) id_ex_rd (
        .clk(clk),
        .reset_n(reset),
        .data_in(inst_id[11:7]),
        .data_out(rd_ex_imm) );
           
           
    // DONE seconde PART
    //  OUTPUT      rd_ex_imm ,ex_imm,ex_reg2,ex_reg1 ,ex_pc
        
        
    //                                  third PART
   

    // Full adder for PC + offset
    full_adder #(.WIDTH(32)) offset (
        .a(ex_pc),
        .b(ex_imm),
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
    
      // MUX for ALU input
    mux_2to1 #(.WIDTH(32)) alu_in (
        .in0(regout2),
        .in1(imm),
        .sel(alu_src),
        .out(aluin2)
    );
    
     n_bit_reg #(.n(32)) ex_mem_pc (
        .clk(clk),
        .reset_n(reset),
        .data_in(ex_pc),
        .data_out(mem_pc) );

    n_bit_reg #(.n(32)) ex_mem_alu (
        .clk(clk),
        .reset_n(reset),
        .data_in(alu_result),
        .data_out(ex_alu_result)/// fixing 
        );
        
     logic[4:0] ex_mem_imm;
   n_bit_reg #(.n(5)) ex_mem_rd (
        .clk(clk),
        .reset_n(reset),
        .data_in(rd_ex_imm),
        .data_out(ex_mem_imm) );
   
    // 2 mux and reg  thired PART  
    //  OUTPUT      ex_mem_imm ,ex_alu_result,ex_reg2,mem_pc
          

    //                                  fourth PART

 
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

    
 logic [31:0] M4Result;

    mux_4to1 #(
    .WIDTH(32)  // Width parameter set to 32
) MUXF4 (
    .in0(pc4),
    .in1(pcoffset),
    .in2(alu_result),
    .in3(web_read_data),
    .sel(mem_to_reg[1:0]),
    .out(M4Result)
);

mux_2to1 #(.WIDTH(32)) Reg_data_in (
        .in0(M4Result),
        .in1(imm),
        .sel(mem_to_reg[2]),
        .out(reg_datain)
    );
    
         n_bit_reg #(.n(32)) mem_web_pc (
        .clk(clk),
        .reset_n(reset),
        .data_in(ex_pc),
        .data_out(mem_pc) );
        
   n_bit_reg #(.n(5)) mem_web_rd (
        .clk(clk),
        .reset_n(reset),
        .data_in(ex_mem_imm),
        .data_out(mem_web_imm) );
    
    
   n_bit_reg #(.n(32)) mem_web_datamem (
        .clk(clk),
        .reset_n(reset),
        .data_in(read_data),
        .data_out(web_read_data)/// fixing 
        );
 
        
  





    
endmodule
