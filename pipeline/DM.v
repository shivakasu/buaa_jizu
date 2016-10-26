`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:46 11/23/2015 
// Design Name: 
// Module Name:    DM 
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
module DM(Clk,A,WD,We,RD
    );
	input Clk;
	input [11:2] A;
	input [31:0] WD;
	input We;
	output [31:0] RD;
	reg [31:0] DM [0:1023];
	assign RD=DM[A];
	always@(posedge Clk)
	begin
		if(We)
			DM[A]<=WD;
	end

endmodule
