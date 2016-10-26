`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:53:43 11/23/2015 
// Design Name: 
// Module Name:    EX_MEM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module EX_MEM(clk,regwriteE,memtoregE,memwriteE,ALU_outE,WriteDataE,WriteRegE,
						regwriteM,memtoregM,memwriteM,ALU_outM,WriteDataM,WriteRegM,
						PC_8E,PC_8M
    );
	input clk;
	input regwriteE,memwriteE;
	input [1:0] memtoregE;
	output regwriteM,memwriteM;
	output [1:0] memtoregM;
	reg regwriteM,memwriteM;
	reg [1:0] memtoregM;
	input [31:0] ALU_outE;
	output [31:0] ALU_outM;
	reg [31:0] ALU_outM;
	input [31:0] WriteDataE;
	output [31:0] WriteDataM;
	reg [31:0] WriteDataM;
	input [4:0] WriteRegE;
	output [4:0] WriteRegM;
	reg [4:0] WriteRegM;
	
	input [31:0] PC_8E;
	output [31:0] PC_8M;
	reg [31:0] PC_8M;
	initial begin
		WriteRegM=5'b0;
	end
	
	always@(posedge clk)
	begin
		regwriteM<=regwriteE;
		memtoregM<=memtoregE;
		memwriteM<=memwriteE;
		ALU_outM<=ALU_outE;
		WriteDataM<=WriteDataE;
		WriteRegM<=WriteRegE;
		PC_8M<=PC_8E;
	end
endmodule
