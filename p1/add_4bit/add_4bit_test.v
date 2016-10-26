`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:32:45 10/22/2015
// Design Name:   adder_4bit
// Module Name:   D:/project/p1/add_4bit/add_4bit_test.v
// Project Name:  add_4bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: adder_4bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module add_4bit_test;

	// Inputs
	reg [3:0] A;
	reg [3:0] B;
	reg C0;

	// Outputs
	wire [3:0] SUM;
	wire Overflow;

	// Instantiate the Unit Under Test (UUT)
	adder_4bit uut (
		.A(A), 
		.B(B), 
		.C0(C0), 
		.SUM(SUM), 
		.Overflow(Overflow)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		C0 = 0;

		// Wait 100 ns for global reset to finish
		#10 A=4'b1000;
      #10 B=4'b0001;
		#10 B=B+1;
		#10 B=B+1;
		#10 B=B+1;
		#10 B=B+1;
		#10 B=4'b1111;
		// Add stimulus here

	end
      
endmodule

