module IF (
	// Outputs
	pc, instr,
	// Inputs
	clk,  rst, Branch, WritePC, BranchAddr
);

	input 	clk, rst;
	input		Branch, WritePC;
	input[31:0] BranchAddr;
	output[31:0]   instr;		// current instruction
	output[31:0]   pc;			// address of instruction
  
	reg [31:0]	pc;
	wire [31:0] address;

	always @(posedge clk) 
	begin
		if(rst)
			pc <= 32'h00003000;
		else if (WritePC) 
		begin
			if(Branch)
				pc <= BranchAddr+4;
			else
				pc <= pc + 4;
		end 
		else
			pc <= pc;
	end

	assign address = rst?0:(Branch?BranchAddr:pc);
	instrmem coderom(.address(address[11:2]), .q(instr)); //IM
endmodule