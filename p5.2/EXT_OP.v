module EXT_OP(input  [15:0] in,
              input  [1:0]  ext_op,
				  output [31:0] out
				  );

	wire [31:0] sign,zero,shift;
	assign sign={{16{in[15]}},in};
	assign zero={16'b0,in};
	assign shift={in,16'b0};
	assign out = (ext_op==2'b00)?  zero:
	             (ext_op==2'b10)?  shift:
					                   sign;
endmodule
