module MIPS (clk,rst,D_NPC,D_IR,ALUResult,MEMDataOut,Over);
   input clk,rst;
   output [31:0] D_NPC,D_IR,ALUResult,MEMDataOut;
   output Over;	
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
	wire WritePC,Branch,WriteIR,ReadMem,WriteReg,MemToReg,WriteMem,RegDes,ALUSrcB,PcToReg,ext_bh;
	wire [5:0] op,func;
	wire [4:0] shift;
	wire [1:0] ext_op;
	//EXE inputs
	wire E_ReadMem,E_WriteReg,E_MemToReg,E_WriteMem,E_RegDes,E_ALUSrcB,E_PcToReg,E_ext_bh;
	wire [3:0] E_ALUcontrol;
	wire [31:0] E_A,E_B,E_I,E_NPC;
	wire [4:0] E_RT,E_RD,E_RS;
	wire [5:0] E_op,E_func;
	wire [4:0] E_shift;
	wire [1:0] E_ext_op;
	wire [3:0] BE;
	//MEM inputs
	wire M_WriteReg,M_MemToReg,M_WriteMem,M_PcToReg,M_ext_bh;
	wire [4:0] M_RD;
	wire [31:0] M_ALUResult,M_B,M_NPC;
	wire [31:0] MEMDataOut;
	wire [1:0]  M_ext_op;
	wire [3:0]  M_BE;
	// WB inputs
	wire [31:0] W_ALUResult,W_MEMDataOut;
	wire W_MemToReg;
	wire W_WriteReg;
	wire W_PcToReg;
	wire W_ext_bh;
	wire [4:0] W_RegWriteAddr;
	wire [31:0] W_RegWriteData,W_NPC;
	wire [1:0] W_ext_op;
	wire [31:0] W_extMEMData;


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
			.W_RegWriteAddr(W_RegWriteAddr), 
			.W_RegWriteData(W_RegWriteData), 
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
			.ei(ei), // immidiate
			.ert(ert), //rt's register number
			.erd(erd),  //rd's register number
			.op(op),
			.func(func),
			.shift(shift),
			.ext_op(ext_op),
			.ext_bh(ext_bh),
			.E_RT(E_RT),
			.E_MemToReg(E_MemToReg)
			);

	
   defparam E1.n = 1;
	dffre2 E1(.clk(clk), .d(ReadMem), .q(E_ReadMem), .en(WriteIR));
	defparam E2.n = 1;
	dffre2 E2(.clk(clk), .d(WriteReg), .q(E_WriteReg), .en(WriteIR));
	defparam E3.n = 1;
	dffre2 E3(.clk(clk), .d(MemToReg), .q(E_MemToReg), .en(WriteIR));
	defparam E4.n = 1;
	dffre2 E4(.clk(clk), .d(WriteMem), .q(E_WriteMem), .en(WriteIR));
	defparam E5.n = 1;
	dffre2 E5(.clk(clk), .d(RegDes), .q(E_RegDes), .en(WriteIR));
	defparam E6.n = 1;
	dffre2 E6(.clk(clk), .d(ALUSrcB), .q(E_ALUSrcB), .en(WriteIR));
	defparam E7.n = 4;
	dffre2 E7(.clk(clk), .d(ALUcontrol), .q(E_ALUcontrol), .en(WriteIR));
	defparam E8.n = 5;
	dffre2 E8(.clk(clk), .d(ert), .q(E_RT), .en(WriteIR));
	defparam E9.n = 5;
	dffre2 E9(.clk(clk), .d(erd), .q(E_RD), .en(WriteIR));					
	dffre2 E10(.clk(clk), .d(ea), .q(E_A), .en(WriteIR));					
	dffre2 E11(.clk(clk), .d(eb), .q(E_B), .en(WriteIR));					
	dffre2 E12(.clk(clk), .d(ei), .q(E_I), .en(WriteIR));	
   defparam E13.n = 1;
	dffre2 E13(.clk(clk), .d(PcToReg), .q(E_PcToReg), .en(WriteIR));
   dffre2 E14(.clk(clk), .d(D_NPC), .q(E_NPC), .en(WriteIR));	
	defparam E15.n = 6;
	dffre2 E15(.clk(clk), .d(op), .q(E_op), .en(WriteIR));
	defparam E16.n = 6;
	dffre2 E16(.clk(clk), .d(func), .q(E_func), .en(WriteIR));
	defparam E17.n = 5;
	dffre2 E17(.clk(clk), .d(shift), .q(E_shift), .en(WriteIR));
	defparam E18.n = 2;
	dffre2 E18(.clk(clk), .d(ext_op), .q(E_ext_op), .en(WriteIR));
	defparam E19.n = 1;
	dffre2 E19(.clk(clk), .d(ext_bh), .q(E_ext_bh), .en(WriteIR));



EXE	EXE(
	// inputs
	.clk(clk),
	.rst(rst),
	.E_RegDes(E_RegDes),  // signals
	.E_ALUSrcB(E_ALUSrcB),
	.E_ALUcontrol(E_ALUcontrol),
	.E_A(E_A), // operand A
	.E_B(E_B), // operand B
	.E_I(E_I), // immidiate number
	.E_RT(E_RT), // the rt's register number
	.E_RD(E_RD), // the rd's register number
	.E_op(E_op),
	.E_func(E_func),
	.E_shift(E_shift),
	// outputs
	.ALUResult(ALUResult),
	.mrd(mrd), // rd's register number
	.mb(mb),    // the operand B
	.BE(BE)
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
   dffre M8(.clk(clk), .d(E_NPC), .q(M_NPC), .en(1'b1));	
	defparam M9.n = 2;
	dffre M9(.clk(clk), .d(E_ext_op), .q(M_ext_op), .en(1'b1));
	defparam M10.n = 1;
	dffre M10(.clk(clk), .d(E_ext_bh), .q(M_ext_bh), .en(1'b1));
	defparam M11.n = 4;
	dffre M11(.clk(clk), .d(BE), .q(M_BE), .en(1'b1));

MEM MEM(
//inputs
	.clk(clk),
	.M_WriteMem(M_WriteMem),
	.M_ALUResult(M_ALUResult), //address
	.M_B(M_B),				  // data write to mem
	.M_BE(M_BE),
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
	dffre W7(.clk(clk), .d(M_NPC), .q(W_NPC), .en(1'b1));
	defparam W8.n = 2;
	dffre W8(.clk(clk), .d(M_ext_op), .q(W_ext_op), .en(1'b1));
	defparam W9.n = 1;
	dffre W9(.clk(clk), .d(M_ext_bh), .q(W_ext_bh), .en(1'b1));
	ext_dm EXT_DM (.A(W_ALUResult[1:0]),.Din(W_MEMDataOut),.Op(W_ext_op),.DOut(W_extMEMData));
	assign W_RegWriteData = W_ext_bh?W_extMEMData:W_MemToReg?W_MEMDataOut:W_PcToReg?W_NPC+8:W_ALUResult;
endmodule
