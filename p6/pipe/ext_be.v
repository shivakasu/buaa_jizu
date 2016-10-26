module ext_be(A,b,h,be);
   input [1:0] A;
	input b,h;
	output [3:0] be;
	assign be = ((A==2'b00) & b)? 4'b0001:
	            ((A==2'b01) & b)? 4'b0010:
					((A==2'b10) & b)? 4'b0100:
					((A==2'b11) & b)? 4'b1000:
					((A[1]==0)  & h)? 4'b0011:
					((A[1]==1)  & h)? 4'b1100:
					                  4'b1111;


endmodule
