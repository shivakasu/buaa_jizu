module MIPS(input clk,rst);

	wire [31:0] PC,PC_4P,PC_4D,NPC_out,NPC;
	wire [31:0] instrF,instrD;
	
	wire [31:0] PC_8D,PC_8E,PC_8M,PC_8W;
	
	wire regwriteD,memwriteD,memreadD,alusrcD,ss_chD,isSB,isSH,isSB_E,isSH_E,ext_bh,ext_bh_E,ext_bh_M,ext_bh_W;
	wire [1:0] memtoregD,regdstD,ext_op,ext_sh,ext_sh_E,ext_sh_M,ext_sh_W;
	wire [2:0] npc_sel;
	wire [3:0] alu_ctrD,BE,BE_M;
	wire [2:0] cmp_op;

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
	
	wire [31:0] ReadDataM;
	
	wire [1:0] MemtoRegW;
	wire [31:0] ReadDataW,ALU_outW,extmemW,t_ResultW;
	
	wire stallF,stallD,flushE;
	wire [2:0] forwardAD;
	wire [1:0] forwardBD;
	wire [1:0] forwardAE,forwardBE;

	
//******************************************************************************
// IF stage
//******************************************************************************
	mux_2_32b PC_MUX (.a0(PC_4P),.a1(NPC_out),.ch(BoJ),.out(NPC));
	PC        PC_0   (.clk(clk),.rst(rst),.en(stallF),.npc(NPC),.pc(PC),.pc_4(PC_4P));
	IM        IM     (.add(PC[11:2]),.instr(instrF));
	


//******************************************************************************
// IF/ID
//******************************************************************************
	IF_ID     IF_ID  (//input
	                  .clk(clk),.en(stallD),.clr(flushD),.RD(instrF),.PC_4F(PC),
							//output
	                  .PC_4D(PC_4D),.PC_8D(PC_8D),.instrD(instrD));



//******************************************************************************
// ID stage
//******************************************************************************
	Control   CTRL   (.instrD(instrD),.regwriteD(regwriteD),.memtoregD(memtoregD),.memwriteD(memwriteD),.memreadD(memreadD),
	                  .alu_ctrD(alu_ctrD),.alusrcD(alusrcD),.regdstD(regdstD),.npc_sel(npc_sel),.ext_op(ext_op),
							.cmp_op(cmp_op),.ss_chD(ss_chD),.ext_sh(ext_sh),.ext_bh(ext_bh),.isSB(isSB),.isSH(isSH));
	RF        RF     (.Clk(clk),.Rst(rst),.A1(instrD[25:21]),.A2(instrD[20:16]),.A3(WriteRegW),.We(RegWriteW),.WD(ResultW),.RD1(RD1),.RD2(RD2));
	mux_6_32b RD1_MUX(.a0(RD1),.a1(ALU_outM),.a2(ResultW),.a3(PC_8E),.a4(PC_8M),.a5(PC_8W),.ch(forwardAD),.out(RD1D));
	mux_3_32b RD2_MUX(.a0(RD2),.a1(ALU_outM),.a2(ResultW),.ch(forwardBD),.out(RD2D));
	cmp       CMP    (.A(RD1D),.B(RD2D),.Op(cmp_op),.Br(zero));
	EXT_OP    EXT    (.in(instrD[15:0]),.ext_op(ext_op),.out(ImmD));
	NPC       NPC_0  (.pc(PC_4D),.npc_sel(npc_sel),.zero(zero),.imm(instrD[25:0]),.rs(RD1D),.npc(NPC_out),.BoJ(BoJ));
	
	
	
//******************************************************************************
// ID/EXE
//******************************************************************************
	ID_EX     ID_EX  (//input
	                  .clk(clk),.clr(flushE),.regwriteD(regwriteD),.memtoregD(memtoregD),.memwriteD(memwriteD),.instrD(instrD),
							.memreadD(memreadD),.alu_ctrD(alu_ctrD),.alusrcD(alusrcD),.regdstD(regdstD),.RD1D(RD1D),.RD2D(RD2D),
							.rsD(instrD[25:21]),.rtD(instrD[20:16]),.rdD(instrD[15:11]),.ImmD(ImmD),.PC_8D(PC_8D),.ss_chD(ss_chD),
							.ext_bh(ext_bh),.ext_sh(ext_sh),.isSB(isSB),.isSH(isSH),
							//output
							.regwriteE(regwriteE),.memtoregE(memtoregE),.memwriteE(memwriteE),.memreadE(memreadE),.alu_ctrE(alu_ctrE),
							.alusrcE(alusrcE),.regdstE(regdstE),.RD1E(RD1E),.RD2E(RD2E),.rsE(rsE),.rtE(rtE),.rdE(rdE),
							.ImmE(ImmE),.PC_8E(PC_8E),.instrE(instrE),.ss_chE(ss_chE),.ext_bh_E(ext_bh_E),.ext_sh_E(ext_sh_E),
							.isSB_E(isSB_E),.isSH_E(isSH_E));
	
	
	
