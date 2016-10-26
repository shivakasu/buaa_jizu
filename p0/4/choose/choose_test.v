`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:46:45 10/20/2015
// Design Name:   choose
// Module Name:   D:/project/4/choose/choose_test.v
// Project Name:  choose
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: choose
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module choose_test;

	// Inputs
	reg A0;
	reg A1;
	reg A2;
	reg A3;
	reg [1:0] addr;
	reg N;

	// Outputs
	wire M;

	// Instantiate the Unit Under Test (UUT)
	choose uut (
		.A0(A0), 
		.A1(A1), 
		.A2(A2), 
		.A3(A3), 
		.addr(addr), 
		.M(M), 
		.N(N)
	);

	initial begin
		// Initialize Inputs
		A0 = 0;
		A1 = 0;
		A2 = 0;
		A3 = 0;
		addr = 0;
		N = 0;

	#10 A0=1;
	#10 A1=1;
	#10 addr=01;

	end
      
endmodule

