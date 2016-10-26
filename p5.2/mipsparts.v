//******************************************************************************
// small part MUX and DFF 
//******************************************************************************
module dffre_flush(clk, d, q, en);   //flush the ID/EXE
   parameter n = 32;
   input clk, en;
   input [n-1:0] d;
   output [n-1:0] q;
   reg [n-1:0] q;
	initial begin
		q=0;
	end
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
	initial begin
		q=0;
	end
   always @(posedge clk)
	   if (en==1)
	   	q <= d ;
endmodule


module dff_pcf(clk, d, q, en, clr);    //stall for pc in IF/ID
   parameter n = 32;
   input clk, en, clr;
   input [n-1:0] d;
   output [n-1:0] q;
   reg [n-1:0] q;
	initial begin
		q=32'h0000_3000;
	end
	always@(posedge clk)
	begin
   if(clr)
			q<=32'h0000_3000;
	else if(en)
			q<=d;
	end
endmodule

module dff_ins(clk, d, q, en, clr);    //stall for instr in IF/ID
   parameter n = 32;
   input clk, en, clr;
   input [n-1:0] d;
   output [n-1:0] q;
   reg [n-1:0] q;
	initial begin
		q=32'h000000_00000_00000_00000_00000_100001;
	end
	always@(posedge clk)
	begin
   if(clr)
			q<=32'h0000_0000;
	else if(en)
			q<=d;
	end
endmodule

module mux_2_32b(a0,a1,ch,out
    );
	input [31:0] a0,a1;
	input ch;
	output [31:0] out;
	wire [31:0] out;
	assign out=(ch==0)?a0:a1;

endmodule

module mux_3_32b(a0,a1,a2,ch,out
    );
	input [31:0] a0,a1,a2;
	input [1:0] ch;
	output [31:0] out;
	wire [31:0] out;
	assign out=
					(ch==2'b00)?a0:
					(ch==2'b01)?a1:
					a2;

endmodule



module mux_3_5b(a0,a1,a2,ch,out
    );
	input [4:0] a0,a1,a2;
	input [1:0] ch;
	output [4:0] out;
	wire [4:0] out;
	assign out=
					(ch==2'b00)?a0:
					(ch==2'b01)?a1:
					a2;

endmodule
