`include "define.v"
module controller(input[5:0] op,func,
                  output[3:0] ALUcontrol,
                  output ReadMem,WriteReg,MemToReg,WriteMem,RegDes,ALUSrcB,PcToReg,ext_bh,
						output[1:0] ext_op);

	wire isLB,isLBU,isLH,isLHU,isLW,isSB,isSH,isSW,isADD,isADDU;
	wire isSUB,isSUBU,isMULT,isMULTU,isDIV,isDIVU,isSLL,isSRL,isSRA,isSLLV;
	wire isSRLV,isSRAV,isAND,isOR,isXOR,isNOR,isADDI,isADDIU,isANDI,isORI;
	wire isXORI,isLUI,isSLT,isSLTI,isSLTIU,isSLTU,isBEQ,isBNE,isBLEZ,isBGTZ;
	wire isBLTZ,isBGEZ,isJ,isJAL,isJALR,isJR,isMFHI,isMFLO,isMTHI,isMTLO;
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
	assign isBLEZ     = (op == `opcode_blez);
	assign isBGTZ     = (op == `opcode_bgtz);
	assign isBLTZ     = (op == `opcode_bltz);
	assign isBGEZ     = (op == `opcode_bgez);
	assign isJ        = (op == `opcode_j);
	assign isJAL      = (op == `opcode_jal);
	assign isJALR     = (op == `opcode_rtype) && (func == `funcode_jalr);
	assign isJR       = (op == `opcode_rtype) && (func == `funcode_jr);
	assign isMFHI     = (op == `opcode_rtype) && (func == `funcode_mfhi);
	assign isMFLO     = (op == `opcode_rtype) && (func == `funcode_mflo);
	assign isMTHI     = (op == `opcode_rtype) && (func == `funcode_mthi);
	assign isMTLO     = (op == `opcode_rtype) && (func == `funcode_mtlo);
	
	assign ext_op = isLB?  2'b00:
	                isLBU? 2'b01:
						 isLH?  2'b10:
						 2'b11;
	assign ext_bh = (isLB|isLBU|isLH|isLHU)?1:0;
	
	assign ALUcontrol[0] = isADD | isADDI | //add
	                       isSUB | //sub
								  isOR  | isORI  |  //or
								  isNOR | //nor
								  isLUI | //lui
								  isSLT |isSLTI | //slt
								  isSLTU|isSLTIU //sltu
								  ;
	assign ALUcontrol[1] = isADDU | isADDIU | isLW | isLB | isLH | isSB | isSH | isSW |//addu
	                       isSUB | //sub
								  isXOR | //xor
								  isNOR | //nor
								  isSLL | isSLLV| //sll
								  isSRLV|isSRL | //srl
								  isSLT |isSLTI //slt
								  ;
	assign ALUcontrol[2] = isSUBU | isBEQ | isBNE | //subu
	                       isOR  | isORI  |  //or
								  isXOR | //xor
								  isNOR | //nor
								  isSRLV|isSRL| //srl
								  isSRA |isSRAV | //sra
								  isSLTU|isSLTIU //sltu
								  ;
	assign ALUcontrol[3] = isAND | isANDI | //and
	                       isLUI | //lui
								  isSLLV| isSLL | //sll
								  isSRLV|isSRL |//srl
								  isSRA |isSRAV |//sra
								  isSLT |isSLTI |//slt
								  isSLTU|isSLTIU //sltu
								  ;
	
	assign ReadMem = 0;
	assign WriteReg = isLB|isLH|isLW|isLBU|isLHU|isADD|isADDU|
	                  isSUB|isSUBU|isSLL|isSRL|isSRA|isSLLV|
							isSRLV|isSRAV|isAND|isOR|isXOR|isNOR|isADDI|isADDIU|isANDI|isORI|
							isXORI|isLUI|isSLT|isSLTI|isSLTIU|isSLTU|
							isJAL|isJALR;
	assign MemToReg = isLB|isLH|isLW|isLBU|isLHU;
   assign PcToReg = isJAL|isJALR;	
	assign WriteMem = isSW|isSB|isSH;
	assign RegDes = (op == `opcode_rtype);
	assign ALUSrcB = ~(isADDI|isANDI|isORI|isLB|isLH|isLW|isLBU|isLHU|isSW|isSB|isSH|isLUI|isXORI|isSLTI|isSLTIU);
endmodule
