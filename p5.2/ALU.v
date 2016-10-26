`include "define.v"
module ALU (C, Op, A, B);
   input  [3:0]    Op;	
	input  [31:0]   A, B;
   output [31:0]	 C;
	reg             Over;
   reg    [31:0]	 C;
	reg    [4:0]    s;  //shift_code
	reg    [63:0]   ss; //sra
   reg    [32:0]   result;//overflow_judge,sltu
	reg    [31:0]   st;//slt
	always @(A or B or Op)
	begin
		case (Op)
			`aluop_add:
			   begin
				result = {A[31],A} + {B[31],B};
				C = result[31:0];
				Over = result[32] ^ result[31];
				end
			`aluop_addu:
			   begin
				C = A + B;
				Over = 0;
				end
			`aluop_sub:
				begin
				result = {A[31],A} - {B[31],B};
				C = result[31:0];
				Over = result[32] ^ result[31];
				end
			`aluop_subu:
				begin
				C = A - B;
				Over = 0;
				end
			`aluop_or:
				begin
				C = A | B;
				Over = 0;
				end
			`aluop_xor:
				begin
				C = A ^ B;
				Over = 0;
				end
			`aluop_nor:
				begin
				C = ~(A | B);
				Over = 0;
				end
			`aluop_and:
				begin
				C = A & B;
				Over = 0;
				end
			`aluop_lui:
				begin
				C = (A + B) ;//<< 16;
				Over = 0;
				end
			`aluop_sll:
				begin
				s = A[4:0];
				C = B << s;
				Over = 0;
				end
			`aluop_srl:
				begin
				s = A[4:0];
				C = B >> s;
				Over = 0;
				end
			`aluop_sra:
				begin
				s = A[4:0];
				ss = {{32{B[31]}},B} >> s;
				C = ss[31:0];
				Over = 0;
				end
			`aluop_slt:
				begin
				C = $signed(A)<$signed(B);//{31'b0,st[31]};
				Over = 0;
				end
			`aluop_sltu:
				begin
				result= {1'b0,A} - {1'b0,B};
				C = {31'b0,result[32]};
				Over = 0;
				end
		endcase 
	end
endmodule



