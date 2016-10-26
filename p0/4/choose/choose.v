`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:30:02 10/20/2015 
// Design Name: 
// Module Name:    choose 
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
module choose(A0,A1,A2,A3,addr,M,N);
	input A0,A1,A2,A3;
	input[1:0] addr;
	input N;
	output M;
	reg M;
	always@(*)
		begin
			if(!N)
				case(addr)
				2'b00:M=A0;
				2'b01:M=A1;
				2'b10:M=A2;
				2'b11:M=A3;
				endcase
			else
				M=0;
		end
endmodule
