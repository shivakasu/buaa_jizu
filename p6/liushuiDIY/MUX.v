`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:22:15 11/23/2015 
// Design Name: 
// Module Name:    MUX 
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
module mux_2_32b(a0,a1,ch,out
    );
	input [31:0] a0,a1;
	input ch;
	output [31:0] out;
	wire [31:0] out;
	assign out=(ch==0)?a0:a1;

endmodule

module mux_3_32b(a0,a1,a2,ch,out
    );
	input [31:0] a0,a1,a2;
	input [1:0] ch;
	output [31:0] out;
	wire [31:0] out;
	assign out=
					(ch==2'b00)?a0:
					(ch==2'b01)?a1:
					a2;

endmodule

module mux_4_32b(a0,a1,a2,a3,ch,out
    );
	input [31:0] a0,a1,a2,a3;
	input [1:0] ch;
	output [31:0] out;
	wire [31:0] out;
	assign out=
					(ch==2'b00)?a0:
					(ch==2'b01)?a1:
					(ch==2'b10)?a2:
					a3;

endmodule

module mux_5_32b(a0,a1,a2,a3,a4,ch,out
    );
	input [31:0] a0,a1,a2,a3,a4;
	input [2:0] ch;
	output [31:0] out;
	wire [31:0] out;
	assign out=
					(ch==3'b000)?a0:
					(ch==3'b001)?a1:
					(ch==3'b010)?a2:
					(ch==3'b011)?a3:
					a4;

endmodule

module mux_6_32b(a0,a1,a2,a3,a4,a5,ch,out
    );
	input [31:0] a0,a1,a2,a3,a4,a5;
	input [2:0] ch;
	output [31:0] out;
	wire [31:0] out;
	assign out=
					(ch==3'b000)?a0:
					(ch==3'b001)?a1:
					(ch==3'b010)?a2:
					(ch==3'b011)?a3:
					(ch==3'b100)?a4:
					a5;

endmodule

module mux_11_32b (a0 , a1 , a2 , a3 , a4 , a5 , a6 , a7 , a8 , a9 , a10 , ch , out );
  input   [31:0]     a0 , a1 , a2 , a3 ,a4 ,a5 , a6 , a7 , a8 , a9 , a10 ;
  input   [3:0]      ch                    ;
  output  [31:0]     out                   ;
  wire    [31:0]     out                   ;
  
  assign  out   =   (ch == 4'b0000) ? a0    :
                    (ch == 4'b0001) ? a1    :
                    (ch == 4'b0010) ? a2    :
                    (ch == 4'b0011) ? a3    :
                    (ch == 4'b0100) ? a4    :
                    (ch == 4'b0101) ? a5    :
                    (ch == 4'b0110) ? a6    :
                    (ch == 4'b0111) ? a7    :
                    (ch == 4'b1000) ? a8    :
                    (ch == 4'b1001) ? a9    :
                    (ch == 4'b1010) ? a10   :
                                     32'b0 ;
endmodule 

module mux_2_5b(a0,a1,ch,out
    );
	input [4:0] a0,a1;
	input ch;
	output [4:0] out;
	wire [4:0] out;
	assign out=(ch==0)?a0:a1;

endmodule

module mux_3_5b(a0,a1,a2,ch,out
    );
	input [4:0] a0,a1,a2;
	input [1:0] ch;
	output [4:0] out;
	wire [4:0] out;
	assign out=
					(ch==2'b00)?a0:
					(ch==2'b01)?a1:
					a2;

endmodule