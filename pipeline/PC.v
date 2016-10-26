`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:19:28 11/23/2015 
// Design Name: 
// Module Name:    PC 
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
module PC(clk,rst,en,npc,pc
    );
	input clk,rst,en;
	input [31:0] npc;
	output [31:0] pc;
	reg [31:0] pc;

	always@(posedge clk or posedge rst)
	begin
		if(rst)
			pc<=32'h0000_3000;
		else if(en)
			pc<=npc;
	end

endmodule
