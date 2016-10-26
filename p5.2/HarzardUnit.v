`include "define.v"
module HarzardUnit(input  [4:0] rsD,rtD,rsE,rtE,WriteRegE,WriteRegM,WriteRegW,
                   input        RegWriteE,RegWriteM,RegWriteW,MemReadE,MemReadM,mdstartE,Busy,
						 input  [2:0] npc_sel,
						 output       stallF,stallD,flushD,flushE,
						 output [1:0] forwardAD,forwardBD,forwardAE,forwardBE
						 );
				  
	wire B	=	npc_sel==`B;
	wire JR  =	npc_sel==`JR;

	assign forwardAE= ((rsE!=5'b0)&&(rsE==WriteRegM)&&RegWriteM)? 2'b01:
							((rsE!=5'b0)&&(rsE==WriteRegW)&&RegWriteW)? 2'b10:
							                                            2'b00;
								
	assign forwardBE= ((rtE!=5'b0)&&(rtE==WriteRegM)&&RegWriteM)? 2'b01:
							((rtE!=5'b0)&&(rtE==WriteRegW)&&RegWriteW)? 2'b10:
							                                            2'b00;
							
	assign forwardAD= ((rsD!=5'b0)&&RegWriteM&& (B||JR) &&(rsD==WriteRegM))? 2'b01:
							((rsD!=5'b0)&&(rsD==WriteRegW)&&RegWriteW)||	
							((rsD!=5'b0)&&RegWriteW&& (B||JR) &&(rsD==WriteRegW))? 2'b10:
							                                                       2'b00;
							
	assign forwardBD= ((rtD!=5'b0)&&RegWriteM&& B &&(rtD==WriteRegM))? 2'b01:
							((rtD!=5'b0)&&(rtD==WriteRegW)&&RegWriteW)||	
							((rtD!=5'b0)&&RegWriteW&& B &&(rtD==WriteRegW))? 2'b10:
							                                                 2'b00;
							
	assign stallF= (RegWriteE&& (B||JR) &&((rsD==WriteRegE)||(rtD==WriteRegE)))||	
						((rtE!=5'b0)&&MemReadE&&(rsD==rtE||rtD==rtE))||		
						((rsD!=5'b0)&&MemReadM&&(rsD==WriteRegM||rtD==WriteRegM))||
							 ((mdstartE==1||Busy==1)&&npc_sel==3'b100)?                 1'b0:
						                                                               1'b1;
					
	assign stallD= stallF;
	
	assign flushE= ~stallF;
							
	assign flushD=1'b0;

endmodule
