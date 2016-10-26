module ext (din,ext_op,dout);
    input[15:0] din;
    input[1:0]  ext_op;  
    output[31:0] dout;                                           
    wire[31:0] unsign,sign,shift;
    assign unsign={16'b0,din};
    assign sign={{16{din[15]}},din};
    assign shift={din,16'b0};
    mux_3_32b MUX_ext(.a0(unsign),.a1(sign),.a2(shift),.ch(ext_op),.out(dout));
endmodule