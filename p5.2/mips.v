module mips(input clk,rst);   //top-level module

   //pc/ins signal
	wire [31:0] PC,PC_4P,PC_4D,NPC_out,NPC,PC_8D,PC_8E;
	wire [31:0] instrF,instrD,instrE;
   //ctrl signal
	wire        regwriteD,regwriteW,regwriteE,regwriteM;
	wire        memwriteD,memreadD,memwriteE,memreadE,memwriteM,memreadM;
	wire [1:0]  MemtoRegM,memtoregD,memtoregE,MemtoRegW;
	wire        alusrcD,alusrcE,ss_chD,ss_chE,Jwrite,JwriteE,zero,Branch;
	wire        isSB,isSH,isSB_E,isSH_E;
	wire [1:0]  regdstD,regdstE,ext_op;
	wire [2:0]  npc_sel,cmp_op,ext_sh,ext_sh_E,ext_sh_M,ext_sh_W;
	wire [3:0]  alu_ctrD,alu_ctrE,BE,BE_M;
   //register signal
	wire [4:0]  WriteRegE,WriteRegM,WriteRegW;
	wire [4:0]  rsE,rtE,rdE;
	//data
	wire [31:0] RD1,RD2,RD1D,RD2D,RD1E,RD2E;
	wire [31:0] ResultW,extmemW;
	wire [31:0] ImmD,ImmE;
	wire [31:0] aEp,aE,bE;
	wire [31:0] ALU_out,ALU_outE,ALU_outM,ALU_outW;
   wire [31:0] ReadDataM,ReadDataW,WriteDataE,WriteDataM;
   //harzard signal	
	wire        stallF,stallD,flushE;
	wire [1:0]  forwardAD,forwardBD;
	wire [1:0]  forwardAE,forwardBE;
	//md
	wire        mdstart,mdwrite,mdHILO,Busy,mdstartE,mdwriteE,mdHILOE,mdread,isMADD,isMADDE;
	wire        mdreadE,mdrsel,mdrselE;
	wire [1:0]  mdop,mdopE;
	wire [31:0] HI,LO,md_out,ALU_out_md;
	//cp0
	wire        isMFC0,isMTC0,isMFC0E,isMTC0E,isMFC0M,isMTC0M,isMFC0W,isMTC0W;
	wire [31:0] cp_epc,cp_out,cResultW;
	wire        irq;


//******************************************************************************
// IF stage
//******************************************************************************
	mux_2_32b    MUX  (.a0(PC_4P),.a1(NPC_out),.ch(Branch),.out(NPC));
	PC           PC_0 (.clk(clk),.rst(rst),.en(stallF),.npc(NPC),.pc(PC),.pc_4(PC_4P));
	IM           IM   (.add(PC[12:2]),.instr(instrF));
	
	
	
//******************************************************************************
// IF/ID
//******************************************************************************
	IF_ID      IF_ID(//input
	                 .clk(clk),.en(stallD),.clr(flushD),.PC_4F(PC),
					     //output
					     .RD(instrF),.PC_4D(PC_4D),.PC_8D(PC_8D),.instrD(instrD));
	
	
	
//******************************************************************************
// ID stage
//******************************************************************************
	Control    CTRL    (.instrD(instrD),.regwriteD(regwriteD),.memtoregD(memtoregD),.memwriteD(memwriteD),
	                    .memreadD(memreadD),.alu_ctrD(alu_ctrD),.alusrcD(alusrcD),.regdstD(regdstD),
							  .npc_sel(npc_sel),.ext_op(ext_op),.cmp_op(cmp_op),.ss_chD(ss_chD),.Jwrite(Jwrite),
							  .ext_sh(ext_sh),.isSB(isSB),.isSH(isSH),.mdstart(mdstart),.mdwrite(mdwrite),
							  .mdHILO(mdHILO),.mdop(mdop),.mdread(mdread),.mdrsel(mdrsel),.isMADD(isMADD),
							  .isMFC0(isMFC0),.isMTC0(isMTC0));
	gpr        GPR     (.Clk(clk),.Rst(rst),.A1(instrD[25:21]),.A2(instrD[20:16]),.A3(WriteRegW),
	                    .We(regwriteW),.WD(ResultW),.RD1(RD1),.RD2(RD2));
	mux_3_32b  RD1_MUX (.a0(RD1),.a1(ALU_outM),.a2(ResultW),.ch(forwardAD),.out(RD1D));
	mux_3_32b  RD2_MUX (.a0(RD2),.a1(ALU_outM),.a2(ResultW),.ch(forwardBD),.out(RD2D));
	cmp        CMP     (.A(RD1D),.B(RD2D),.Op(cmp_op),.Br(zero));
	EXT_OP     EXT_IMM (.in(instrD[15:0]),.ext_op(ext_op),.out(ImmD));
	NPC        NPC_0   (.pc(PC_4D),.npc_sel(npc_sel),.zero(zero),.imm(instrD[25:0]),.rs(RD1D),.npc(NPC_out),.Branch(Branch));
	
	
	
