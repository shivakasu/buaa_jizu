`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:40:13 11/23/2015 
// Design Name: 
// Module Name:    ALU 
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
module ALU(A,B,Op,C
    );
	input [31:0] A,B;
	input [3:0] Op;
	output [31:0] C;
	
	wire [31:0] C;
	wire [31:0] add,sub,subu,ori,an_d,xori,no_r,slt,sltu,sll,srl,sra;
	wire [4:0] ss;
	wire [63:0] sraa;
	
	assign add	= A+B;
	assign sub	= A-B;
	assign ori	= A|B;
	assign an_d	= A&B;
	assign xori	= A^B;
	assign no_r	= ~ori;
	assign slt	= {31'b0,sub[31]};
	assign sltu = A<B?32'b1:32'b0;
	
	assign ss  = A[4:0];
	assign sll = B << ss               ;
   assign srl = B >> ss               ;
   assign sraa= {{32{B[31]}},B} >> ss ;
   assign sra = sraa[31:0]            ;
	
	assign zero =!(|sub);
	mux_11_32b MUX_alu(.a0(add),.a1(sub),.a2(ori),.a3(slt),.a4(sltu)
							,.a5(an_d),.a6(xori),.a7(no_r),.a8(sll),.a9(srl),.a10(sra),.ch(Op),.out(C));

endmodule


