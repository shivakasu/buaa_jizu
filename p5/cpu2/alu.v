`include "define.v"
module ALU (ALUResult, ALUcontrol, ALUOpA, ALUOpB,ALULR);
   input [4:0]    ALUcontrol;	
	input [31:0]   ALUOpA, ALUOpB;
   output [31:0]	ALUResult;
	output [63:0]  ALULR;
	reg [63:0]     ALULR;
   reg [31:0]		ALUResult;

	always @(ALUOpA or ALUOpB or ALUcontrol)
	begin
		case (ALUcontrol)
			`aluop_addu:
				ALUResult = ALUOpA + ALUOpB;
			`aluop_subu:
				ALUResult = ALUOpA - ALUOpB;
			`aluop_and:
				ALUResult = ALUOpA & ALUOpB;
			`aluop_or:
				ALUResult = ALUOpA | ALUOpB;
			`aluop_slt:
				ALUResult = (ALUOpA < ALUOpB);
			`aluop_lw:
				ALUResult = ALUOpA + ALUOpB;
			`aluop_sw:
				ALUResult = ALUOpA + ALUOpB;
			`aluop_addi:
				ALUResult = ALUOpA + ALUOpB;
			`aluop_andi:
				ALUResult = ALUOpA & ALUOpB;
			`aluop_ori:
				ALUResult = ALUOpA | ALUOpB;
			`aluop_beq:
				ALUResult = ALUOpA - ALUOpB;
			`aluop_bne:
				ALUResult = ALUOpA - ALUOpB;
			`aluop_nor:
				ALUResult = ~(ALUOpA | ALUOpB);
			`aluop_bgez:
				ALUResult = ALUOpA - ALUOpB;
			`aluop_bgtz:
				ALUResult = ALUOpA - ALUOpB;
			`aluop_blez:
				ALUResult = ALUOpA - ALUOpB;
			`aluop_bltz:
				ALUResult = ALUOpA - ALUOpB;
			`aluop_lui:
				ALUResult = (ALUOpA+ALUOpB)<<16;
			`aluop_xor:
				ALUResult = ALUOpA ^ ALUOpB;
			`aluop_xori:
				ALUResult = ALUOpA ^ ALUOpB;
			`aluop_mult:
				ALULR = {{32{ALUOpA[31]}},ALUOpA}*{{32{ALUOpB[31]}},ALUOpB};
			`aluop_div:
			   case({ALUOpA[31],ALUOpB[31]})
               2'b00   : 
					   ALULR = {ALUOpA%ALUOpB,ALUOpA/ALUOpB};
               2'b01   : 
					   ALULR = {ALUOpA%(-ALUOpB),-(ALUOpA/(-ALUOpB))};
               2'b10   : 
					   ALULR = {-((-ALUOpA)%ALUOpB),-((-ALUOpA)/ALUOpB)};
               2'b11   : 
					   ALULR = {-((-ALUOpA)%(-ALUOpB)),(-ALUOpA)/(-ALUOpB)};
				endcase
			default:
				ALUResult = 32'b1;
		endcase 
	end
endmodule