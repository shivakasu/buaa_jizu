`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:41:17 11/23/2015 
// Design Name: 
// Module Name:    NPC 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module NPC(pc , npc_sel , zero , imm , rs ,  npc , BoJ
    );
	 input  [25:0]   imm        ;           // clock and reset
    input  [31:0]   pc          ;           // next pc input
    input  [31:0]   rs          ;           // data in the $rs
    input  [2:0]    npc_sel     ;           // instr type
    input           zero        ;           // ctrl the operation
    output [31:0]   npc         ;           // ouput pc 
    
	 output BoJ;
	 
    wire   [31:0]   npc                     ;
    wire   [15:0]   offset                        ;
	 
	 reg [31:0] pc_4,pc_8;
	 
    assign  offset  = imm[15:0]                  ;           // set the offset   
	 
	 always@(*)
	 begin
		pc_4    = pc + 4                      ;           // ouput pc+4 
		pc_8	  = pc + 8							;
	 end
	 
    parameter       R  =  3'b000,           // R_type
                    B  =  3'b001,           // B_type
                    J  =  3'b010,           // J_type
                    JR =  3'b011;           // JR_type
    
    assign  npc     = (npc_sel == R)         ?  pc_4                      :
                      ((npc_sel==B)&&zero)	?  pc_4 + {{14{offset[15]}},offset,2'b0}:
                      (npc_sel == J)         ?  {pc[31:28],imm,2'b0}     :
                      (npc_sel == JR)        ?  rs                        :
                                                pc_8                      ;
														
	assign BoJ	=	(((npc_sel==B)&&zero)||(npc_sel == J)||(npc_sel == JR))?1'b1:1'b0;
endmodule
