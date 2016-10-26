module mips ( clk, rst );
    input  clk,rst;
    wire[31:0] PC,NPC,PC_4;
    wire[31:0] INSTR;                 //  instruction
    wire[31:0] RD1,RD2,ALU_OUT;                 //  data and calulate
    wire[31:0] WD,EXT_D,CAL_D,DM_D;                 //  data
    wire[4:0] WRITEREG;
    wire ALUSRC,REGWRITE,MEMWRITE,ZERO;
    wire[1:0] REGDST,MEMTOREG,EXT_OP ;
    wire[2:0] NPC_SEL,ALUCTR ;
    pc My_PC(.clk(clk),.rst(rst),.npc(NPC),.pc(PC));
    npc My_NPC(.pc(PC),.npc_sel(NPC_SEL),.zero(ZERO),.imme(INSTR[25:0]),.rs(ALU_OUT),.npc(NPC),.pc_4(PC_4));           
    im_4k My_IM(.addr(PC[11:2]),.dout(INSTR) );
    mux_3_5b MUX_1(.a0(INSTR[20:16]),.a1(INSTR[15:11]),.a2(5'h3f),.ch(REGDST),.out(WRITEREG));
    gpr My_GPR(.clk(clk),.rst(rst),.readreg1(INSTR[25:21]),.readreg2(INSTR[20:16]),.writereg(WRITEREG),.we(REGWRITE),.writedata(WD),.readdata1(RD1),.readdata2(RD2));   
    mux_2_32b MUX_2(.a0(RD2),.a1(EXT_D),.ch(ALUSRC),.out(CAL_D) );       
    alu My_ALU(.a(RD1),.b(CAL_D),.alu_ctr(ALUCTR),.alu_out(ALU_OUT),.zero(ZERO));
    ctrl My_CTRL(.instr(INSTR),.regdst(REGDST),.alusrc(ALUSRC),.memtoreg(MEMTOREG),.memwrite(MEMWRITE),.regwrite(REGWRITE),.npc_sel(NPC_SEL),.ext_op(EXT_OP),.alu_ctr(ALUCTR)); 
    dm_4k My_DM(.addr(ALU_OUT[11:2]),.din(RD2),.we(MEMWRITE),.clk(clk),.dout(DM_D))  ; 
    mux_3_32b MUX_3(.a0(ALU_OUT),.a1(DM_D),.a2(PC_4),.ch(MEMTOREG),.out(WD));
    ext My_EXT(.din(INSTR[15:0]),.ext_op(EXT_OP),.dout(EXT_D));
endmodule