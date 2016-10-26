module EX_MEM(input         clk,regwriteE,memwriteE,ext_bh_E,
              input  [3:0]  BE,
              input  [1:0]  memtoregE,ext_sh_E,
              input  [31:0] ALU_outE,WriteDataE,PC_8E,
				  input  [4:0]  WriteRegE,
				  output	       regwriteM,memwriteM,ext_bh_M,
				  output [1:0]  memtoregM,ext_sh_M,
				  output [31:0] ALU_outM,WriteDataM,PC_8M,
				  output [4:0]  WriteRegM,
				  output [3:0]  BE_M
						
    );
	defparam M1.n = 1;
	dffre M1(.clk(clk), .d(regwriteE), .q(regwriteM), .en(1'b1));
	defparam M2.n = 2;
	dffre M2(.clk(clk), .d(memtoregE), .q(memtoregM), .en(1'b1));
	defparam M3.n = 1;
	dffre M3(.clk(clk), .d(memwriteE), .q(memwriteM), .en(1'b1));
	dffre M4(.clk(clk), .d(ALU_outE), .q(ALU_outM), .en(1'b1));
	dffre M5(.clk(clk), .d(WriteDataE), .q(WriteDataM), .en(1'b1));
	defparam M6.n = 5;
	dffre M6(.clk(clk), .d(WriteRegE), .q(WriteRegM), .en(1'b1));
	dffre M7(.clk(clk), .d(PC_8E), .q(PC_8M), .en(1'b1));
	defparam M8.n = 4;
	dffre M8(.clk(clk), .d(BE), .q(BE_M), .en(1'b1));
	defparam M9.n = 1;
	dffre M9(.clk(clk), .d(ext_bh_E), .q(ext_bh_M), .en(1'b1));
	defparam M10.n = 2;
	dffre M10(.clk(clk), .d(ext_sh_E), .q(ext_sh_M), .en(1'b1));
endmodule
