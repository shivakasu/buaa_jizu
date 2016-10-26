module ID_EX(input         clk,clr,regwriteD,memwriteD,memreadD,alusrcD,ss_chD,ext_bh,isSB,isSH,
             input  [1:0]  memtoregD,regdstD,ext_sh,
				 input  [3:0]  alu_ctrD,
				 input  [31:0] RD1D,RD2D,ImmD,PC_8D,instrD,
				 input  [4:0]  rsD,rtD,rdD,
				 output   		regwriteE,memwriteE,memreadE,alusrcE,ss_chE,ext_bh_E,isSB_E,isSH_E,
				 output [1:0]  memtoregE,regdstE,ext_sh_E,
				 output [3:0]  alu_ctrE,
				 output [31:0] RD1E,RD2E,ImmE,PC_8E,instrE,
				 output [4:0]  rsE,rtE,rdE
				);
	
	defparam E1.n = 1;
	dffre_flush E1(.clk(clk), .d(regwriteD), .q(regwriteE), .en(clr));
	defparam E2.n = 2;
	dffre_flush E2(.clk(clk), .d(memtoregD), .q(memtoregE), .en(clr));
	defparam E3.n = 1;
	dffre_flush E3(.clk(clk), .d(memwriteD), .q(memwriteE), .en(clr));
	defparam E4.n = 1;
	dffre_flush E4(.clk(clk), .d(memreadD), .q(memreadE), .en(clr));
	defparam E5.n = 1;
	dffre_flush E5(.clk(clk), .d(alusrcD), .q(alusrcE), .en(clr));
	defparam E6.n = 2;
	dffre_flush E6(.clk(clk), .d(regdstD), .q(regdstE), .en(clr));
	defparam E7.n = 4;
	dffre_flush E7(.clk(clk), .d(alu_ctrD), .q(alu_ctrE), .en(clr));
	defparam E8.n = 5;
	dffre_flush E8(.clk(clk), .d(rsD), .q(rsE), .en(clr));
	defparam E9.n = 5;
	dffre_flush E9(.clk(clk), .d(rtD), .q(rtE), .en(clr));
	defparam E10.n = 5;
	dffre_flush E10(.clk(clk), .d(rdD), .q(rdE), .en(clr));
	dffre_flush E11(.clk(clk), .d(RD1D), .q(RD1E), .en(clr));
	dffre_flush E12(.clk(clk), .d(RD2D), .q(RD2E), .en(clr));
	dffre_flush E13(.clk(clk), .d(ImmD), .q(ImmE), .en(clr));
	dffre_flush E14(.clk(clk), .d(instrD), .q(instrE), .en(clr));
	defparam E15.n = 1;
	dffre_flush E15(.clk(clk), .d(ss_chD), .q(ss_chE), .en(clr));
	dffre_pc E16(.clk(clk), .d(PC_8D), .q(PC_8E), .en(clr));
	defparam E17.n = 1;
	dffre_flush E17(.clk(clk), .d(ext_bh), .q(ext_bh_E), .en(clr));
	defparam E18.n = 2;
	dffre_flush E18(.clk(clk), .d(ext_sh), .q(ext_sh_E), .en(clr));
	defparam E19.n = 1;
	dffre_flush E19(.clk(clk), .d(isSB), .q(isSB_E), .en(clr));
	defparam E20.n = 1;
	dffre_flush E20(.clk(clk), .d(isSH), .q(isSH_E), .en(clr));
endmodule
