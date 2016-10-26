module IM(add,instr);
	input [10:0] add;
	output [31:0] instr;
	reg [31:0] im [0:2047];
	wire [10:0] addr;
	assign addr = {~add[10],add[9:0]};
	assign instr=im[addr];
endmodule


