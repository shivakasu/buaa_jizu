`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:55:54 10/19/2015
// Design Name:   compare
// Module Name:   D:/project/3/compare/compare_test.v
// Project Name:  compare
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: compare
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module compare_test;

	// Inputs
	reg A0;
	reg A1;
	reg A2;
	reg A3;
	reg A4;
	reg A5;
	reg A6;
	reg A7;
	reg B0;
	reg B1;
	reg B2;
	reg B3;
	reg B4;
	reg B5;
	reg B6;
	reg B7;
	reg ALBI;
	reg AEBI;
	reg AGBI;

	// Outputs
	wire ALBO;
	wire AEBO;
	wire AGBO;

	// Instantiate the Unit Under Test (UUT)
	compare uut (
		.A0(A0), 
		.A1(A1), 
		.A2(A2), 
		.A3(A3), 
		.A4(A4), 
		.A5(A5), 
		.A6(A6), 
		.A7(A7), 
		.B0(B0), 
		.B1(B1), 
		.B2(B2), 
		.B3(B3), 
		.B4(B4), 
		.B5(B5), 
		.B6(B6), 
		.B7(B7), 
		.ALBI(ALBI), 
		.AEBI(AEBI), 
		.AGBI(AGBI), 
		.ALBO(ALBO), 
		.AEBO(AEBO), 
		.AGBO(AGBO)
	);

	initial begin
		// Initialize Inputs
		A0 = 0;
		A1 = 0;
		A2 = 0;
		A3 = 0;
		A4 = 0;
		A5 = 0;
		A6 = 0;
		A7 = 0;
		B0 = 0;
		B1 = 0;
		B2 = 0;
		B3 = 0;
		B4 = 0;
		B5 = 0;
		B6 = 0;
		B7 = 0;
		ALBI = 0;
		AEBI = 0;
		AGBI = 0;
		
		#10 A0=1;
		#10 B0=1;
		#10 B1=1;
	end
      
endmodule

