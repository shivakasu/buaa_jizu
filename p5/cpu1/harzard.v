module hazard_FWD(rst,E_WriteReg,W_WriteReg,M_WriteReg,
				      E_RD,M_RD,W_RegWriteAddr,RsAddr,RtAddr,
				      FWDA,FWDB);
   input rst,E_WriteReg,W_WriteReg,M_WriteReg;
	input [4:0] E_RD,M_RD,W_RegWriteAddr,RsAddr,RtAddr;
	output [1:0] FWDA,FWDB;
	assign FWDA[0] = rst?0:((E_WriteReg && (E_RD != 0) && (E_RD ==RsAddr)) || (W_WriteReg && (W_RegWriteAddr != 0) && (E_RD !=RsAddr) && (M_RD !=RsAddr) && (W_RegWriteAddr == RsAddr)));
	assign FWDA[1] = rst?0:((M_WriteReg && (M_RD!=0) && (E_RD !=RsAddr) && (M_RD==RsAddr)) || (W_WriteReg && (W_RegWriteAddr != 0) && (E_RD !=RsAddr) && (M_RD !=RsAddr) && (W_RegWriteAddr == RsAddr)));
	assign FWDB[0] = rst?0:(E_WriteReg && (E_RD != 0) && (E_RD ==RtAddr)) || (W_WriteReg && (W_RegWriteAddr != 0) && (E_RD !=RtAddr) && (M_RD !=RtAddr) && (W_RegWriteAddr == RtAddr));
	assign FWDB[1] = rst?0:(M_WriteReg && (M_RD!=0) && (E_RD !=RtAddr) && (M_RD==RtAddr)) || (W_WriteReg && (W_RegWriteAddr != 0) && (E_RD !=RtAddr) && (M_RD !=RtAddr) && (W_RegWriteAddr == RtAddr));
endmodule
