`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:12:52 11/23/2015 
// Design Name: 
// Module Name:    HarzardUnit 
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
module HarzardUnit(rsD,rtD,rsE,rtE,RegWriteE,RegWriteM,RegWriteW,WriteRegE,WriteRegM,WriteRegW,MemReadE,
npc_sel,stallF,stallD,flushD,forwardAD,forwardBD,flushE,forwardAE,forwardBE
    );
	input [4:0] rsD,rtD,rsE,rtE,WriteRegE,WriteRegM,WriteRegW;
	input RegWriteE,RegWriteM,RegWriteW;
	input MemReadE;
	input [2:0] npc_sel;
	output stallF,stallD,flushD,forwardAD,forwardBD,flushE;
	output [1:0] forwardAE,forwardBE;
	wire stallF,stallD,flushE;
	wire [2:0] forwardAD;
	wire [1:0] forwardBD;
	wire [1:0] forwardAE,forwardBE;
	
	parameter        R  =  3'b000,           // R_type
                    BEQ=  3'b001,           // BEQ_type
                    J  =  3'b010,           // J_type
                    JR =  3'b011,           // JR_type
                    BNE=  3'b100;           // BNE_type    
						  
	wire B	=	npc_sel==BEQ||npc_sel==BNE;

	assign forwardAE=
							((rsE!=5'b0)&&(rsE==WriteRegM)&&RegWriteM)?2'b01:			//Rָ���һ��
							((rsE!=5'b0)&&(rsE==WriteRegW)&&RegWriteW)?2'b10:			//Rָ��Ķ���
							2'b00;
								
	assign forwardBE=
							((rtE!=5'b0)&&(rtE==WriteRegM)&&RegWriteM)?2'b01:			//Rָ���һ��
							((rtE!=5'b0)&&(rtE==WriteRegW)&&RegWriteW)?2'b10:			//Rָ��Ķ���
							2'b00;
							
	assign forwardAD= ((rsD!=5'b0)&&RegWriteM&& B &&(rsD==WriteRegM))?			3'b001:			//Bָ��Ķ���
							((rsD!=5'b0)&&(rsD==WriteRegW)&&RegWriteW)||										//Rָ�������
							((rsD!=5'b0)&&RegWriteW&& B &&(rsD==WriteRegW))?			3'b010:			//Bָ�������
							((npc_sel==JR)&&RegWriteE&&(rsD==WriteRegE))?				3'b011:			//JRָ���һ��
							((npc_sel==JR)&&RegWriteM&&(rsD==WriteRegM))?				3'b100:			//JRָ��Ķ���
							((npc_sel==JR)&&RegWriteW&&(rsD==WriteRegW))?				3'b101:			//JRָ�������
							3'b000;
							
	assign forwardBD= ((rtD!=5'b0)&&RegWriteM&& B &&(rtD==WriteRegM))?			2'b01:			//Bָ��Ķ���
							((rtD!=5'b0)&&(rtD==WriteRegW)&&RegWriteW)||										//Rָ�������
							((rtD!=5'b0)&&RegWriteW&& B &&(rtD==WriteRegW))?			2'b10:			//Bָ�������
							2'b00;
							
	assign stallF= (RegWriteE&& B &&((rsD==WriteRegE)||(rtD==WriteRegE)))||							//Bָ���һ��
						((rtE!=5'b0)&&MemReadE&&(rsD==rtE||rtD==rtE))?					1'b0:				//Lָ���һ��
						1'b1;
					
	assign stallD= (RegWriteE&& B &&((rsD==WriteRegE)||(rtD==WriteRegE)))||							//Bָ���һ��
						((rtE!=5'b0)&&MemReadE&&(rsD==rtE||rtD==rtE))?					1'b0:				//Lָ���һ��
						1'b1;
						
	assign flushE= (RegWriteE&& B &&((rsD==WriteRegE)||(rtD==WriteRegE)))||							//Bָ���һ��
						((rtE!=5'b0)&&MemReadE&&(rsD==rtE||rtD==rtE))?					1'b1:				//Lָ���һ��
						1'b0;
							
	assign flushD=1'b0;

endmodule
