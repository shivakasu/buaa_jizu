module MEM_WB(input          clk,RegWriteM,isMFC0M,isMTC0M,
              input  [1:0]   MemtoRegM,
				  input  [2:0]   ext_sh_M,
				  input  [31:0]  ReadDataM,ALU_outM,
				  input  [4:0]   WriteRegM,
				  output	        RegWriteW,isMFC0W,isMTC0W,
				  output [1:0]   MemtoRegW,
				  output [2:0]   ext_sh_W,
				  output [31:0]  ReadDataW,ALU_outW,
				  output [4:0]   WriteRegW
				  );

	
	defparam W1.n = 1;
	dffre W1(.clk(clk), .d(RegWriteM), .q(RegWriteW), .en(1'b1));
	defparam W2.n = 2;
	dffre W2(.clk(clk), .d(MemtoRegM), .q(MemtoRegW), .en(1'b1));
	dffre W3(.clk(clk), .d(ReadDataM), .q(ReadDataW), .en(1'b1));
	dffre W4(.clk(clk), .d(ALU_outM), .q(ALU_outW), .en(1'b1));
	defparam W5.n = 5;
	dffre W5(.clk(clk), .d(WriteRegM), .q(WriteRegW), .en(1'b1));
	dffre W6(.clk(clk), .d(PC_8M), .q(PC_8W), .en(1'b1));
	defparam W7.n = 3;
	dffre W7(.clk(clk), .d(ext_sh_M), .q(ext_sh_W), .en(1'b1));
	defparam W8.n = 1;
	dffre W8(.clk(clk), .d(isMFC0M), .q(isMFC0W), .en(1'b1));
	defparam W9.n = 1;
	dffre W9(.clk(clk), .d(isMTC0M), .q(isMTC0W), .en(1'b1));
	
endmodule
