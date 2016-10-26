module dffre2(clk, d, q, en);
parameter n = 32;
input clk, en;
input [n-1:0] d;
output [n-1:0] q;
reg [n-1:0] q;
always @(posedge clk)
	if (en==1)
		q = d ;
	else
	   q=0;
endmodule

module dffre(clk, d, q, en);
parameter n = 32;
input clk, en;
input [n-1:0] d;
output [n-1:0] q;
reg [n-1:0] q;
always @(posedge clk)
	if (en==1)
		q = d ;
endmodule

