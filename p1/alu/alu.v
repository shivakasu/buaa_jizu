`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:36:36 10/22/2015 
// Design Name: 
// Module Name:    alu 
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
module alu(ALU_DA,ALU_DB,ALUOp,ALU_DC,ALU_zero);
	input[31:0] ALU_DA,ALU_DB;
	input[2:0] ALUOp;
	output[31:0] ALU_DC;
	reg[31:0] ALU_DC;
	output ALU_zero;
	reg ALU_zero;
	always@(*)
	begin
	case(ALUOp)
		3'b000: ALU_DC<=ALU_DA+ALU_DB;
		3'b001: ALU_DC<=ALU_DA-ALU_DB;
		3'b010: ALU_DC<=ALU_DA&ALU_DB;
		3'b100: ALU_DC<=ALU_DA|ALU_DB;
		3'b101: ALU_DC<=ALU_DA^ALU_DB;
	endcase
	if(ALU_DC==32'b0)
		ALU_zero<=1;
	else
		ALU_zero<=0;
	end
endmodule
