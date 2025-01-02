`timescale 1ns / 1ps

module forword_unit(
    input logic [4:0] rs1, rs2,           // Source registers from EX stage
    input logic [4:0] rd_mem, rd_wb,     // Destination registers in MEM and WB stages
    input logic regw_mem, regw_wb,       // Write-back control signals for MEM and WB
    output logic [1:0] forwordA, forwordB // Forwarding control signals
);
    
   always_comb begin
    // Default: No forwarding
//    forwordA = 2'b00;
//    forwordB = 2'b00;

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
        
        else begin   
        forwordA = 2'b00;
        forwordB = 2'b00;
        end 
end

    
    
    
endmodule
