module DM (A,Clk,WD,We,RD,BE);
   input	 [10:0] A;
	input  [3:0]  BE;
	input	        Clk,We;
	input	 [31:0] WD;
	output [31:0] RD;
	reg [31:0] mem [0:2047];
	always@(posedge Clk) 
	begin
		if (We)
		   case(BE)
			   4'b0001:mem[A][7:0]<=WD[7:0];
				4'b0010:mem[A][15:8]<=WD[7:0];
				4'b0100:mem[A][23:16]<=WD[7:0];
				4'b1000:mem[A][31:24]<=WD[7:0];
				4'b0011:mem[A][15:0]<=WD[15:0];
				4'b1100:mem[A][31:16]<=WD[15:0];
				4'b1111:mem[A]<=WD;
			endcase
	end
	assign RD = mem[A];
endmodule	