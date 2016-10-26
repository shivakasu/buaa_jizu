module RegFile (
	RsData, RtData,// Outputs  
	clk, RegWriteData, RegWriteAddr, RegWriteEn, RsAddr, RtAddr,rst //Inputs
);

	input		clk,rst;
	input [31:0]	RegWriteData;
	input [4:0]	RegWriteAddr;
	input		RegWriteEn;
	input [4:0]	RsAddr, RtAddr;
	output [31:0]	RsData;		// data output A
	output [31:0]	RtData;		// data output B
	reg [31:0]	regs [0:31]; 

	assign RsData = (RsAddr == 5'b0) ? 32'b0 : regs[RsAddr];
	assign RtData = (RtAddr == 5'b0) ? 32'b0 : regs[RtAddr];
	
	integer i;
	always @ (negedge clk) 
	begin
	   if(rst)
          for(i=0;i<32;i=i+1)
              regs[i] <= 32'b0 ;
		else if (RegWriteEn)
			regs[RegWriteAddr] <= RegWriteData;
	end
endmodule
