module dm_4k (addr,din,we,clk,dout);
    input[11:2] addr;
    input[31:0] din;
    input we; 
    input clk;
    output[31:0] dout;
	 reg[31:0] ram[0:1023];
	 assign dout=ram[addr];
    always@(posedge clk)
      begin
        if(we)
          ram[addr]<=din;
      end
endmodule