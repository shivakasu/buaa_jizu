`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:03:46 11/23/2015 
// Design Name: 
// Module Name:    MEM_WB 
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
module MEM_WB(clk,RegWriteM,MemtoRegM,ReadDataM,ALU_outM,WriteRegM,
						RegWriteW,MemtoRegW,ReadDataW,ALU_outW,WriteRegW,
						PC_8M,PC_8W
    );
	input clk;
	input RegWriteM;
	input [1:0] MemtoRegM;
	input [31:0] ALU_outM,ReadDataM;
	input [4:0] WriteRegM;
	input [31:0] PC_8M;
	output RegWriteW;
	output [1:0] MemtoRegW;
	output [31:0] ALU_outW,ReadDataW;
	output [4:0] WriteRegW;
	output [31:0] PC_8W;
	reg RegWriteW;
	reg [1:0] MemtoRegW;
	reg [31:0] ALU_outW,ReadDataW;
	reg [4:0] WriteRegW;
	reg [31:0] PC_8W;
	
	initial begin
		WriteRegW=0;
	end
	
	always@(posedge clk)
	begin
		RegWriteW<=RegWriteM;
		MemtoRegW<=MemtoRegM;
		ReadDataW<=ReadDataM;
		ALU_outW<=ALU_outM;
		WriteRegW<=WriteRegM;
		PC_8W<=PC_8M;
	end
endmodule
