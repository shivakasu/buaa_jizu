`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:39:34 10/19/2015 
// Design Name: 
// Module Name:    compare 
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
module compare(A0,A1,A2,A3,A4,A5,A6,A7,B0,B1,B2,B3,B4,B5,B6,B7,ALBI,AEBI,AGBI,ALBO,AEBO,AGBO);
	input A0,A1,A2,A3,A4,A5,A6,A7,B0,B1,B2,B3,B4,B5,B6,B7,ALBI,AEBI,AGBI;
	output ALBO,AEBO,AGBO;
	reg ALBO,AEBO,AGBO;
	wire[7:0] A_SIGNAL,B_SIGNAL;
	assign A_SIGNAL = {A7,A6,A5,A4,A3,A2,A1,A0};
	assign B_SIGNAL = {B7,B6,B5,B4,B3,B2,B1,B0};
	always@(*) 
		begin 
			if (A_SIGNAL > B_SIGNAL) 
				begin ALBO = 0; AEBO = 0; AGBO = 1;end 
			else if (A_SIGNAL < B_SIGNAL) 
				begin ALBO = 1; AEBO = 0; AGBO = 0;end 
			else 
				begin ALBO = ALBI; AEBO = AEBI; AGBO = AGBI;end
		end
endmodule
