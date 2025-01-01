`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/01/2025 04:00:44 PM
// Design Name: 
// Module Name: forword unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////////
//forword_unit forwarding_unit_inst (
//    .rs1(rs1),                // Connect source register 1
//    .rs2(rs2),                // Connect source register 2
//    .rd_mem(rd_mem),          // Connect destination register in MEM stage
//    .rd_wb(rd_wb),            // Connect destination register in WB stage
//    .regw_mem(regw_mem),      // Connect write-back signal for MEM stage
//    .regw_wb(regw_wb),        // Connect write-back signal for WB stage
//    .forwordA(forwordA),      // Output forwarding control for rs1
//    .forwordB(forwordB)       // Output forwarding control for rs2
//);

module forword_unit(
    input logic [4:0] rs1, rs2,           // Source registers from EX stage
    input logic [4:0] rd_mem, rd_wb,     // Destination registers in MEM and WB stages
    input logic regw_mem, regw_wb,       // Write-back control signals for MEM and WB
    output logic [1:0] forwordA, forwordB // Forwarding control signals
);
    
   always_comb begin
    // Default: No forwarding
    forwordA = 2'b00;
    forwordB = 2'b00;

    // EX Hazard: Forward from MEM stage
    if (regw_mem && (rd_mem != 0) && (rd_mem == rs1))
        forwordA = 2'b10;
    if (regw_mem && (rd_mem != 0) && (rd_mem == rs2))
        forwordB = 2'b10;

    // MEM Hazard: Forward from WB stage
    if (regw_wb && (rd_wb != 0) &&        !(regw_mem && (rd_mem != 0) && (rd_mem == rs1))       && (rd_wb == rs1))
        forwordA = 2'b01;
    if (regw_wb && (rd_wb != 0) &&       !(regw_mem && (rd_mem != 0) && (rd_mem == rs2))     &&  (rd_wb == rs2))
        forwordB = 2'b01;
end

    
    
    
endmodule
