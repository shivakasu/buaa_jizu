`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:23:11 10/24/2015 
// Design Name: 
// Module Name:    add_8bit 
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
module adder_8bit(A,B,C0,SUM,Overflow);
	input[7:0] A,B;
	input C0;
	output[7:0] SUM;
	output Overflow;
	add1 f0(A[0],B[0],C0,SUM[0],cin1);
	add1 f1(A[1],B[1],cin1,SUM[1],cin2);
	add1 f2(A[2],B[2],cin2,SUM[2],cin3);
	add1 f3(A[3],B[3],cin3,SUM[3],cin4);
	add1 f4(A[4],B[4],cin4,SUM[4],cin5);
	add1 f5(A[5],B[5],cin5,SUM[5],cin6);
	add1 f6(A[6],B[6],cin6,SUM[6],cin7);
	add1 f7(A[7],B[7],cin7,SUM[7],Overflow);
endmodule
