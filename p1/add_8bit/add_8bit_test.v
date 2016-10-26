`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:26:04 10/24/2015
// Design Name:   adder_8bit
// Module Name:   D:/project/p1/add_8bit/add_8bit_test.v
// Project Name:  add_8bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: adder_8bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module add_8bit_test;

	// Inputs
	reg [7:0] A;
	reg [7:0] B;
	reg C0;

	// Outputs
	wire [7:0] SUM;
	wire Overflow;

	// Instantiate the Unit Under Test (UUT)
	adder_8bit uut (
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
		#10 A=8'b1;
		#10 B=8'b1;
		#10 C0=1;
        
		// Add stimulus here

	end
      
endmodule

