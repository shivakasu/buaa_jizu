`include "define.v"
module NPC(input  [31:0] pc,rs,
           input  [2:0]  npc_sel,
			  input         zero,
			  input  [25:0] imm,
			  output [31:0] npc,
			  output        Branch
			  );

    wire   [15:0]   offset;
	 wire   [31:0]   pc_4,pc_8;
    assign  offset  = imm[15:0];  
	 assign  pc_4    = pc + 4;
    assign  pc_8	  = pc + 8;
    assign  npc     = (npc_sel == `R)?        pc_4:
                      ((npc_sel==`B)&&zero)?  pc_4 + {{14{offset[15]}},offset,2'b0}:
                      (npc_sel == `J)?        {pc[31:28],imm,2'b0}:
                      (npc_sel == `JR)?       rs:
                                              pc_8;
	assign Branch	  = ((npc_sel==`B)&&zero)||(npc_sel == `J)||(npc_sel == `JR);
endmodule
