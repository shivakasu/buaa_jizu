`include "define.v"
module ID(//input
			clk,rst,D_IR,D_NPC,
			E_WriteReg,
			E_RD,
			E_Result,
			M_WriteReg,
			M_RD,
			M_Result,
			W_WriteReg,W_RegWriteAddr,W_RegWriteData,W_RegWriteData2,
			//output
			WritePC,Branch,WriteIR,ReadMem,WriteReg,MemToReg,WriteMem,PcToReg,
			ALUcontrol,RegDes,ALUSrcB,FWDB,FWDA,
			BranchAddr,
			ea,eb,ei,ert,erd);
input clk,rst;			
input [31:0] D_IR,D_NPC;
input E_WriteReg,M_WriteReg,W_WriteReg;
input [4:0] E_RD,M_RD,W_RegWriteAddr;
input [31:0] E_Result,M_Result,W_RegWriteData;
input [63:0] W_RegWriteData2;
output 	WritePC,Branch,WriteIR,ReadMem,WriteReg,MemToReg,WriteMem,RegDes,ALUSrcB,PcToReg;
output [4:0] ALUcontrol;
output [1:0] FWDA,FWDB;
output [31:0] BranchAddr;
output [31:0] ea,eb,ei;
output [4:0] ert,erd;
wire [31:0] RegA,RegB;

	wire [5:0]	op,func;
	wire [4:0]	RtAddr, RdAddr, RsAddr;
	wire [15:0]	immediate;
   
	assign op			= D_IR[`opfield];
	assign RtAddr		= D_IR[`rt];
	assign RdAddr		= D_IR[`rd];
	assign RsAddr		= D_IR[`rs];
	assign func			= D_IR[`funct];
	assign immediate	= D_IR[`immediate];
	
	assign ert = RtAddr;
	assign erd = RdAddr;
	assign ei = {{16{immediate[15]}},immediate[15:0]};// the sign extent of immidiate number 
	
	controller ctrl(.op(op),.func(func),.ALUcontrol(ALUcontrol),.WritePC(WritePC),
	                .WriteIR(WriteIR),.ReadMem(ReadMem),.WriteReg(WriteReg),
						 .MemToReg(MemToReg),.WriteMem(WriteMem),.RegDes(RegDes),.ALUSrcB(ALUSrcB),.PcToReg(PcToReg));
	
	RegFile RegFile(.RsData(RegA),.rst(rst), .RtData(RegB), .clk(clk), .RegWriteData(W_RegWriteData), .RegWriteData2(W_RegWriteData2), .RegWriteAddr(W_RegWriteAddr), .RegWriteEn(W_WriteReg), .RsAddr(RsAddr), .RtAddr(RtAddr));
		
	wire isBEQ, isBNE, isJ, isJR, isBGEZ, isBGTZ, isBLEZ, isBLTZ;
	assign isBEQ  = (op == `opcode_beq);
	assign isBNE  = (op == `opcode_bne);
	assign isJ    = (op == `opcode_j) || (op == `opcode_jal);
	assign isJR   = (op == `opcode_jr) && (func == `funcode_jr);
	assign isBGEZ = (op == `opcode_bgez);
	assign isBGTZ = (op == `opcode_bgtz);
	assign isBLEZ = (op == `opcode_blez);
	assign isBLTZ = (op == `opcode_bltz);
	
	hazard_FWD hazard_FWD(.rst(rst),.E_WriteReg(E_WriteReg),.W_WriteReg(W_WriteReg),.M_WriteReg(M_WriteReg),
			              .E_RD(E_RD),.M_RD(M_RD),.W_RegWriteAddr(W_RegWriteAddr),.RsAddr(RsAddr),.RtAddr(RtAddr),
							  .FWDA(FWDA),.FWDB(FWDB));
	
	assign ea = FWDA[0]?(FWDA[1]?W_RegWriteData:E_Result):(FWDA[1]?M_Result:RegA);
	assign eb = FWDB[0]?(FWDB[1]?W_RegWriteData:E_Result):(FWDB[1]?M_Result:RegB);
	assign ALUZero = (ea == eb);
	assign ALUBgez = (RegA[31] == 0 );//bug!!!
	assign ALUBgtz = (RegA[31] == 0 ) & (RegA != 32'b0);//bug!!!
	assign ALUBlez = (RegA[31] == 1 ) | (RegA == 32'b0);//bug!!!
	assign ALUBltz = (RegA[31] == 1 );//bug!!!
	assign Branch = rst?0:(isBEQ & ALUZero) |(isBNE & ~ALUZero)|isJ | isJR | (isBGEZ & ALUBgez) | (isBGTZ & ALUBgtz) | (isBLEZ & ALUBlez) | (isBLTZ & ALUBltz);
	assign BranchAddr = Branch?(isJ?{D_NPC[31:28],D_IR[25:0],2'b00}:isJR?RegA:D_NPC + {{14{D_IR[15]}} , D_IR[15:0],2'b00}):32'b0;
endmodule
