module gpr (clk,rst,readreg1,readreg2,writereg,we,writedata,readdata1,readdata2);
    input[4:0] readreg1,readreg2,writereg;
    input we;
    input clk,rst;
    input[31:0] writedata;
    output[31:0] readdata1 , readdata2;
    reg[31:0] register[0:31];
    integer i;
    assign readdata1=register[readreg1];
    assign readdata2=register[readreg2];
    always @(posedge clk or posedge rst)
      begin
        if(rst)
          for(i=0;i<32;i=i+1)
            case(i) 
              28 :register[i]  <=  32'h0000_1800 ;
              29 :register[i]  <=  32'h0000_2ffc ;
              default:register[i]  <=  32'b0 ;
            endcase 
        else if(we)
            register[writereg]<=writedata;
      end
endmodule