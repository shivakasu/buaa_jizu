`include "define.v"
module Control(input  [31:0] instrD,
               output        regwriteD,memwriteD,memreadD,alusrcD,ss_chD,isSB,isSH,Jwrite,mdrsel,isMADD,isMFC0,isMTC0,
					output [1:0]  memtoregD,regdstD,ext_op,
					output [3:0]  alu_ctrD,
					output [2:0]  npc_sel,cmp_op,ext_sh,
					output        mdstart,mdwrite,mdHILO,mdread,
					output [1:0]  mdop
					);

	wire   [4:0]	RtAddr, RdAddr, RsAddr,shift;
	wire   [15:0]	immediate;
   wire   [5:0]   op,func;
	
 	assign op			= instrD[`opfield];
	assign RtAddr		= instrD[`rt];
	assign RdAddr		= instrD[`rd];
	assign RsAddr		= instrD[`rs];
	assign func			= instrD[`funct];
	assign immediate	= instrD[`immediate];
	assign shift      = instrD[`shift];
	
	wire   isLB,isLBU,isLH,isLHU,isLW,isSB,isSH,isSW,isADD,isADDU;
	wire   isSUB,isSUBU,isMULT,isMULTU,isDIV,isDIVU,isSLL,isSRL,isSRA,isSLLV;
	wire   isSRLV,isSRAV,isAND,isOR,isXOR,isNOR,isADDI,isADDIU,isANDI,isORI;
	wire   isXORI,isLUI,isSLT,isSLTI,isSLTIU,isSLTU,isBEQ,isBNE,isBLEZ,isBGTZ;
	wire   isBLTZ,isBGEZ,isJ,isJAL,isJALR,isJR,isMFHI,isMFLO,isMTHI,isMTLO;
	wire   isMFC0,isMTC0,isERET,isMADD;
	
	assign isLB       = (op == `opcode_lb);
	assign isLBU      = (op == `opcode_lbu);
	assign isLH       = (op == `opcode_lh);
	assign isLHU      = (op == `opcode_lhu);
	assign isLW       = (op == `opcode_lw);
	assign isSB       = (op == `opcode_sb);
	assign isSH       = (op == `opcode_sh);
	assign isSW       = (op == `opcode_sw);
	assign isADD      = (op == `opcode_rtype) && (func == `funcode_add);
	assign isADDU     = (op == `opcode_rtype) && (func == `funcode_addu);
	assign isSUB      = (op == `opcode_rtype) && (func == `funcode_sub);
	assign isSUBU     = (op == `opcode_rtype) && (func == `funcode_subu);
	assign isMULT     = (op == `opcode_rtype) && (func == `funcode_mult);
	assign isMULTU    = (op == `opcode_rtype) && (func == `funcode_multu);
	assign isDIV      = (op == `opcode_rtype) && (func == `funcode_div);
	assign isDIVU     = (op == `opcode_rtype) && (func == `funcode_divu);
	assign isSLL      = (op == `opcode_rtype) && (func == `funcode_sll);
	assign isSRL      = (op == `opcode_rtype) && (func == `funcode_srl);
	assign isSRA      = (op == `opcode_rtype) && (func == `funcode_sra);
	assign isSLLV     = (op == `opcode_rtype) && (func == `funcode_sllv);
	assign isSRLV     = (op == `opcode_rtype) && (func == `funcode_srlv);
	assign isSRAV     = (op == `opcode_rtype) && (func == `funcode_srav);
	assign isAND      = (op == `opcode_rtype) && (func == `funcode_and);
	assign isOR       = (op == `opcode_rtype) && (func == `funcode_or);
	assign isXOR      = (op == `opcode_rtype) && (func == `funcode_xor);
	assign isNOR      = (op == `opcode_rtype) && (func == `funcode_nor);
	assign isADDI     = (op == `opcode_addi);
	assign isADDIU    = (op == `opcode_addiu);
	assign isANDI     = (op == `opcode_andi);
	assign isORI      = (op == `opcode_ori);
	assign isXORI     = (op == `opcode_xori);
	assign isLUI      = (op == `opcode_lui);
	assign isSLT      = (op == `opcode_rtype) && (func == `funcode_slt);
	assign isSLTI     = (op == `opcode_slti);
	assign isSLTIU    = (op == `opcode_sltiu);
	assign isSLTU     = (op == `opcode_rtype) && (func == `funcode_sltu);
	assign isBEQ      = (op == `opcode_beq);
	assign isBNE      = (op == `opcode_bne);
	assign isBGEZ     = (op == `opcode_bgez)  && (RtAddr == 5'b00001);
	assign isBGTZ     = (op == `opcode_bgtz);
	assign isBLEZ     = (op == `opcode_blez);
	assign isBLTZ     = (op == `opcode_bltz)  && (RtAddr == 5'b00000);
	assign isJ        = (op == `opcode_j);
	assign isJAL      = (op == `opcode_jal);
	assign isJALR     = (op == `opcode_rtype) && (func == `funcode_jalr);
	assign isJR       = (op == `opcode_rtype) && (func == `funcode_jr);
	assign isMFHI     = (op == `opcode_rtype) && (func == `funcode_mfhi);
	assign isMFLO     = (op == `opcode_rtype) && (func == `funcode_mflo);
	assign isMTHI     = (op == `opcode_rtype) && (func == `funcode_mthi);
	assign isMTLO     = (op == `opcode_rtype) && (func == `funcode_mtlo);
	assign isMFC0     = (op == `opcodec0) && (RsAddr == `mfc0s);
	assign isMTC0     = (op == `opcodec0) && (RsAddr == `mtc0s);
	assign isERET     = (op == `opcodec0) && (func == `erets);
	assign isMADD     = (op == 6'b011100) && (func == 6'b000000);



   wire   i,b,s,l,md;
   assign i = isADDI | isADDIU | isSLTI | isSLTIU | isORI | isLUI | isANDI | isXORI;
   assign b	= isBEQ|isBNE|isBGTZ|isBGEZ|isBLEZ|isBLTZ;                                                            
   assign s = isSW|isSB|isSH;               
   assign l = isLB|isLH|isLW|isLBU|isLHU;
	assign md= isMULT|isMULTU|isDIV|isDIVU|isMFHI|isMFLO|isMTHI|isMTLO|isMADD;
	 

	assign regdstD    = isJAL?     2'b10:
						     (i|s|l)?   2'b00:
						                2'b01;	
											 
	assign alusrcD    = i | l | s;			
	
	assign ext_sh     = isLB?  3'b010:
	                    isLBU? 3'b001:
						     isLH?  3'b100:
						     isLHU? 3'b011:
                              3'b000;   

	
	assign memtoregD  = (isJAL|isJALR)? 2'b10:
						      l?             2'b01:
						                     2'b00;
													 
	assign regwriteD  = ~(s|isJ|isJR|b|md|isMTC0);
	
   assign npc_sel	   = b?             3'b001:
							  (isJ|isJAL)?   3'b010:
							  (isJR|isJALR)? 3'b011:
							  md?            3'b100:
											     3'b000;
							

	
	assign cmp_op	   = isBEQ?  3'b000:
	                    isBNE?  3'b001:
						     isBGEZ? 3'b010:
						     isBGTZ? 3'b011:
						     isBLEZ? 3'b100:
						             3'b101;
							
	assign memwriteD  = s;
							
	assign memreadD   = l;
							
	assign ext_op     = isLUI?          2'b10:
						     (isORI|isXORI)? 2'b00:
						                     2'b01;
						
	
	assign alu_ctrD[0] = isADD | isADDI | //add
	                     isSUB | //sub
								isOR  | isORI  |  //or
								isNOR | //nor
								isLUI | //lui
								isSLT |isSLTI | //slt
								isSLTU|isSLTIU //sltu
								;
	assign alu_ctrD[1] = isADDU | isADDIU | isLW | isLB | isLH | isSB | isSH | isSW | isLBU | isLHU|//addu
	                     isSUB | //sub
								isXOR | isXORI|//xor
								isNOR | //nor
								isSLL | isSLLV| //sll
								isSRLV|isSRL | //srl
								isSLT |isSLTI //slt
								;
	assign alu_ctrD[2] = isSUBU | isBEQ | isBNE | //subu
	                     isOR  | isORI  |  //or
								isXOR | isXORI|//xor
								isNOR | //nor
								isSRLV|isSRL| //srl
								isSRA |isSRAV | //sra
								isSLTU|isSLTIU //sltu
								;
	assign alu_ctrD[3] = isAND | isANDI | //and
	                     isLUI | //lui
								isSLLV| isSLL | //sll
								isSRLV|isSRL |//srl
								isSRA |isSRAV |//sra
								isSLT |isSLTI |//slt
								isSLTU|isSLTIU //sltu
								;
	assign ss_chD      = isSLL|isSRL|isSRA;
	
	assign Jwrite      = isJAL|isJALR;
	
	assign mdstart     = isMULT|isMULTU|isDIV|isDIVU|isMADD;
	assign mdwrite     = isMTHI|isMTLO;
	assign mdHILO      = isMTHI? 1'b1: 1'b0;
	assign mdread      = isMFLO;
	assign mdrsel      = isMFHI|isMFLO;
	assign mdop        = isMULTU?  2'b00:
	                     (isMULT|isMADD)?   2'b01:
								isDIVU?   2'b10:
								          2'b11;
endmodule
