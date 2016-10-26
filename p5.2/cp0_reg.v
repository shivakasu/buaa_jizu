`include "define.v"
module cp0_reg(clk,rst,A1,A2,DIn,PC,ExcCode,HWInt,We,EXLSet,EXLClr,IntReq,EPC,DOut);

	input         clk,rst,We,EXLSet,EXLClr;
	input  [4:0]  A1,A2,ExcCode;
	input  [31:0] DIn;
	input  [5:0]  HWInt;
	input  [29:0] PC;
	output        IntReq;
	output [29:0] EPC;
	output [31:0] DOut;
	 
	reg    [5:0]  im;
	reg           exl,ie;
	reg    [5:0]  hwint;
	reg    [29:0] EPC;
	reg    [31:0] PRId,DOut;

	always @ (posedge clk or posedge rst)
	   begin
		if(rst)
		   begin
			im    <= 16'b0;
			exl   <= 1'b0;
			ie    <= 1'b0;
			hwint <= 6'b0;
			EPC   <= 30'b0;
			PRId  <= 32'h12345678;
		   end
		else
		   begin
			hwint <= HWInt;
		   if(EXLSet)
			   exl <= 1'b1;
			if(EXLClr)
			   exl <= 1'b0;
		   if(We)
			   begin
				case (A2) 
					`CP0_REG_STATUS:
					   begin
						im  <= DIn[15:10];
						exl <= DIn[1];
						ie  <= DIn[0];
						end
					`CP0_REG_EPC:
					   EPC <= PC;					
				endcase
			   end
			end
	   end
			
	always @ (*) begin
		if(rst)
			DOut <= 32'b0;
		else
		   begin
				case (A1) 
					`CP0_REG_STATUS: DOut <= {16'b0,im,8'b0,exl,ie};
					`CP0_REG_CAUSE:  DOut <= {16'b0,hwint,10'b0};
					`CP0_REG_EPC:    DOut <= EPC;
					`CP0_REG_PrId:   DOut <= PRId;
               default          DOut <= 32'b0;					
				endcase		
		   end
	end

endmodule
