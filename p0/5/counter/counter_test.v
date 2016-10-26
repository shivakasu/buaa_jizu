`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:45:36 10/21/2015
// Design Name:   counter
// Module Name:   D:/project/5/counter/counter_test.v
// Project Name:  counter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module counter_test;

	// Inputs
	reg clock;
	reg clear;

	// Outputs
	wire [3:0] Q;

	// Instantiate the Unit Under Test (UUT)
	counter uut (
		.Q(Q), 
		.clock(clock), 
		.clear(clear)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		clear = 0;

		#10 clock=1;
		#10;clear=1;

	end
      
endmodule

