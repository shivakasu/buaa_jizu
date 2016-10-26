`include "define.v"
module controller(input[5:0] op,func,
                  output[3:0] ALUcontrol,
                  output WritePC,WriteIR,ReadMem,WriteReg,MemToReg,WriteMem,RegDes,ALUSrcB,PcToReg);

	wire isADDU,isSUBU,isAND,isOR,isSLT,isLW,isSW,isADDI,isANDI,isORI,isLUI,isJAL;
	assign isADDU = (op == `opcode_rtype) && (func == `funcode_addu);
	assign isSUBU = (op == `opcode_rtype) && (func == `funcode_subu);
	assign isAND = (op == `opcode_rtype) && (func == `funcode_and);
	assign isOR  = (op == `opcode_rtype) && (func == `funcode_or);
	assign isSLT = (op == `opcode_rtype) && (func == `funcode_slt);
	assign isLW = (op == `opcode_lw);
	assign isSW = (op == `opcode_sw);
	assign isADDI = (op == `opcode_addi);
	assign isANDI = (op == `opcode_andi);
	assign isORI = (op == `opcode_ori);
	assign isLUI = (op == `opcode_lui);
	assign isJAL = (op == `opcode_jal);
	
	assign ALUcontrol[0] = isADDU | isAND | isSLT | isSW | isANDI | isLUI;
	assign ALUcontrol[1] = isSUBU | isAND | isLW | isSW | isORI | isLUI;
	assign ALUcontrol[2] = isOR | isSLT | isLW | isSW | isLUI;
	assign ALUcontrol[3] = isADDI | isANDI | isORI | isLUI;
	
	assign WritePC = 1;
	assign WriteIR = 1;
	assign ReadMem = 0;
	assign WriteReg = isADDU | isSUBU | isAND | isOR | isSLT | isLW | isADDI | isANDI | isORI | isLUI | isJAL;
	assign MemToReg = isLW;
   assign PcToReg = isJAL;	
	assign WriteMem = isSW;
	assign RegDes = (op == `opcode_rtype);
	assign ALUSrcB = ~(isADDI|isANDI|isORI|isLW|isSW|isLUI);
endmodule
