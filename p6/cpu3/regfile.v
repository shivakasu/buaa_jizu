module RegFile (A1,A2,A3,RD1,RD2,WD,We,Clk,Rst);
	input		      Clk,Rst,We;
	input  [31:0]	WD;
	input  [4:0]	A3;
	input  [4:0]	A1,A2;
	output [31:0]	RD1;
	output [31:0]	RD2;
	reg    [31:0]	regs [0:31]; 

	assign RD1 = regs[A1];
	assign RD2 = regs[A2];
	
	integer i;
	always @ (negedge Clk) 
	begin
	   if(Rst)
          for(i=0;i<32;i=i+1)
              case(i) 
              28 :regs[i]  <=  32'h0000_1800 ;
              29 :regs[i]  <=  32'h0000_2ffc ;
              default:regs[i]  <=  32'b0 ;
            endcase 
		else if (We)
			regs[A3] <= WD;
	end
endmodule
