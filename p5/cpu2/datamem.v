module datamem (addr,clk,data,we,q);
   input	[9:0] addr;
	input	  clk;
	input	[31:0]  data;
	input	  we;
	output	[31:0]  q;
	reg [31:0] mem [0:1023];
	always@(posedge clk) 
	begin
		if (we)
			mem[addr] <= data;
	end
	assign q = mem[addr];
endmodule	