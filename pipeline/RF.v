`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:32:19 11/23/2015 
// Design Name: 
// Module Name:    RF 
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
module RF(Clk,Rst,A1,A2,A3,We,WD,RD1,RD2
    );
	input [4:0] A1,A2,A3;
	input We;
	input Clk,Rst;
	input [31:0] WD;
	output [31:0] RD1,RD2;
	wire [31:0] RD1,RD2;
	reg [31:0] RF [0:31];
	integer i;
	assign RD1=RF[A1];
	assign RD2=RF[A2];
	always@(posedge Clk or posedge Rst)
	begin
		if(Rst)
			for(i=0;i<32;i=i+1)
				case(i)
				28:RF[i]=32'h0000_1800;
				29:RF[i]=32'h0000_2ffc;
				default:RF[i]=32'b0;
				endcase
		else if(We)
			if(A3!=5'b00000)
				RF[A3]=WD;
	end
endmodule
