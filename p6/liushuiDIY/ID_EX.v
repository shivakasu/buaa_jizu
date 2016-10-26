`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:26:56 11/23/2015 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX(clk,clr,regwriteD,memtoregD,memwriteD,memreadD,alu_ctrD,alusrcD,regdstD,
							regwriteE,memtoregE,memwriteE,memreadE,alu_ctrE,alusrcE,regdstE,
							RD1D,RD2D,
							RD1E,RD2E,
							rsD,rtD,rdD,
							rsE,rtE,rdE,
							ImmD,ImmE,
							PC_8D,PC_8E,
							instrD,instrE,
							ss_chD,ss_chE
    );
	input clk,clr;
	input regwriteD,memwriteD,memreadD,alusrcD,ss_chD;
	input [1:0] memtoregD,regdstD;
	input [3:0] alu_ctrD;
	input [31:0] RD1D,RD2D,ImmD;
	input [4:0] rsD,rtD,rdD;
	input [31:0] PC_8D;
	input [31:0] instrD;
	
	output [31:0] RD1E,RD2E,ImmE;
	output [4:0] rsE,rtE,rdE;
	output regwriteE,memtoregE,memwriteE,memreadE,alusrcE,ss_chE;
	output [1:0] regdstE;
	output [3:0] alu_ctrE;
	output [31:0] PC_8E;
	output [31:0] instrE;
	
	reg [31:0] RD1E,RD2E,ImmE;
	reg [4:0] rsE,rtE,rdE;
	reg regwriteE,memwriteE,memreadE,alusrcE,ss_chE;
	reg [1:0] memtoregE,regdstE;
	reg [3:0] alu_ctrE;
	reg [31:0] PC_8E;
	reg [31:0] instrE;
	
	initial begin
		rsE=0;
		rtE=0;
		rdE=0;
		regwriteE=0;
		regdstE=0;
	end
	
	always@(posedge clk)
	begin
		if(clr)
		begin
			regwriteE<=0;
			memtoregE<=0;
			memwriteE<=0;
			memreadE<=0;
			alusrcE<=0;
			regdstE<=0;
			alu_ctrE<=3'b000;
			rsE<=5'b00000;
			rtE<=5'b00000;
			rdE<=5'b00000;
			RD1E<=32'h0000_0000;
			RD2E<=32'h0000_0000;
			ImmE<=32'h0000_0000;
			PC_8E<=32'h0000_3008;
			instrE<=32'h0000_0000;
			ss_chE<=1'b0;
		end
		else
		begin
			regwriteE<=regwriteD;
			memtoregE<=memtoregD;
			memwriteE<=memwriteD;
			memreadE<=memreadD;
			alusrcE<=alusrcD;
			regdstE<=regdstD;
			alu_ctrE<=alu_ctrD;
			rsE<=rsD;
			rtE<=rtD;
			rdE<=rdD;
			RD1E<=RD1D;
			RD2E<=RD2D;
			ImmE<=ImmD;
			PC_8E<=PC_8D;
			instrE<=instrD;
			ss_chE<=ss_chD;
		end
	end
endmodule
