module EXT_OP(in,ext_op,out
    );
	input [15:0] in;
	input [1:0] ext_op;
	output [31:0] out;
	wire [31:0] out;
	wire [31:0] sign,zero,shift;
	assign sign={{16{in[15]}},in};
	assign zero={16'b0,in};
	assign shift={in,16'b0};
	mux_3_32b MUX_ext(.a0(zero),.a1(sign),.a2(shift),.ch(ext_op),.out(out));
	
endmodule
