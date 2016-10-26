`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:10:06 10/22/2015
// Design Name:   alu
// Module Name:   D:/project/p1/alu/alu_test.v
// Project Name:  alu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu_test;

	// Inputs
	reg [31:0] ALU_DA;
	reg [31:0] ALU_DB;
	reg [2:0] ALUOp;

	// Outputs
	wire [31:0] ALU_DC;
	wire ALU_zero;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.ALU_DA(ALU_DA), 
		.ALU_DB(ALU_DB), 
		.ALUOp(ALUOp), 
		.ALU_DC(ALU_DC), 
		.ALU_zero(ALU_zero)
	);

	initial begin
		// Initialize Inputs
		ALU_DA = 0;
		ALU_DB = 0;
		ALUOp = 0;

		// Wait 100 ns for global reset to finish
		#10 ALUOp=3'b001;
		#10 ALU_DA=32'b1;
		#10 ALU_DB=32'b1;
		#10 ALUOp=3'b001;
		#10 ALU_DA=ALU_DA+32'b1;
		#10 ALUOp=3'b101;
        
		// Add stimulus here

	end
      
endmodule

