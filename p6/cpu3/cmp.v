module cmp(A,B,Op,Br);
   input  [31:0]  A,B;
	input  [2:0]   Op;
	output         Br;
	reg            Br;
	always@(A or B or Op)
      begin
		case(Op)
		   3'b000:   //beq
			Br = (A == B);
			3'b001:   //bne
			Br = (A != B);
			3'b010:   //bgez
			Br = (A[31] == 0);	
         3'b011:   //bgtz
         Br = ((A[31]==0) && (A != 32'b0));
         3'b100:   //blez
         Br = ((A[31] == 1) || (A == 32'b0));
         3'b101:   //bltz
         Br = (A[31] == 1);			
		endcase
		end
endmodule
