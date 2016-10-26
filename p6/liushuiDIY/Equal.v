`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:44:03 11/25/2015 
// Design Name: 
// Module Name:    Equal 
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
module Equal(A,B,Op,Br
    );
	input signed [31:0] A,B;
	input [2:0] Op;
	output Br;
	assign Br	=	(Op==3'b001)?(A==B):
						(Op==3'b010)?(A!=B):
						(Op==3'b011)?(A>=B):
						(Op==3'b100)?(A>0):
						(Op==3'b101)?(A<=0):
						(Op==3'b110)?(A<0):
						1'b0;

endmodule
