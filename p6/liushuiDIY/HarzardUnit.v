module HarzardUnit(input  [4:0] rsD,rtD,rsE,rtE,WriteRegE,WriteRegM,WriteRegW,
                   input        RegWriteE,RegWriteM,RegWriteW,MemReadE,MemReadM,
						 input  [2:0] npc_sel,
						 output       stallF,stallD,flushD,forwardAD,forwardBD,flushE,
						 output [1:0] forwardAE,forwardBE
						 );
	
	parameter        R  =  3'b000,           // R_type
                    BEQ=  3'b001,           // BEQ_type
                    J  =  3'b010,           // J_type
                    JR =  3'b011,           // JR_type
                    BNE=  3'b100;           // BNE_type    
						  
	wire B	=	npc_sel==BEQ||npc_sel==BNE;
	wire JR_e=	npc_sel==JR;

	assign forwardAE=
							((rsE!=5'b0)&&(rsE==WriteRegM)&&RegWriteM)?2'b01:			//Rָ���һ��
							((rsE!=5'b0)&&(rsE==WriteRegW)&&RegWriteW)?2'b10:			//Rָ��Ķ���
							2'b00;
								
	assign forwardBE=
							((rtE!=5'b0)&&(rtE==WriteRegM)&&RegWriteM)?2'b01:			//Rָ���һ��
							((rtE!=5'b0)&&(rtE==WriteRegW)&&RegWriteW)?2'b10:			//Rָ��Ķ���
							2'b00;
							
	assign forwardAD= ((rsD!=5'b0)&&RegWriteM&& (B||JR_e) &&(rsD==WriteRegM))?			2'b01:	//B��JRָ��Ķ���
							((rsD!=5'b0)&&(rsD==WriteRegW)&&RegWriteW)||										//Rָ�������
							((rsD!=5'b0)&&RegWriteW&& (B||JR_e) &&(rsD==WriteRegW))?			2'b10:	//B��JRָ�������
							2'b00;
							
	assign forwardBD= ((rtD!=5'b0)&&RegWriteM&& B &&(rtD==WriteRegM))?			2'b01:			//Bָ��Ķ���
							((rtD!=5'b0)&&(rtD==WriteRegW)&&RegWriteW)||										//Rָ�������
							((rtD!=5'b0)&&RegWriteW&& B &&(rtD==WriteRegW))?			2'b10:			//Bָ�������
							2'b00;
							
	assign stallF= (RegWriteE&& (B||JR_e) &&((rsD==WriteRegE)||(rtD==WriteRegE)))||				//B��JRָ���һ��
						((rtE!=5'b0)&&MemReadE&&(rsD==rtE||rtD==rtE))||										//Lָ���һ��
						((rsD!=5'b0)&&MemReadM&&(rsD==WriteRegM||rtD==WriteRegM))?	1'b0:				//Lָ���α���ף���B��JR��أ�
						1'b1;
					
	assign stallD= stallF;
	
	assign flushE= ~stallF;
							
	assign flushD=1'b0;

endmodule
