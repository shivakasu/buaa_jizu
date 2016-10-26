module RegFile (
	RsData, RtData,// Outputs  
	clk, RegWriteData, RegWriteAddr, RegWriteEn, RsAddr, RtAddr,rst,RegWriteData2 //Inputs
);

	input		clk,rst;
	input [31:0]	RegWriteData;
	input [63:0]	RegWriteData2;
	input [4:0]	RegWriteAddr;
	input		RegWriteEn;
	input [4:0]	RsAddr, RtAddr;
	output [31:0]	RsData;		// data output A
	output [31:0]	RtData;		// data output B
	reg [31:0]	regs [0:33]; 

	assign RsData = (RsAddr == 5'b0) ? 32'b0 : regs[RsAddr];
	assign RtData = (RtAddr == 5'b0) ? 32'b0 : regs[RtAddr];
	
	integer i;
	always @ (negedge clk) 
	begin
	   if(rst)
          for(i=0;i<34;i=i+1)
              case(i) 
              28 :regs[i]  <=  32'h0000_1800 ;
              29 :regs[i]  <=  32'h0000_2ffc ;
              default:regs[i]  <=  32'b0 ;
            endcase 
		else if (RegWriteEn)
			regs[RegWriteAddr] <= RegWriteData;
			regs[32] <= RegWriteData2[63:32];
			regs[33] <= RegWriteData2[31:0];
	end
endmodule
