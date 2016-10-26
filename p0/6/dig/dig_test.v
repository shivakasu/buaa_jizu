`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:31:07 10/21/2015
// Design Name:   dig
// Module Name:   D:/project/6/dig/dig_test.v
// Project Name:  dig
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: dig
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module dig_test;

	// Inputs
	reg x0;
	reg x1;
	reg x2;
	reg x3;

	// Outputs
	wire a;
	wire b;
	wire c;
	wire d;
	wire e;
	wire f;
	wire g;

	// Instantiate the Unit Under Test (UUT)
	dig uut (
		.a(a), 
		.b(b), 
		.c(c), 
		.d(d), 
		.e(e), 
		.f(f), 
		.g(g), 
		.x0(x0), 
		.x1(x1), 
		.x2(x2), 
		.x3(x3)
	);

	initial begin
		// Initialize Inputs
		x0 = 0;
		x1 = 0;
		x2 = 0;
		x3 = 0;

		#10 x0=1;
		#10 x1=1;
		

	end
	
      
endmodule

