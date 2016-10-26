module PC(input clk,rst,en,
          input  [31:0] npc,
			 output [31:0] pc,pc_4
			 );

	reg [31:0] pc;
	always@(posedge clk or posedge rst)
	begin
		if(rst)
			pc<=32'h0000_3000;
		else if(en)
			pc<=npc;
	end
   assign pc_4 = pc+4;
endmodule
