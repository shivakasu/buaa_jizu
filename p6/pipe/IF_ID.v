module IF_ID(input clk,en,clr,
             input  [31:0] RD,PC_4F,
				 output [31:0] PC_4D,PC_8D,instrD
				 );
	
	reg [31:0] PC_4D,instrD;
	initial begin
		PC_4D=32'h0000_3000;
		instrD=32'b000000_00000_00000_00000_00000_100001;
	end
	always@(posedge clk)
	begin
		if(clr)
			begin
				PC_4D<=32'h0000_3000;
				instrD<=32'h0000_0000;
			end
		else if(en)
			begin
				PC_4D<=PC_4F;
				instrD<=RD;
			end
	end
	assign PC_8D=PC_4D+8;
endmodule
