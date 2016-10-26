module dffre_flush(clk, d, q, en);   //flush the ID/EXE
   parameter n = 32;
   input clk, en;
   input [n-1:0] d;
   output [n-1:0] q;
   reg [n-1:0] q;
   always @(posedge clk)
	   if (en==0)
	   	q <= d ;
	   else
	      q<=0;
endmodule

module dffre_pc(clk, d, q, en);     //flush the pc in ID/EXE
   parameter n = 32;
   input clk, en;
   input [n-1:0] d;
   output [n-1:0] q;
   reg [n-1:0] q;
   always @(posedge clk)
	   if (en)
		   q<=32'h0000_3008;
	   else
	      q <= d ;
endmodule


module dffre(clk, d, q, en);    //stall
   parameter n = 32;
   input clk, en;
   input [n-1:0] d;
   output [n-1:0] q;
   reg [n-1:0] q;
   always @(posedge clk)
	   if (en==1)
	   	q <= d ;
endmodule