//******************************************************************************
// ID/EXE
//******************************************************************************
	ID_EX      ID_EX   (//input
	                    .clk(clk),.clr(flushE),.regwriteD(regwriteD),.memtoregD(memtoregD),.memwriteD(memwriteD),
					        .memreadD(memreadD),.alu_ctrD(alu_ctrD),.alusrcD(alusrcD),.regdstD(regdstD),
					        .RD1D(RD1D),.RD2D(RD2D),.rsD(instrD[25:21]),.rtD(instrD[20:16]),.rdD(instrD[15:11]),
					        .ImmD(ImmD),.PC_8D(PC_8D),.instrD(instrD),.ss_chD(ss_chD),
							  .ext_sh(ext_sh),.isSB(isSB),.isSH(isSH),.Jwrite(Jwrite),.mdstart(mdstart),
							  .mdwrite(mdwrite),.mdHILO(mdHILO),.mdop(mdop),.mdread(mdread),.mdrsel(mdrsel),
							  .isMADD(isMADD),.isMFC0(isMFC0),.isMTC0(isMTC0),
					        //output
					        .regwriteE(regwriteE),.memtoregE(memtoregE),.memwriteE(memwriteE),.memreadE(memreadE),
					        .alu_ctrE(alu_ctrE),.alusrcE(alusrcE),.regdstE(regdstE),
					        .RD1E(RD1E),.RD2E(RD2E),.rsE(rsE),.rtE(rtE),.rdE(rdE),
					        .ImmE(ImmE),.PC_8E(PC_8E),.instrE(instrE),.ss_chE(ss_chE),
							  .ext_sh_E(ext_sh_E),.isSB_E(isSB_E),.isSH_E(isSH_E),.JwriteE(JwriteE),.mdstartE(mdstartE),
							  .mdwriteE(mdwriteE),.mdHILOE(mdHILOE),.mdopE(mdopE),.mdreadE(mdreadE),.mdrselE(mdrselE),
							  .isMADDE(isMADDE),.isMFC0E(isMFC0E),.isMTC0E(isMTC0E));
	
	
	
