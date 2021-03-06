`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:08:26 10/20/2015 
// Design Name: 
// Module Name:    dig 
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
module dig(a,b,c,d,e,f,g,x0,x1,x2,x3);
	input x0,x1,x2,x3;
	output a,b,c,d,e,f,g;
	reg a,b,c,d,e,f,g;
	always@(*)
		begin
			case({x0,x1,x2,x3})
				4'b0000:
					begin
						a=1;
						b=1;
						c=1;
						d=1;
						e=1;
						f=1;
						g=0;
					end
				4'b0001:
					begin
						a=0;
						b=0;
						c=0;
						d=0;
						e=1;
						f=1;
						g=0;
					end
				4'b0010:
					begin
						a=1;
						b=0;
						c=1;
						d=1;
						e=0;
						f=1;
						g=1;
					end
				4'b0011:
					begin
						a=1;
						b=0;
						c=0;
						d=1;
						e=1;
						f=1;
						g=1;
					end
				4'b0100:
					begin
						a=0;
						b=1;
						c=0;
						d=0;
						e=1;
						f=1;
						g=1;
					end
				4'b0101:
					begin
						a=1;
						b=1;
						c=0;
						d=1;
						e=1;
						f=0;
						g=1;
					end
				4'b0110:
					begin
						a=1;
						b=1;
						c=1;
						d=1;
						e=1;
						f=0;
						g=1;
					end
				4'b0111:
					begin
						a=1;
						b=0;
						c=0;
						d=0;
						e=1;
						f=1;
						g=0;
					end
				4'b1000:
					begin
						a=1;
						b=1;
						c=1;
						d=1;
						e=1;
						f=1;
						g=1;
					end
				4'b1001:
					begin
						a=1;
						b=1;
						c=0;
						d=1;
						e=1;
						f=1;
						g=1;
					end
				4'b1010:
					begin
						a=1;
						b=1;
						c=1;
						d=0;
						e=1;
						f=1;
						g=1;
					end
				4'b1011:
					begin
						a=1;
						b=1;
						c=1;
						d=1;
						e=1;
						f=1;
						g=1;
					end
				4'b1100:
					begin
						a=1;
						b=1;
						c=1;
						d=1;
						e=0;
						f=0;
						g=0;
					end
				4'b1101:
					begin
						a=1;
						b=1;
						c=1;
						d=1;
						e=1;
						f=1;
						g=0;
					end
				4'b1110:
					begin
						a=1;
						b=1;
						c=1;
						d=1;
						e=0;
						f=0;
						g=1;
					end
				4'b1111:
					begin
						a=1;
						b=1;
						c=1;
						d=0;
						e=0;
						f=0;
						g=1;
					end
				endcase
			end
endmodule
