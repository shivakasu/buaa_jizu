`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:30:43 11/23/2015 
// Design Name: 
// Module Name:    PC_4 
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
module PC_4(pc,pc_4
    );
	input [31:0] pc;
	output [31:0] pc_4;
	assign pc_4=pc+4;

endmodule
