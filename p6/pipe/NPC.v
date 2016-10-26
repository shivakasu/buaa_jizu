module NPC(input  [31:0] pc,rs,
           input  [2:0]  npc_sel, 
			  input         zero, 
			  input  [25:0] imm,
			  output [31:0] npc,
			  output        BoJ
			  );
   
    wire   [31:0]   npc;
    wire   [15:0]   offset;
	 reg    [31:0]   pc_4;
    assign  offset  = imm[15:0]; 
	 always@(*)
		pc_4 = pc + 4;
    
    parameter  R    =  3'b000,
               B    =  3'b001,
               J    =  3'b010,
               JR   =  3'b011;
    
    assign     npc  = (npc_sel == R)        ?  pc_4:
                      ((npc_sel==B)&&zero)  ?  pc_4 + {{14{offset[15]}},offset,2'b0}:
                      (npc_sel == J)        ?  {pc[31:28],imm,2'b0}:
                      (npc_sel == JR)       ?  rs:
                                                pc_4;
														
	 assign     BoJ  = ~(npc_sel==R);
endmodule
