module MIPS (clk,rst,D_NPC,D_IR,ALUResult,MEMDataOut);
   input clk,rst;
   output [31:0] D_NPC,D_IR,ALUResult,MEMDataOut;	
   //IF output
	wire [31:0]	instr;			// current instr
	wire [31:0]	pc;				// current pc
	//ID inputs
	wire [31:0] D_IR;
	wire [31:0] D_NPC;
   //ID outputs
	wire [3:0] ALUcontrol;
	wire [1:0] FWDB,FWDA;
	wire [31:0] ea,eb,ei;
	wire [4:0] ert,erd;
	wire [31:0] ALUResult,mb;
	wire [4:0] mrd;
	wire [31:0]M_Result;
	wire [31:0] BranchAddr;
	wire WritePC,Branch,WriteIR,ReadMem,WriteReg,MemToReg,WriteMem,RegDes,ALUSrcB,PcToReg;
	//EXE inputs
	wire E_ReadMem,E_WriteReg,E_MemToReg,E_WriteMem,E_RegDes,E_ALUSrcB,E_PcToReg;
	wire [3:0] E_ALUcontrol;
	wire [31:0] E_A,E_B,E_I;
	wire [4:0] E_RT,E_RD,E_RS;
	//MEM inputs
	wire M_WriteReg,M_MemToReg,M_WriteMem,M_PcToReg;
	wire [4:0] M_RD;
	wire [31:0] M_ALUResult,M_B;
	wire [31:0] MEMDataOut;
	// WB inputs
	wire [31:0] W_ALUResult,W_MEMDataOut;
	wire W_MemToReg;
	wire W_WriteReg;
	wire W_PcToReg;
	wire [4:0] W_RegWriteAddr;
	wire [31:0] W_RegWriteData;


   IF IF (
		// Inputs
		.clk	(clk),
		.rst	(rst),
		.Branch	(Branch), // is Branch?
		.WritePC (WritePC), // write the PC register?
		.BranchAddr	(BranchAddr),// branch address
		// Outputs
		.pc	(pc),
		.instr	(instr)
		);
	
   dffre D1(.clk(clk), .d(instr), .q(D_IR), .en(WriteIR)); // pass instr to ID
	dffre D2(.clk(clk), .d(pc), .q(D_NPC), .en(WriteIR));	// pass pc to ID


   ID ID( //inputs
			.clk(clk),
			.rst(rst),
			.D_IR(D_IR), // instruction register
			.D_NPC(D_NPC), // pc register
			.E_WriteReg(E_WriteReg), //WriteReg from EXE
			.E_RD(mrd), // destination register No from EXE
			.E_Result(ALUResult), //ALUResult from EXE
			.M_WriteReg(M_WriteReg), // WriteReg from MEM
			.M_RD(M_RD), // destination register No from MEM
			.M_Result(M_Result)	, // Result from MEM	
			.W_WriteReg(W_WriteReg), //WriteReg from WB
			.W_RegWriteAddr(W_RegWriteAddr), // destination register No from WB
			.W_RegWriteData(W_RegWriteData), // Result from WB
			//outputs
			.WritePC(WritePC), // ctrl signals
			.Branch(Branch),
			.WriteIR(WriteIR),
			.ReadMem(ReadMem),
			.WriteReg(WriteReg),
			.MemToReg(MemToReg),
			.PcToReg(PcToReg),
			.WriteMem(WriteMem),
			.ALUcontrol(ALUcontrol),
			.RegDes(RegDes),
			.ALUSrcB(ALUSrcB),
			.FWDB(FWDB),
			.FWDA(FWDA),
			.BranchAddr(BranchAddr),
			.ea(ea), // operand A
			.eb(eb), // operand B
			.ei(ei), // immidiate number
			.ert(ert), //the rt's register number
			.erd(erd)  // the rd's register number
			);

	
   defparam E1.n = 1;
	dffre E1(.clk(clk), .d(ReadMem), .q(E_ReadMem), .en(1'b1));
	defparam E2.n = 1;
	dffre E2(.clk(clk), .d(WriteReg), .q(E_WriteReg), .en(1'b1));
	defparam E3.n = 1;
	dffre E3(.clk(clk), .d(MemToReg), .q(E_MemToReg), .en(1'b1));
	defparam E4.n = 1;
	dffre E4(.clk(clk), .d(WriteMem), .q(E_WriteMem), .en(1'b1));
	defparam E5.n = 1;
	dffre E5(.clk(clk), .d(RegDes), .q(E_RegDes), .en(1'b1));
	defparam E6.n = 1;
	dffre E6(.clk(clk), .d(ALUSrcB), .q(E_ALUSrcB), .en(1'b1));
	defparam E7.n = 4;
	dffre E7(.clk(clk), .d(ALUcontrol), .q(E_ALUcontrol), .en(1'b1));
	defparam E8.n = 5;
	dffre E8(.clk(clk), .d(ert), .q(E_RT), .en(1'b1));
	defparam E9.n = 5;
	dffre E9(.clk(clk), .d(erd), .q(E_RD), .en(1'b1));					
	dffre E10(.clk(clk), .d(ea), .q(E_A), .en(1'b1));					
	dffre E11(.clk(clk), .d(eb), .q(E_B), .en(1'b1));					
	dffre E12(.clk(clk), .d(ei), .q(E_I), .en(1'b1));	
   defparam E13.n = 1;
	dffre E13(.clk(clk), .d(PcToReg), .q(E_PcToReg), .en(1'b1));	



EXE	EXE(
	// inputs
	.E_RegDes(E_RegDes),  // signals
	.E_ALUSrcB(E_ALUSrcB),
	.E_ALUcontrol(E_ALUcontrol),
	.E_A(E_A), // operand A
	.E_B(E_B), // operand B
	.E_I(E_I), // immidiate number
	.E_RT(E_RT), // the rt's register number
	.E_RD(E_RD), // the rd's register number
	.E_PcToReg(E_PcToReg),
	// outputs
	.ALUResult(ALUResult),
	.mrd(mrd), // the rd's register number
	.mb(mb)    // the operand B
	);
	
	defparam M1.n = 1;
	dffre M1(.clk(clk), .d(E_WriteReg), .q(M_WriteReg), .en(1'b1));
	defparam M2.n = 1;
	dffre M2(.clk(clk), .d(E_MemToReg), .q(M_MemToReg), .en(1'b1));
	defparam M3.n = 1;
	dffre M3(.clk(clk), .d(E_WriteMem), .q(M_WriteMem), .en(1'b1));
	defparam M4.n = 5;
	dffre M4(.clk(clk), .d(mrd), .q(M_RD), .en(1'b1));	
	dffre M5(.clk(clk), .d(ALUResult), .q(M_ALUResult), .en(1'b1));	
	dffre M6(.clk(clk), .d(mb), .q(M_B), .en(1'b1));
   defparam M7.n = 1;
	dffre M7(.clk(clk), .d(E_PcToReg), .q(M_PcToReg), .en(1'b1));	
	

MEM MEM(
//inputs
	.clk(clk),
	.M_WriteMem(M_WriteMem),
	.M_ALUResult(M_ALUResult), //address
	.M_B(M_B),				  // data write to mem
//outputs
	.MEMDataOut(MEMDataOut) // data from mem
	);	


// WB
   assign M_Result = M_MemToReg?MEMDataOut:M_ALUResult;
	defparam W1.n = 1;
	dffre W1(.clk(clk), .d(M_WriteReg), .q(W_WriteReg), .en(1'b1));
	defparam W2.n = 1;
	dffre W2(.clk(clk), .d(M_MemToReg), .q(W_MemToReg), .en(1'b1));
	defparam W3.n = 5;
	dffre W3(.clk(clk), .d(M_RD), .q(W_RegWriteAddr), .en(1'b1));	
	defparam W4.n = 32;
	dffre W4(.clk(clk), .d(M_ALUResult), .q(W_ALUResult), .en(1'b1));	
	defparam W5.n = 32;
	dffre W5(.clk(clk), .d(MEMDataOut), .q(W_MEMDataOut), .en(1'b1));	
	defparam W6.n = 1;
	dffre W6(.clk(clk), .d(M_PcToReg), .q(W_PcToReg), .en(1'b1));
	assign W_RegWriteData = W_MemToReg?W_MEMDataOut:W_PcToReg?pc+4:W_ALUResult;
endmodule
