//R-Type
`define opcode_rtype	6'b000000
`define funcode_add	6'b100000
`define funcode_addu	6'b100001
`define funcode_sub	6'b100010
`define funcode_subu	6'b100011
`define funcode_and	6'b100100
`define funcode_or	6'b100101
`define funcode_slt	6'b101010
`define funcode_mult	6'b011000
`define funcode_nor	6'b100111
`define funcode_xor	6'b100110
`define funcode_div	6'b011010
//I-Type
`define opcode_lw	6'b100011
`define opcode_sw	6'b101011
`define opcode_addi	6'b001000
`define opcode_andi	6'b001100
`define opcode_ori	6'b001101
`define opcode_beq	6'b000100
`define opcode_bne	6'b000101
`define opcode_bgez	6'b000001
`define opcode_lui	6'b001111
`define opcode_bgtz	6'b000111
`define opcode_blez	6'b000110
`define opcode_bltz	6'b000001
`define opcode_xori	6'b001110
//J-Type
`define opcode_j	   6'b000010
`define opcode_jal	6'b000011
`define opcode_jr	   6'b000000
`define funcode_jr	6'b001000

//control signal Aluop
`define aluop_addu	5'b00001
`define aluop_subu	5'b00010
`define aluop_and	5'b00011
`define aluop_or	5'b00100
`define aluop_slt	5'b00101
`define aluop_lw	5'b00110
`define aluop_sw	5'b00111
`define aluop_addi	5'b01000
`define aluop_andi	5'b01001
`define aluop_ori	5'b01010
`define aluop_beq	5'b01011
`define aluop_bne	5'b01100
`define aluop_nor	5'b01101
`define aluop_bgez	5'b01110
`define aluop_lui	5'b01111
`define aluop_bgtz	5'b10000
`define aluop_blez	5'b10001
`define aluop_bltz	5'b10010
`define aluop_xor	5'b10011
`define aluop_xori	5'b10100
`define aluop_mult	5'b10101
`define aluop_div	5'b10110


`define	opfield		31:26	// 6-bit operation code
`define	rs			25:21	// 5-bit source register specifier
`define	rt			20:16	// 5-bit source/dest register specifier 
`define	immediate	15:0	// 16-bit immediate, branch or address disp
`define	rd			15:11	// 5-bit destination register specifier
`define	funct	5:0		// 6-bit function field