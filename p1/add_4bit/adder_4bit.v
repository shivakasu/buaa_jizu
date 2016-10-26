`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:20:51 10/22/2015 
// Design Name: 
// Module Name:    adder_4bit 
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
`include "add1.v"
module adder_4bit(A,B,C0,SUM,Overflow);
	input[3:0] A,B;
	input C0;
	output[3:0] SUM;
	output Overflow;
	add1 f0(A[0],B[0],C0,SUM[0],cin1);
	add1 f1(A[1],B[1],cin1,SUM[1],cin2);
	add1 f2(A[2],B[2],cin2,SUM[2],cin3);
	add1 f3(A[3],B[3],cin3,SUM[3],Overflow);
endmodule
