module 	EXE(
	// input
	E_RegDes,E_ALUSrcB,
	E_ALUcontrol,
	E_A,E_B,E_I,
	E_RT,E_RD,E_PcToReg,
	// output
	ALUResult,
	mrd,mb
	);
	input E_RegDes,E_ALUSrcB,E_PcToReg;
	input [3:0] E_ALUcontrol;
	input [31:0] E_A,E_B,E_I;
	input [4:0] E_RT,E_RD;	
	output [31:0] ALUResult;
	output [4:0] mrd;
	output [31:0] mb;
	
	wire [31:0] ALUOpB;
	assign ALUOpB = E_ALUSrcB?E_B:E_I;
	assign mrd = E_RegDes?E_RD:E_PcToReg?5'b11111:E_RT;
	assign mb = E_B;
	ALU ALU(.ALUResult(ALUResult),.ALUcontrol(E_ALUcontrol), .ALUOpA(E_A), .ALUOpB(ALUOpB));
endmodule
