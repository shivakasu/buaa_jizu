module md(D1,D2,HiLo,Op,Start,We,Busy,HI,LO,Clk,Rst);
   input          Clk,Rst,HiLo,Start,We,Busy;
	input  [1:0]   Op;
   input  [31:0]  D1,D2;
   output [31:0]  HI,LO;
	reg    [31:0]  HI,LO;
	wire   [63:0]  prod;
   wire   [65:0]  produ;
    
   assign  prod =  {{32{D1[31]}},D1}*{{32{D2[31]}},D2} , produ =  {1'b0,D1}*{1'b0,D2} ;
   integer i;
   

endmodule
