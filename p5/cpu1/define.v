//R-Type
`define opcode_rtype	6'b000000
`define funcode_add	6'b100000
`define funcode_addu	6'b100001
`define funcode_sub	6'b100010
`define funcode_subu	6'b100011
`define funcode_and	6'b100100
`define funcode_or	6'b100101
`define funcode_slt	6'b101010
//I-Type
`define opcode_lw	6'b100011
`define opcode_sw	6'b101011
`define opcode_addi	6'b001000
`define opcode_andi	6'b001100
`define opcode_ori	6'b001101
`define opcode_beq	6'b000100
`define opcode_bne	6'b000101
`define opcode_lui	6'b001111
//J-Type
`define opcode_j	   6'b000010
`define opcode_jal	6'b000011
`define opcode_jr	   6'b000000
`define funcode_jr	6'b001000

//control signal Aluop
`define aluop_addu	4'b0001
`define aluop_subu	4'b0010
`define aluop_and	4'b0011
`define aluop_or	4'b0100
`define aluop_slt	4'b0101
`define aluop_lw	4'b0110
`define aluop_sw	4'b0111
`define aluop_addi	4'b1000
`define aluop_andi	4'b1001
`define aluop_ori	4'b1010
`define aluop_beq	4'b1011
`define aluop_bne	4'b1100
`define aluop_lui	4'b1111


`define	opfield		31:26	// 6-bit operation code
`define	rs			25:21	// 5-bit source register specifier
`define	rt			20:16	// 5-bit source/dest register specifier 
`define	immediate	15:0	// 16-bit immediate, branch or address disp
`define	rd			15:11	// 5-bit destination register specifier
`define	funct	5:0		// 6-bit function field