//******************************************************************************
// EXE stage
//******************************************************************************
	mux_3_5b   WriteReg_MUX  (.a0(rtE),.a1(rdE),.a2(5'h3f),.ch(regdstE),.out(WriteRegE));
	mux_3_32b  ALUa1_MUX     (.a0(RD1E),.a1(ALU_outM),.a2(ResultW),.ch(forwardAE),.out(aEp));
	mux_2_32b  ALUa2_MUX     (.a0(aEp),.a1({27'b0,instrE[10:6]}),.ch(ss_chE),.out(aE));
	mux_3_32b  ALUb1_MUX     (.a0(RD2E),.a1(ALU_outM),.a2(ResultW),.ch(forwardBE),.out(WriteDataE));
	mux_2_32b  ALUb2_MUX     (.a0(WriteDataE),.a1(ImmE),.ch(alusrcE),.out(bE));
	ALU        ALU           (.A(aE),.B(bE),.Op(alu_ctrE),.C(ALU_out));
	md         MD            (.isMADDE(isMADDE),.D1(aE),.D2(bE),.HiLo(mdHILOE),.Op(mdopE),.Start(mdstartE),.We(mdwriteE),.Busy(Busy),.HI(HI),.LO(LO),.Clk(clk),.Rst(rst));
	mux_2_32b  md_MUX        (.a0(HI),.a1(LO),.ch(mdreadE),.out(md_out));
	mux_2_32b  ALU_MUX       (.a0(ALU_out),.a1(PC_8E),.ch(JwriteE),.out(ALU_out_md));
	mux_2_32b  ALURES_MUX2   (.a0(ALU_out_md),.a1(md_out),.ch(mdrselE),.out(ALU_outE));
	ext_be     EXT_BE        (.A(ALU_outE[1:0]),.b(isSB_E),.h(isSH_E),.be(BE));
	
	
	
	
//******************************************************************************
// EXE/MEM
//******************************************************************************
	EX_MEM     EX_MEM      (//input
	                        .clk(clk),.regwriteE(regwriteE),.memtoregE(memtoregE),.memwriteE(memwriteE),
							      .ALU_outE(ALU_outE),.WriteDataE(WriteDataE),.WriteRegE(WriteRegE),
									.MemReadE(memreadE),.BE(BE),.ext_sh_E(ext_sh_E),
									.isMFC0E(isMFC0E),.isMTC0E(isMTC0E),
									//output
									.regwriteM(regwriteM),.memtoregM(MemtoRegM),.memwriteM(memwriteM),.ALU_outM(ALU_outM),
									.WriteDataM(WriteDataM),.WriteRegM(WriteRegM),.MemReadM(memreadM),
									.BE_M(BE_M),.ext_sh_M(ext_sh_M),.isMFC0M(isMFC0M),.isMTC0M(isMTC0M));
	 
	 
	 
	 
//******************************************************************************
// MEM stage
//******************************************************************************
	DM         DM          (.Clk(clk),.A(ALU_outM[12:2]),.WD(WriteDataM),.We(memwriteM),.RD(ReadDataM),.BE(BE_M));
	
	
	
//******************************************************************************
// MEM/WB
//******************************************************************************
	MEM_WB     MEM_WB      (//input
	                        .clk(clk),.RegWriteM(regwriteM),.MemtoRegM(MemtoRegM),.ReadDataM(ReadDataM),
									.ALU_outM(ALU_outM),.WriteRegM(WriteRegM),.ext_sh_M(ext_sh_M),
									.isMFC0M(isMFC0M),.isMTC0M(isMTC0M),
									//output
								   .RegWriteW(regwriteW),.MemtoRegW(MemtoRegW),.ReadDataW(ReadDataW),
									.ALU_outW(ALU_outW),.WriteRegW(WriteRegW),.ext_sh_W(ext_sh_W),
									.isMFC0W(isMFC0W),.isMTC0W(isMTC0W));
	
	
	
//******************************************************************************
// WB stage
//******************************************************************************
	ext_dm    EXT_DM       (.A(ALU_outW[1:0]),.Din(ReadDataW),.Op(ext_sh_W),.DOut(extmemW));
	mux_3_32b MemtoReg_MUX (.a0(ALU_outW),.a1(extmemW),.a2(ALU_outW),.ch(MemtoRegW),.out(cResultW));
	cp0_reg   CP0          (.clk(clk),.rst(rst),.A1(WriteRegW),.A2(WriteRegW),.DIn(cResultW),
	                        .PC(30'b0),.ExcCode(5'b0),.HWInt(6'b0),.We(isMTC0W),.EXLSet(1'b0),
									.EXLClr(1'b0),.IntReq(irq),.EPC(cp_epc),.DOut(cp_out));
	mux_2_32b CP0_MUX      (.a0(cResultW),.a1(cp_out),.ch(isMFC0W),.out(ResultW));




//******************************************************************************
// Harzard unit
//******************************************************************************
	HarzardUnit HARZARD     (//input
	                         .rsD(instrD[25:21]),.rtD(instrD[20:16]),.rsE(rsE),.rtE(rtE),.RegWriteE(regwriteE),
									 .RegWriteM(regwriteM),.RegWriteW(regwriteW),.WriteRegE(WriteRegE),.npc_sel(npc_sel),
									 .WriteRegM(WriteRegM),.WriteRegW(WriteRegW),.MemReadE(memreadE),.MemReadM(memreadM),
									 .mdstartE(mdstartE),.Busy(Busy),
									 //output
									 .stallF(stallF),.stallD(stallD),.flushD(flushD),.forwardAD(forwardAD),
									 .forwardBD(forwardBD),.flushE(flushE),.forwardAE(forwardAE),.forwardBE(forwardBE));
	 
endmodule
