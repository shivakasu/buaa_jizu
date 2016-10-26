`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:14:07 10/19/2015 
// Design Name: 
// Module Name:    count 
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
module add1(
    input a,
    input b,
    input cin,
    output sum,
    output cout
    );
	assign {cout,sum}=a+b+cin;

endmodule
