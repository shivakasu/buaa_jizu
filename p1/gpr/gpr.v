`timescale 1ns / 1ps
module gpr(Clk,Reset,RS1,RS2,RD,RegWrite,RData1,RData2,WData);
    input Clk,Reset,RegWrite;
    input[4:0] RS1,RS2,RD;
    input[31:0] WData;
    output[31:0] RData1,RData2;
    reg[31:0] mem[31:0],RData1,RData2;
	 always@(*)
	 begin
	 if(Reset)
		begin
		mem[0]<=32'b0;mem[1]<=32'b0;mem[2]<=32'b0;mem[3]<=32'b0;
		mem[4]<=32'b0;mem[5]<=32'b0;mem[6]<=32'b0;mem[7]<=32'b0;
		mem[8]<=32'b0;mem[9]<=32'b0;mem[10]<=32'b0;mem[11]<=32'b0;
		mem[12]<=32'b0;mem[13]<=32'b0;mem[14]<=32'b0;mem[15]<=32'b0;
		mem[16]<=32'b0;mem[17]<=32'b0;mem[18]<=32'b0;mem[19]<=32'b0;
		mem[20]<=32'b0;mem[21]<=32'b0;mem[22]<=32'b0;mem[23]<=32'b0;
		mem[24]<=32'b0;mem[25]<=32'b0;mem[26]<=32'b0;mem[27]<=32'b0;
		mem[28]<=32'b0;mem[29]<=32'b0;mem[30]<=32'b0;mem[31]<=32'b0;
		end
	 case(RS1)
		5'b00000:RData1<=mem[0];5'b00001:RData1<=mem[1];
		5'b00010:RData1<=mem[2];5'b00011:RData1<=mem[3];
		5'b00100:RData1<=mem[4];5'b00101:RData1<=mem[5];
		5'b00110:RData1<=mem[6];5'b00111:RData1<=mem[7];
		5'b01000:RData1<=mem[8];5'b01001:RData1<=mem[9];
		5'b01010:RData1<=mem[10];5'b01011:RData1<=mem[11];
		5'b01100:RData1<=mem[12];5'b01101:RData1<=mem[13];
		5'b01110:RData1<=mem[14];5'b01111:RData1<=mem[15];
		5'b10000:RData1<=mem[16];5'b10001:RData1<=mem[17];
		5'b10010:RData1<=mem[18];5'b10011:RData1<=mem[19];
		5'b10100:RData1<=mem[20];5'b10101:RData1<=mem[21];
		5'b10110:RData1<=mem[22];5'b10111:RData1<=mem[23];
		5'b11000:RData1<=mem[24];5'b11001:RData1<=mem[25];
		5'b11010:RData1<=mem[26];5'b11011:RData1<=mem[27];
		5'b11100:RData1<=mem[28];5'b11101:RData1<=mem[29];
		5'b11110:RData1<=mem[30];5'b11111:RData1<=mem[31];
	endcase
	case(RS2)
		5'b00000:RData2<=mem[0];5'b00001:RData2<=mem[1];
		5'b00010:RData2<=mem[2];5'b00011:RData2<=mem[3];
		5'b00100:RData2<=mem[4];5'b00101:RData2<=mem[5];
		5'b00110:RData2<=mem[6];5'b00111:RData2<=mem[7];
		5'b01000:RData2<=mem[8];5'b01001:RData2<=mem[9];
		5'b01010:RData2<=mem[10];5'b01011:RData2<=mem[11];
		5'b01100:RData1<=mem[12];5'b01101:RData2<=mem[13];
		5'b01110:RData2<=mem[14];5'b01111:RData2<=mem[15];
		5'b10000:RData2<=mem[16];5'b10001:RData2<=mem[17];
		5'b10010:RData2<=mem[18];5'b10011:RData2<=mem[19];
		5'b10100:RData2<=mem[20];5'b10101:RData2<=mem[21];
		5'b10110:RData2<=mem[22];5'b10111:RData2<=mem[23];
		5'b11000:RData2<=mem[24];5'b11001:RData2<=mem[25];
		5'b11010:RData2<=mem[26];5'b11011:RData2<=mem[27];
		5'b11100:RData2<=mem[28];5'b11101:RData2<=mem[29];
		5'b11110:RData2<=mem[30];5'b11111:RData2<=mem[31];
	endcase
	end
	always@(posedge Clk)
		begin
		if(RegWrite)
			case(RD)
			5'b00000:mem[0]<=WData;5'b00001:mem[1]<=WData;
			5'b00010:mem[2]<=WData;5'b00011:mem[3]<=WData;
			5'b00100:mem[4]<=WData;5'b00101:mem[5]<=WData;
			5'b00110:mem[6]<=WData;5'b00111:mem[7]<=WData;
			5'b01000:mem[8]<=WData;5'b01001:mem[9]<=WData;
			5'b01010:mem[10]<=WData;5'b01011:mem[11]<=WData;
			5'b01100:mem[12]<=WData;5'b01101:mem[13]<=WData;
			5'b01110:mem[14]<=WData;5'b01111:mem[15]<=WData;
			5'b10000:mem[16]<=WData;5'b10001:mem[17]<=WData;
			5'b10010:mem[18]<=WData;5'b10011:mem[19]<=WData;
			5'b10100:mem[20]<=WData;5'b10101:mem[21]<=WData;
			5'b10110:mem[22]<=WData;5'b10111:mem[23]<=WData;
			5'b11000:mem[24]<=WData;5'b11001:mem[25]<=WData;
			5'b11010:mem[26]<=WData;5'b11011:mem[27]<=WData;
			5'b11100:mem[28]<=WData;5'b11101:mem[29]<=WData;
			5'b11110:mem[30]<=WData;5'b11111:mem[31]<=WData;
			endcase
		end
endmodule
