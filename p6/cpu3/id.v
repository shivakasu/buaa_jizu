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
			ea,eb,ei,ert,erd,
			op,func,shift,ext_op,ext_bh,E_RT,E_MemToReg
			);
   input         clk,rst;			
   input  [31:0] D_IR,D_NPC;
   input         E_WriteReg,M_WriteReg,W_WriteReg,E_MemToReg;
   input  [4:0]  E_RD,M_RD,W_RegWriteAddr,E_RT;
   input  [31:0] E_Result,M_Result,W_RegWriteData;
   input  [63:0] W_RegWriteData2;
   output 	     WritePC,Branch,WriteIR,ReadMem,WriteReg,MemToReg,WriteMem,RegDes,ALUSrcB,PcToReg,ext_bh;
   output [3:0]  ALUcontrol;
   output [1:0]  FWDA,FWDB;
   output [31:0] BranchAddr;
   output [31:0] ea,eb,ei;
   output [4:0]  ert,erd;
   output [5:0]  op,func;
	output [4:0]  shift;
	output [1:0]  ext_op;
   wire   [31:0] RegA,RegB;

	wire [4:0]	RtAddr, RdAddr, RsAddr;
	wire [15:0]	immediate;
   
	assign op			= D_IR[`opfield];
	assign RtAddr		= D_IR[`rt];
	assign RdAddr		= D_IR[`rd];
	assign RsAddr		= D_IR[`rs];
	assign func			= D_IR[`funct];
	assign immediate	= D_IR[`immediate];
	assign shift      = D_IR[`shift];
	
	assign ert = RtAddr;
	assign erd = RdAddr;
	assign ei = {{16{immediate[15]}},immediate[15:0]};// the sign extent of immidiate number 
	
	
	controller ctrl(.op(op),.func(func),.ALUcontrol(ALUcontrol),
	                .ReadMem(ReadMem),.WriteReg(WriteReg),
						 .MemToReg(MemToReg),.WriteMem(WriteMem),.RegDes(RegDes),.ALUSrcB(ALUSrcB),.PcToReg(PcToReg),.ext_op(ext_op),.ext_bh(ext_bh));
	
	RegFile RegFile(.A1(RsAddr),.A2(RtAddr),.A3(W_RegWriteAddr),.RD1(RegA),.RD2(RegB),.WD(W_RegWriteData),.We(W_WriteReg),.Clk(clk),.Rst(rst));
		
	wire isBEQ, isBNE, isJ, isJR, isJALR, isBGEZ, isBGTZ, isBLEZ, isBLTZ;
	assign isBEQ   = (op == `opcode_beq);
	assign isBNE   = (op == `opcode_bne);
	assign isJ     = (op == `opcode_j)     || (op == `opcode_jal);
	assign isJR    = (op == `opcode_rtype) && (func == `funcode_jr);
	assign isJALR  = (op == `opcode_rtype) && (func == `funcode_jalr);
	assign isBGEZ  = (op == `opcode_bgez)  && (RtAddr == 5'b00001);
	assign isBGTZ  = (op == `opcode_bgtz);
	assign isBLEZ  = (op == `opcode_blez);
	assign isBLTZ  = (op == `opcode_bltz)  && (RtAddr == 5'b00000);
	
	hazard_FWD hazard_FWD(.rst(rst),.E_WriteReg(E_WriteReg),.W_WriteReg(W_WriteReg),.M_WriteReg(M_WriteReg),
			              .E_RD(E_RD),.M_RD(M_RD),.W_RegWriteAddr(W_RegWriteAddr),.RsAddr(RsAddr),.RtAddr(RtAddr),
							  .FWDA(FWDA),.FWDB(FWDB));
	
	assign ea = FWDA[0]?(FWDA[1]?W_RegWriteData:E_Result):(FWDA[1]?M_Result:RegA);
	assign eb = FWDB[0]?(FWDB[1]?W_RegWriteData:E_Result):(FWDB[1]?M_Result:RegB);
   
	
	
	wire [2:0] cmp_op;      //b_type judge
	wire       Br,is_btype;
	assign is_btype = isBEQ|isBNE|isBGTZ|isBGEZ|isBLEZ|isBLTZ;
	assign cmp_op = isBEQ?  3'b000:
	                isBNE?  3'b001:
						 isBGEZ? 3'b010:
						 isBGTZ? 3'b011:
						 isBLEZ? 3'b100:
						         3'b101;
	cmp CMP (.A(ea),.B(eb),.Op(cmp_op),.Br(Br));
	
	assign Branch = rst?0:(is_btype & Br)|isJ | isJR | isJALR;
	
	assign WritePC = (E_WriteReg&& is_btype &&((RsAddr==E_RD)||(RtAddr==E_RD)))||	
						  ((E_RT!=5'b0)&&E_MemToReg&&(RsAddr==E_RT||RtAddr==E_RT))?					1'b0:	
						  1'b1;
	assign WriteIR = WritePC; 
	
	//assign ea=RegA;
	//assign eb=RegB;
	
	assign BranchAddr = Branch?(isJ?{D_NPC[31:28],D_IR[25:0],2'b00}:(isJR|isJALR)?RegA:D_NPC + {{14{D_IR[15]}} , D_IR[15:0],2'b00}):32'b0;
endmodule
