`include "define.v"
module 	EXE(
	// input
	clk,rst,
	E_RegDes,E_ALUSrcB,
	E_ALUcontrol,
	E_A,E_B,E_I,
	E_RT,E_RD,,
	E_op,E_func,E_shift,
	// output
	ALUResult,
	mrd,mb,
	Over,BE
	);
	input          E_RegDes,E_ALUSrcB,clk,rst;
	input  [3:0]   E_ALUcontrol;
	input  [31:0]  E_A,E_B,E_I;
	input  [4:0]   E_RT,E_RD;	
	input  [5:0]   E_op,E_func;
	input  [4:0]   E_shift;
	output [31:0]  ALUResult;
	output [4:0]   mrd;
	output [31:0]  mb;
	output         Over;
	output [3:0]   BE;
	
	wire isLB,isLBU,isLH,isLHU,isLW,isSB,isSH,isSW,isADD,isADDU;
	wire isSUB,isSUBU,isMULT,isMULTU,isDIV,isDIVU,isSLL,isSRL,isSRA,isSLLV;
	wire isSRLV,isSRAV,isAND,isOR,isXOR,isNOR,isADDI,isADDIU,isANDI,isORI;
	wire isXORI,isLUI,isSLT,isSLTI,isSLTIU,isSLTU,isBEQ,isBNE,isBLEZ,isBGTZ;
	wire isBLTZ,isBGEZ,isJ,isJAL,isJALR,isJR,isMFHI,isMFLO,isMTHI,isMTLO;
	assign isLB       = (E_op == `opcode_lb);
	assign isLBU      = (E_op == `opcode_lbu);
	assign isLH       = (E_op == `opcode_lh);
	assign isLHU      = (E_op == `opcode_lhu);
	assign isLW       = (E_op == `opcode_lw);
	assign isSB       = (E_op == `opcode_sb);
	assign isSH       = (E_op == `opcode_sh);
	assign isSW       = (E_op == `opcode_sw);
	assign isADD      = (E_op == `opcode_rtype) && (E_func == `funcode_add);
	assign isADDU     = (E_op == `opcode_rtype) && (E_func == `funcode_addu);
	assign isSUB      = (E_op == `opcode_rtype) && (E_func == `funcode_sub);
	assign isSUBU     = (E_op == `opcode_rtype) && (E_func == `funcode_subu);
	assign isMULT     = (E_op == `opcode_rtype) && (E_func == `funcode_mult);
	assign isMULTU    = (E_op == `opcode_rtype) && (E_func == `funcode_multu);
	assign isDIV      = (E_op == `opcode_rtype) && (E_func == `funcode_div);
	assign isDIVU     = (E_op == `opcode_rtype) && (E_func == `funcode_divu);
	assign isSLL      = (E_op == `opcode_rtype) && (E_func == `funcode_sll);
	assign isSRL      = (E_op == `opcode_rtype) && (E_func == `funcode_srl);
	assign isSRA      = (E_op == `opcode_rtype) && (E_func == `funcode_sra);
	assign isSLLV     = (E_op == `opcode_rtype) && (E_func == `funcode_sllv);
	assign isSRLV     = (E_op == `opcode_rtype) && (E_func == `funcode_srlv);
	assign isSRAV     = (E_op == `opcode_rtype) && (E_func == `funcode_srav);
	assign isAND      = (E_op == `opcode_rtype) && (E_func == `funcode_and);
	assign isOR       = (E_op == `opcode_rtype) && (E_func == `funcode_or);
	assign isXOR      = (E_op == `opcode_rtype) && (E_func == `funcode_xor);
	assign isNOR      = (E_op == `opcode_rtype) && (E_func == `funcode_nor);
	assign isADDI     = (E_op == `opcode_addi);
	assign isADDIU    = (E_op == `opcode_addiu);
	assign isANDI     = (E_op == `opcode_andi);
	assign isORI      = (E_op == `opcode_ori);
	assign isXORI     = (E_op == `opcode_xori);
	assign isLUI      = (E_op == `opcode_lui);
	assign isSLT      = (E_op == `opcode_rtype) && (E_func == `funcode_slt);
	assign isSLTI     = (E_op == `opcode_slti);
	assign isSLTIU    = (E_op == `opcode_sltiu);
	assign isSLTU     = (E_op == `opcode_rtype) && (E_func == `funcode_sltu);
	assign isBEQ      = (E_op == `opcode_beq);
	assign isBNE      = (E_op == `opcode_bne);
	assign isBLEZ     = (E_op == `opcode_blez);
	assign isBGTZ     = (E_op == `opcode_bgtz);
	assign isBLTZ     = (E_op == `opcode_bltz);
	assign isBGEZ     = (E_op == `opcode_bgez);
	assign isJ        = (E_op == `opcode_j);
	assign isJAL      = (E_op == `opcode_jal);
	assign isJALR     = (E_op == `opcode_rtype) && (E_func == `funcode_jalr);
	assign isJR       = (E_op == `opcode_rtype) && (E_func == `funcode_jr);
	assign isMFHI     = (E_op == `opcode_rtype) && (E_func == `funcode_mfhi);
	assign isMFLO     = (E_op == `opcode_rtype) && (E_func == `funcode_mflo);
	assign isMTHI     = (E_op == `opcode_rtype) && (E_func == `funcode_mthi);
	assign isMTLO     = (E_op == `opcode_rtype) && (E_func == `funcode_mtlo);
	
	
	wire [31:0] ALUOpA,ALUOpB;
	wire        mdWrite,mdStart,HiLo;
	wire [1:0]  mdOp;
	wire  [31:0] HI,LO;
	assign ALUOpA  = (isSLL|isSRA|isSRL)?{27'b0,E_shift}:E_A;
	assign ALUOpB  = E_ALUSrcB?E_B:E_I;
	assign mrd     = isJAL?5'b11111:E_RegDes?E_RD:E_RT;
	assign mb      = E_B;
	assign mdWrite = isMTHI|isMTLO;
	assign mdStart = isMULT|isMULTU|isDIV|isDIVU;
	assign HiLo    = isMTHI? 1 : 0;
	assign mdOp    = isMULT?  2'b00:
	                 isMULTU? 2'b01:
						  isDIV?   2'b10:
						           2'b11;
	ALU ALU(.C(ALUResult),.Op(E_ALUcontrol),.A(ALUOpA),.B(ALUOpB),.Over(Over));
	//md  MD (.D1(ALUOpA),.D2(ALUOpB),.HiLo(HiLo),.Op(mdOp),.Start(mdStart),.We(mdWrite),.Busy(Busy),.HI(HI),.LO(LO),.Clk(clk),.Rst(rst));
   ext_be EXT_BE (.A(ALUResult[1:0]),.b(isSB),.h(isSH),.be(BE));
endmodule
