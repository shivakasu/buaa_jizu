module ext_dm(A,Din,Op,DOut);    //extend byte_word and half_word
   input  [1:0]  A;
	input  [2:0]  Op;
	input  [31:0] Din;
	output [31:0] DOut;
	reg    [31:0] DOut;
   reg    [7:0]  b;
	reg    [15:0] half;
	always@(*)
	begin
	case({A,Op})
	   5'b00010:  //sign_byte
		   begin
		   b = Din[7:0];
			DOut = {{24{b[7]}}, b};
		   end
		5'b01010:
		   begin
		   b = Din[15:8];
			DOut = {{24{b[7]}}, b};
		   end
		5'b10010:
		   begin
		   b = Din[23:16];
			DOut = {{24{b[7]}}, b};
		   end
		5'b11010:
		   begin
		   b = Din[31:24];
			DOut = {{24{b[7]}}, b};
		   end
		5'b00001:  //unsign_byte
		   begin
		   b = Din[7:0];
			DOut = {24'b0, b};
		   end
		5'b01001:
		   begin
		   b = Din[15:8];
			DOut = {24'b0, b};
		   end
		5'b10001:
		   begin
		   b = Din[23:16];
			DOut = {24'b0, b};
		   end
		5'b11001:
		   begin
		   b = Din[31:24];
			DOut = {24'b0, b};
		   end
		5'b00100:    //sign_half
         begin
		   half = Din[15:0];
			DOut = {{16{half[15]}}, half};
		   end
      5'b01100:
         begin
		   half = Din[15:0];
			DOut = {{16{half[15]}}, half};
		   end			
      5'b10100:
         begin
		   half = Din[31:16];
			DOut = {{16{half[15]}}, half};
		   end
		5'b11100:
         begin
		   half = Din[31:16];
			DOut = {{16{half[15]}}, half};
		   end
		5'b00011:    //unsign_half
         begin
		   half = Din[15:0];
			DOut = {16'b0, half};
		   end
      5'b01011:
         begin
		   half = Din[15:0];
			DOut = {16'b0, half};
		   end			
      5'b10011:
         begin
		   half = Din[31:16];
			DOut = {16'b0, half};
		   end	
      5'b11011:
         begin
		   half = Din[31:16];
			DOut = {16'b0, half};
		   end			
      5'b00000:    //lw
         DOut = Din;
      5'b01000:
         DOut = Din;			
      5'b10000:
         DOut = Din;	
      5'b11000:
         DOut = Din;
      default
         DOut = Din;
	endcase
	end
endmodule