//******************************************************************************
// EXE stage
//******************************************************************************
	mux_3_5b  WriteReg_MUX (.a0(rtE),.a1(rdE),.a2(5'h3f),.ch(regdstE),.out(WriteRegE));
	mux_3_32b ALUa1_MUX    (.a0(RD1E),.a1(ALU_outM),.a2(ResultW),.ch(forwardAE),.out(aEp));
	mux_2_32b ALUa2_MUX    (.a0(aEp),.a1({27'b0,instrE[10:6]}),.ch(ss_chE),.out(aE));
	mux_3_32b ALUb1_MUX    (.a0(RD2E),.a1(ALU_outM),.a2(ResultW),.ch(forwardBE),.out(WriteDataE));
	mux_2_32b ALUb2_MUX    (.a0(WriteDataE),.a1(ImmE),.ch(alusrcE),.out(bE));
	ALU       ALU          (.A(aE),.B(bE),.Op(alu_ctrE),.C(ALU_outE));
	ext_be    EXT_BE       (.A(ALU_outE[1:0]),.b(isSB_E),.h(isSH_E),.be(BE));
	
	
	
//******************************************************************************
// EXE/MEM
//******************************************************************************
	EX_MEM    EX_MEM       (//input
	                        .clk(clk),.regwriteE(regwriteE),.memtoregE(memtoregE),.memwriteE(memwriteE),.ALU_outE(ALU_outE),
	                        .WriteDataE(WriteDataE),.WriteRegE(WriteRegE),.PC_8E(PC_8E),.BE(BE),.ext_sh_E(ext_sh_E),
									.ext_bh_E(ext_bh_E),
									//output
									.regwriteM(RegWriteM),.memtoregM(MemtoRegM),.memwriteM(memwriteM),.ALU_outM(ALU_outM),
									.WriteDataM(WriteDataM),.WriteRegM(WriteRegM),.PC_8M(PC_8M),.BE_M(BE_M),
									.ext_sh_M(ext_sh_M),.ext_bh_M(ext_bh_M));
	 
	
	
//******************************************************************************
// MEM stage
//******************************************************************************
	DM        DM     (.Clk(clk),.A(ALU_outM[12:2]),.WD(WriteDataM),.We(memwriteM),.RD(ReadDataM),.BE(BE_M));
	
	
	
//******************************************************************************
// MEM/WB
//******************************************************************************
	MEM_WB    MEM_WB (//input
	                  .clk(clk),.RegWriteM(RegWriteM),.MemtoRegM(MemtoRegM),.ReadDataM(ReadDataM),
							.ALU_outM(ALU_outM),.WriteRegM(WriteRegM),.PC_8M(PC_8M),.ext_bh_M(ext_bh_M),
							.ext_sh_M(ext_sh_M),
							//output
							.RegWriteW(RegWriteW),.MemtoRegW(MemtoRegW),.ReadDataW(ReadDataW),
							.ALU_outW(ALU_outW),.WriteRegW(WriteRegW),.PC_8W(PC_8W),.ext_bh_W(ext_bh_W),
							.ext_sh_W(ext_sh_W));
	
	
	
//******************************************************************************
// WB stage
//******************************************************************************
   ext_dm    EXT_DM       (.A(ALU_outW[1:0]),.Din(ReadDataW),.Op(ext_sh_W),.DOut(extmemW));
	mux_3_32b MemtoReg_MUX (.a0(ALU_outW),.a1(ReadDataW),.a2(PC_8W),.ch(MemtoRegW),.out(t_ResultW));
	mux_2_32b EXTMEM_MUX   (.a0(t_ResultW),.a1(extmemW),.ch(ext_bh_W),.out(ResultW));
	
 


//******************************************************************************
// Harzard unit
//******************************************************************************
	HarzardUnit HARZARD (//input
	                     .rsD(instrD[25:21]),.rtD(instrD[20:16]),.rsE(rsE),.rtE(rtE),.RegWriteE(regwriteE),
	                     .RegWriteM(RegWriteM),.RegWriteW(RegWriteW),.WriteRegE(WriteRegE),.WriteRegM(WriteRegM),
								.WriteRegW(WriteRegW),.MemReadE(memreadE),.npc_sel(npc_sel),
								//output
								.stallF(stallF),.stallD(stallD),.flushD(flushD),.forwardAD(forwardAD),
								.forwardBD(forwardBD),.flushE(flushE),.forwardAE(forwardAE),.forwardBE(forwardBE));
	 
endmodule
