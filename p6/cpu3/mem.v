module MEM(
//input
	    clk,
	    M_WriteMem,
	    M_ALUResult,
	    M_B,
		 M_BE,
//output
	    MEMDataOut
	    );
    input clk, M_WriteMem;
    input [31:0] M_ALUResult;
    input [31:0] M_B;
	 input [3:0]  M_BE;
    output [31:0] MEMDataOut;
    datamem dataram(
	    .A(M_ALUResult[12:2]),
	    .Clk(clk),
	    .WD(M_B),
	    .We(M_WriteMem),
	    .RD(MEMDataOut),
	    .BE(M_BE));
endmodule
	
	