`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:28:12 10/24/2015 
// Design Name: 
// Module Name:    add_32bit 
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
module adder_32bit(A,B,C0,SUM,Overflow);
	input[31:0] A,B;
	input C0;
	output[31:0] SUM;
	output Overflow;
	add1 f0(A[0],B[0],C0,SUM[0],cin1);
	add1 f1(A[1],B[1],cin1,SUM[1],cin2);
	add1 f2(A[2],B[2],cin2,SUM[2],cin3);
	add1 f3(A[3],B[3],cin3,SUM[3],cin4);
	add1 f4(A[4],B[4],cin4,SUM[4],cin5);
	add1 f5(A[5],B[5],cin5,SUM[5],cin6);
	add1 f6(A[6],B[6],cin6,SUM[6],cin7);
	add1 f7(A[7],B[7],cin7,SUM[7],cin8);
	add1 f8(A[8],B[8],cin8,SUM[8],cin9);
	add1 f9(A[9],B[9],cin9,SUM[9],cin10);
	add1 f10(A[10],B[10],cin10,SUM[10],cin11);
	add1 f11(A[11],B[11],cin11,SUM[11],cin12);
	add1 f12(A[12],B[12],cin12,SUM[12],cin13);
	add1 f13(A[13],B[13],cin13,SUM[13],cin14);
	add1 f14(A[14],B[14],cin14,SUM[14],cin15);
	add1 f15(A[15],B[15],cin15,SUM[15],cin16);
	add1 f16(A[16],B[16],cin16,SUM[16],cin17);
	add1 f17(A[17],B[17],cin17,SUM[17],cin18);
	add1 f18(A[18],B[18],cin18,SUM[18],cin19);
	add1 f19(A[19],B[19],cin19,SUM[19],cin20);
	add1 f20(A[20],B[20],cin20,SUM[20],cin21);
	add1 f21(A[21],B[21],cin21,SUM[21],cin22);
	add1 f22(A[22],B[22],cin22,SUM[22],cin23);
	add1 f23(A[23],B[23],cin23,SUM[23],cin24);
	add1 f24(A[24],B[24],cin24,SUM[24],cin25);
	add1 f25(A[25],B[25],cin25,SUM[25],cin26);
	add1 f26(A[26],B[26],cin26,SUM[26],cin27);
	add1 f27(A[27],B[27],cin27,SUM[27],cin28);
	add1 f28(A[28],B[28],cin28,SUM[28],cin29);
	add1 f29(A[29],B[29],cin29,SUM[29],cin30);
	add1 f30(A[30],B[30],cin30,SUM[30],cin31);
	add1 f31(A[31],B[31],cin31,SUM[31],Overflow);
endmodule
