module mips(input clk,rst);
	
	wire [31:0] PC,PC_4P,PC_4D,NPC_out,NPC;
	wire [31:0] instrF,instrD;
	
	wire [31:0] PC_8D,PC_8E,PC_8M,PC_8W;
	
	wire regwriteD,memwriteD,memreadD,alusrcD,ss_chD;
	wire [1:0] memtoregD,regdstD,ext_op;
	wire [2:0] npc_sel;
	wire [3:0] alu_ctrD;
	wire [2:0] B_type;

	wire [4:0] WriteRegW;
	wire [31:0] RD1,RD2;
	wire RegWriteW;
	wire [31:0] ResultW;
	wire [31:0] RD1D,RD2D;
	wire zero,BoJ;
	
	wire [31:0] ImmD,ImmE;
	
	wire regwriteE,memwriteE,memreadE,alusrcE,ss_chE;
	wire [1:0] memtoregE,regdstE;
	wire [3:0] alu_ctrE;
	wire [31:0] RD1E,RD2E;
	wire [4:0] rsE,rtE,rdE;
	wire [31:0] instrE;
	
	wire [31:0] aEp,aE,bE,WriteDataE;
	
	wire [31:0] ALU_outE,ALU_outM,WriteDataM;
	wire [4:0] WriteRegE,WriteRegM;
	wire [1:0] MemtoRegM;
	wire regwriteM,memwriteM;
	wire memreadM;
	
	wire [31:0] ReadDataM;
	
	wire [1:0] MemtoRegW;
	wire [31:0] ReadDataW,ALU_outW;
	
	wire stallF,stallD,flushE;
	wire [1:0] forwardAD,forwardBD;
	wire [1:0] forwardAE,forwardBE;

	
	mux_2_32b PC_MUX(.a0(PC_4P),.a1(NPC_out),.ch(BoJ),.out(NPC));
	PC P_PC(.clk(clk),.rst(rst),.en(stallF),.npc(NPC),.pc(PC));
	PC_4 P_PC_4(.pc(PC),.pc_4(PC_4P));
	IM P_IM(.add(PC[11:2]),.instr(instrF));
	
	IF_ID P_IF_ID(.clk(clk),.en(stallD),.clr(flushD),.RD(instrF),.PC_4F(PC),.PC_4D(PC_4D),.PC_8D(PC_8D),.instrD(instrD));
	
	Control P_CTR(.instrD(instrD),.regwriteD(regwriteD),.memtoregD(memtoregD),.memwriteD(memwriteD),.memreadD(memreadD),.alu_ctrD(alu_ctrD),.alusrcD(alusrcD),.regdstD(regdstD),.npc_sel(npc_sel),.ext_op(ext_op),.B_type(B_type),.ss_chD(ss_chD));
	RF P_RF(.Clk(clk),.Rst(rst),.A1(instrD[25:21]),.A2(instrD[20:16]),.A3(WriteRegW),.We(RegWriteW),.WD(ResultW),.RD1(RD1),.RD2(RD2));
	mux_3_32b P_RD1_MUX(.a0(RD1),.a1(ALU_outM),.a2(ResultW),.ch(forwardAD),.out(RD1D));
	mux_3_32b P_RD2_MUX(.a0(RD2),.a1(ALU_outM),.a2(ResultW),.ch(forwardBD),.out(RD2D));
	Equal PC_EQ(.A(RD1D),.B(RD2D),.Op(B_type),.Br(zero));
	EXT_OP P_EXT(.in(instrD[15:0]),.ext_op(ext_op),.out(ImmD));
	NPC P_NPC(.pc(PC_4D),.npc_sel(npc_sel),.zero(zero),.imm(instrD[25:0]),.rs(RD1D),.npc(NPC_out),.BoJ(BoJ));
	
	ID_EX P_ID_EX(.clk(clk),.clr(flushE),.regwriteD(regwriteD),.memtoregD(memtoregD),.memwriteD(memwriteD),.memreadD(memreadD),.alu_ctrD(alu_ctrD),.alusrcD(alusrcD),.regdstD(regdstD),
							.regwriteE(regwriteE),.memtoregE(memtoregE),.memwriteE(memwriteE),.memreadE(memreadE),.alu_ctrE(alu_ctrE),.alusrcE(alusrcE),.regdstE(regdstE),
							.RD1D(RD1D),.RD2D(RD2D),
							.RD1E(RD1E),.RD2E(RD2E),
							.rsD(instrD[25:21]),.rtD(instrD[20:16]),.rdD(instrD[15:11]),
							.rsE(rsE),.rtE(rtE),.rdE(rdE),
							.ImmD(ImmD),.ImmE(ImmE),
							.PC_8D(PC_8D),.PC_8E(PC_8E),
							.instrD(instrD),.instrE(instrE),
							.ss_chD(ss_chD),.ss_chE(ss_chE));
	
	mux_3_5b WriteReg_MUX(.a0(rtE),.a1(rdE),.a2(5'h3f),.ch(regdstE),.out(WriteRegE));
	mux_3_32b ALUa1_MUX(.a0(RD1E),.a1(ALU_outM),.a2(ResultW),.ch(forwardAE),.out(aEp));
	mux_2_32b ALUa2_MUX(.a0(aEp),.a1({27'b0,instrE[10:6]}),.ch(ss_chE),.out(aE));
	mux_3_32b ALUb1_MUX(.a0(RD2E),.a1(ALU_outM),.a2(ResultW),.ch(forwardBE),.out(WriteDataE));
	mux_2_32b ALUb2_MUX(.a0(WriteDataE),.a1(ImmE),.ch(alusrcE),.out(bE));
	ALU P_ALU(.A(aE),.B(bE),.Op(alu_ctrE),.C(ALU_outE));
	
	EX_MEM P_EX_MEM(.clk(clk),.regwriteE(regwriteE),.memtoregE(memtoregE),.memwriteE(memwriteE),.ALU_outE(ALU_outE),.WriteDataE(WriteDataE),.WriteRegE(WriteRegE),
									.regwriteM(RegWriteM),.memtoregM(MemtoRegM),.memwriteM(memwriteM),.ALU_outM(ALU_outM),.WriteDataM(WriteDataM),.WriteRegM(WriteRegM),
									.PC_8E(PC_8E),.PC_8M(PC_8M),
									.MemReadE(memreadE),.MemReadM(memreadM));
	 
	DM P_DM(.Clk(clk),.A(ALU_outM[11:2]),.WD(WriteDataM),.We(memwriteM),.RD(ReadDataM));
	
	MEM_WB P_MEM_WB(.clk(clk),.RegWriteM(RegWriteM),.MemtoRegM(MemtoRegM),.ReadDataM(ReadDataM),.ALU_outM(ALU_outM),.WriteRegM(WriteRegM),
								.RegWriteW(RegWriteW),.MemtoRegW(MemtoRegW),.ReadDataW(ReadDataW),.ALU_outW(ALU_outW),.WriteRegW(WriteRegW),.PC_8M(PC_8M),.PC_8W(PC_8W));
	mux_3_32b MemtoReg_MUX(.a0(ALU_outW),.a1(ReadDataW),.a2(PC_8W),.ch(MemtoRegW),.out(ResultW));


	HarzardUnit P_HAR(.rsD(instrD[25:21]),.rtD(instrD[20:16]),.rsE(rsE),.rtE(rtE),.RegWriteE(regwriteE),.RegWriteM(RegWriteM),.RegWriteW(RegWriteW),.WriteRegE(WriteRegE),.WriteRegM(WriteRegM),.WriteRegW(WriteRegW),
	.MemReadE(memreadE),.MemReadM(memreadM),
	.npc_sel(npc_sel),.stallF(stallF),.stallD(stallD),.flushD(flushD),.forwardAD(forwardAD),.forwardBD(forwardBD),.flushE(flushE),.forwardAE(forwardAE),.forwardBE(forwardBE));
	 
endmodule
