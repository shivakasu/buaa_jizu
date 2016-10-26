`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:30:27 10/24/2015
// Design Name:   adder_32bit
// Module Name:   D:/project/p1/add_32bit/add_32bit_test.v
// Project Name:  add_32bit
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: adder_32bit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module add_32bit_test;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg C0;

	// Outputs
	wire [31:0] SUM;
	wire Overflow;

	// Instantiate the Unit Under Test (UUT)
	adder_32bit uut (
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
		#10 A=32'b10;
		#10 B=32'b11;
		#10 C0=1;
        
		// Add stimulus here

	end
      
endmodule

