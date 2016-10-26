module IF_ID(input         clk,en,clr,
             input  [31:0] RD,PC_4F,
				 output [31:0] PC_4D,PC_8D,instrD
				 );

	dff_pcf  D1 (.clk(clk), .d(PC_4F), .q(PC_4D), .en(en), .clr(clr));
	dff_ins  D2 (.clk(clk), .d(RD), .q(instrD), .en(en), .clr(clr));
	assign PC_8D=PC_4D+8;
	
endmodule