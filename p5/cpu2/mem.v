module MEM(
//input
	clk,
	M_WriteMem,
	M_ALUResult,
	M_B,
//output
	MEMDataOut
	);
input clk, M_WriteMem;
input [31:0] M_ALUResult;
input [31:0] M_B;
output [31:0] MEMDataOut;
datamem dataram(
	.addr(M_ALUResult[11:2]),
	.clk(clk),
	.data(M_B),
	.we(M_WriteMem),
	.q(MEMDataOut));
endmodule
	
	