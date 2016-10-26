module IM(add,instr);
	input [11:2] add;
	output [31:0] instr;
	reg [31:0] im [0:1023];
	assign instr=im[add];

endmodule


