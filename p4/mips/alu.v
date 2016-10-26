module alu (a,b,alu_ctr,alu_out,zero);
    input[31:0] a,b;
    input[2:0] alu_ctr;
    output[31:0] alu_out;
    output zero;
    wire[31:0] sub,add,ori;
    assign add=a+b;
    assign sub=a-b;
    assign ori=a|b;            
    assign zero=!(|sub);
    mux_3_32b MUX_alu (.a0(add),.a1(sub),.a2(ori),.ch(alu_ctr[1:0]),.out(alu_out));
endmodule