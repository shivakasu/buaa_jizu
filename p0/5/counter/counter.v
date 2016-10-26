`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:22:16 10/20/2015 
// Design Name: 
// Module Name:    counter 
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
module counter(Q,clock,clear);
	output[3:0] Q;
	input clock,clear;
	reg[3:0] Q;
	always@(posedge clear or negedge clock)
	begin
		if(clear)
			Q<=4'd0;
		else
			Q<=Q+1;
	end
endmodule
