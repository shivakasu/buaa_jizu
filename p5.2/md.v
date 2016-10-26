module md(Clk,Rst,D1,D2,HiLo,Op,Start,We,Busy,HI,LO,isMADDE);
	input         Clk,Rst,Start,We,HiLo,isMADDE;
	input  [31:0] D1,D2;
	input  [1:0]  Op;
	output        Busy;
	output [31:0] HI,LO;
	reg    [31:0] rD1,rD2,rHi,rLo;
	reg    [1:0]  rOp;
	reg           rBusy,risMADDE;
	reg    [63:0] MuR;
	
	assign HI=rHi;
	assign LO=rLo;
	assign Busy=rBusy;
	integer d;
	
	initial begin
		rBusy <=1'b0;
		rHi   <=32'h0000_0000;
		rLo   <=32'h0000_0000;
	end
	
	always@(posedge Clk)
	begin
		if(Rst)
			begin
				rBusy <= 0;
				rHi   <= 32'h0000_0000;
				rLo   <= 32'h0000_0000;
			end
		else if(We)
			begin
				case(HiLo)
					1'b0:	rLo<=D1;
					1'b1:	rHi<=D1;
				endcase
			end
		else if(Start&&!rBusy)
			begin
				rBusy<=1;
				rD1<=D1;
				rD2<=D2;
				rOp<=Op;
				risMADDE<=isMADDE;
				if((Op==2'b00)||(Op==2'b01))
				   d=5;
				else
				   d=10;
			end
		else if(rBusy&&d!=0)
			d=d-1;
		else if(rBusy&&d==0)
			begin
				rBusy<=0;
				case(rOp)
					2'b00:
						begin
							MuR=rD1*rD2;
							rHi<=MuR[63:32];
							rLo<=MuR[31:0];
						end
					2'b01:
						begin
						if(risMADDE)begin
							MuR=$signed(rD1)*$signed(rD2)+$signed({rHi,rLo});
							rHi<=MuR[63:32];
							rLo<=MuR[31:0];end
						else
						begin
						   MuR=$signed(rD1)*$signed(rD2);
							rHi<=MuR[63:32];
							rLo<=MuR[31:0];
						end
						end
					2'b10:
						begin
						   if(rD2!=32'b0)begin
							rHi<=rD1%rD2;
							rLo<=rD1/rD2;end
						end
					2'b11:
						begin
						   if(rD2!=32'b0)begin
							rHi<=$signed(rD1)%$signed(rD2);
							rLo<=$signed(rD1)/$signed(rD2);end
						end
				endcase
			end
	end
endmodule

