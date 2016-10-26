module HarzardUnit(input  [4:0] rsD,rtD,rsE,rtE,WriteRegE,WriteRegM,WriteRegW,
                   input        RegWriteE,RegWriteM,RegWriteW,MemReadE,
						 input  [2:0] npc_sel,
						 output       stallF,stallD,flushD,
						 output [1:0] forwardBD,flushE,forwardAE,forwardBE,
						 output [2:0] forwardAD
						 );
	  
						  
	wire   B;
   assign B = (npc_sel==3'b001)|(npc_sel==3'b100);

	assign forwardAE = ((rsE!=5'b0)&&(rsE==WriteRegM)&&RegWriteM)? 2'b01:
							 ((rsE!=5'b0)&&(rsE==WriteRegW)&&RegWriteW)? 2'b10:
							                                             2'b00;
								
	assign forwardBE = ((rtE!=5'b0)&&(rtE==WriteRegM)&&RegWriteM)? 2'b01:
							 ((rtE!=5'b0)&&(rtE==WriteRegW)&&RegWriteW)? 2'b10:
							                                             2'b00;
							
	assign forwardAD = ((rsD!=5'b0)&&RegWriteM&& B &&(rsD==WriteRegM))?	 3'b001:
							 ((rsD!=5'b0)&&(rsD==WriteRegW)&&RegWriteW)||				
							 ((rsD!=5'b0)&&RegWriteW&& B &&(rsD==WriteRegW))?	 3'b010:
							 ((npc_sel==3'b011)&&RegWriteE&&(rsD==WriteRegE))?	 3'b011:
							 ((npc_sel==3'b011)&&RegWriteM&&(rsD==WriteRegM))?	 3'b100:
							 ((npc_sel==3'b011)&&RegWriteW&&(rsD==WriteRegW))?	 3'b101:
							                                                    3'b000;
							
	assign forwardBD = ((rtD!=5'b0)&&RegWriteM&& B &&(rtD==WriteRegM))?	2'b01:
							 ((rtD!=5'b0)&&(rtD==WriteRegW)&&RegWriteW)||				
							 ((rtD!=5'b0)&&RegWriteW&& B &&(rtD==WriteRegW))?	2'b10:
							                                                   2'b00;
							
	assign stallF    = (RegWriteE&& B &&((rsD==WriteRegE)||(rtD==WriteRegE)))||	
						    ((rtE!=5'b0)&&MemReadE&&(rsD==rtE||rtD==rtE))?					1'b0:	
						                                                               1'b1;
					
	assign stallD    = stallF;
						
	assign flushE    = ~stallF;
							
	assign flushD=1'b0;

endmodule
