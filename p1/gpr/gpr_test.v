`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:51:04 10/22/2015
// Design Name:   gpr
// Module Name:   D:/project/p1/gpr/gpr_test.v
// Project Name:  gpr
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: gpr
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module gpr_test;

	// Inputs
	reg clk;
	reg reset;
	reg [4:0] rs1;
	reg [4:0] rs2;
	reg [4:0] rd;
	reg regwrite;
	reg [31:0] wdata;

	// Outputs
	wire [31:0] rdata1;
	wire [31:0] rdata2;

	// Instantiate the Unit Under Test (UUT)
	gpr uut (
		.clk(clk), 
		.reset(reset), 
		.rs1(rs1), 
		.rs2(rs2), 
		.rd(rd), 
		.regwrite(regwrite), 
		.rdata1(rdata1), 
		.rdata2(rdata2), 
		.wdata(wdata)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		rs1 = 0;
		rs2 = 0;
		rd = 0;
		regwrite = 0;
		wdata=0;


		#10 clk=1;reset=1;
		#10 reset=0;
		#10 clk=0;
		#10 clk=1;rs1=5'b00001;
		#10 clk=0;
		#10 clk=1;rs2=5'b01000;
		#10 regwrite=1;
	end
endmodule

