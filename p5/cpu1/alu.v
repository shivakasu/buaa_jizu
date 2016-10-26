`include "define.v"
module ALU (ALUResult, ALUcontrol, ALUOpA, ALUOpB);
	input [3:0]		ALUcontrol;	
	input [31:0]	ALUOpA, ALUOpB;
   output [31:0]	ALUResult;
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
			`aluop_lui:
				ALUResult = (ALUOpA+ALUOpB)<<16;
			default:
				ALUResult = 32'b1;
		endcase
	end
endmodule