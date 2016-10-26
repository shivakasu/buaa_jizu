module ext_dm(A,Din,Op,DOut);
   input  [1:0]  A,Op;
	input  [31:0] Din;
	output [31:0] DOut;
	reg    [31:0] DOut;
   reg    [7:0]  b;
	reg    [15:0] half;
	always@(A or Op)
	begin
	case({A,Op})
	   4'b0000:  //sign_byte
		   begin
		   b = Din[7:0];
			DOut = {{24{b[7]}}, b};
		   end
		4'b0100:
		   begin
		   b = Din[15:8];
			DOut = {{24{b[7]}}, b};
		   end
		4'b1000:
		   begin
		   b = Din[23:16];
			DOut = {{24{b[7]}}, b};
		   end
		4'b1100:
		   begin
		   b = Din[31:24];
			DOut = {{24{b[7]}}, b};
		   end
		4'b0001:  //unsign_byte
		   begin
		   b = Din[7:0];
			DOut = {24'b0, b};
		   end
		4'b0101:
		   begin
		   b = Din[15:8];
			DOut = {24'b0, b};
		   end
		4'b1001:
		   begin
		   b = Din[23:16];
			DOut = {24'b0, b};
		   end
		4'b1101:
		   begin
		   b = Din[31:24];
			DOut = {24'b0, b};
		   end
		4'b0010:    //sign_half
         begin
		   half = Din[15:0];
			DOut = {{16{half[15]}}, half};
		   end
      4'b0110:
         begin
		   half = Din[15:0];
			DOut = {{16{half[15]}}, half};
		   end			
      4'b1010:
         begin
		   half = Din[31:16];
			DOut = {{16{half[15]}}, half};
		   end
		4'b1110:
         begin
		   half = Din[31:16];
			DOut = {{16{half[15]}}, half};
		   end
		4'b0011:    //unsign_half
         begin
		   half = Din[15:0];
			DOut = {16'b0, half};
		   end
      4'b0111:
         begin
		   half = Din[15:0];
			DOut = {16'b0, half};
		   end			
      4'b1011:
         begin
		   half = Din[31:16];
			DOut = {16'b0, half};
		   end	
      4'b1111:
         begin
		   half = Din[31:16];
			DOut = {16'b0, half};
		   end				
	endcase
	end
endmodule
