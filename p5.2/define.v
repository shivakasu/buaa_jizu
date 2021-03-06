//R-Type
`define opcode_rtype	   6'b000000
`define funcode_add	   6'b100000
`define funcode_addu	   6'b100001
`define funcode_sub	   6'b100010
`define funcode_subu	   6'b100011
`define funcode_mult	   6'b011000
`define funcode_multu	6'b011001
`define funcode_div	   6'b011010
`define funcode_divu 	6'b011011
`define funcode_sll	   6'b000000
`define funcode_srl	   6'b000010
`define funcode_sra	   6'b000011
`define funcode_sllv 	6'b000100
`define funcode_srlv 	6'b000110
`define funcode_srav 	6'b000111
`define funcode_and	   6'b100100
`define funcode_or	   6'b100101
`define funcode_xor	   6'b100110
`define funcode_nor	   6'b100111
`define funcode_slt	   6'b101010
`define funcode_sltu 	6'b101011
`define funcode_mfhi 	6'b010000
`define funcode_mflo 	6'b010010
`define funcode_mthi 	6'b010001
`define funcode_mtlo 	6'b010011
//I-Type
`define opcode_lb	      6'b100000
`define opcode_lh	      6'b100001
`define opcode_lw	      6'b100011
`define opcode_lbu	   6'b100100
`define opcode_lhu	   6'b100101
`define opcode_sb  	   6'b101000
`define opcode_sh  	   6'b101001
`define opcode_sw  	   6'b101011
`define opcode_addi  	6'b001000
`define opcode_addiu  	6'b001001
`define opcode_andi  	6'b001100
`define opcode_ori  	   6'b001101
`define opcode_xori  	6'b001110
`define opcode_lui  	   6'b001111
`define opcode_slti  	6'b001010
`define opcode_sltiu  	6'b001011
`define opcode_beq  	   6'b000100
`define opcode_bne  	   6'b000101
`define opcode_blez  	6'b000110
`define opcode_bgtz  	6'b000111
`define opcode_bltz  	6'b000001
`define opcode_bgez  	6'b000001
//J-Type
`define opcode_j	      6'b000010
`define opcode_jal	   6'b000011
`define funcode_jr	   6'b001000
`define funcode_jalr    6'b001001

//control signal Aluop
`define aluop_add	      4'b0001
`define aluop_addu	   4'b0010
`define aluop_sub	      4'b0011
`define aluop_subu	   4'b0100
`define aluop_or	      4'b0101
`define aluop_xor	      4'b0110
`define aluop_nor	      4'b0111
`define aluop_and	      4'b1000
`define aluop_lui	      4'b1001
`define aluop_sll	      4'b1010
`define aluop_slt 	   4'b1011
`define aluop_sra	      4'b1100
`define aluop_sltu	   4'b1101
`define aluop_srl	      4'b1110
//`define aluop_srlv	   4'b1111


`define	opfield		   31:26
`define	rs			      25:21	
`define	rt			      20:16	
`define	immediate	   15:0
`define	rd			      15:11	
`define	funct	         5:0
`define	shift	         10:6	

`define  R              3'b000
`define  B              3'b001
`define  J              3'b010
`define  JR             3'b011



`define opcodec0      	6'b010000
`define mfc0s        	5'b00000
`define mtc0s        	5'b00100
`define erets        	6'b011000


//CP0
`define CP0_REG_STATUS    5'b01100       //�ɶ�д
`define CP0_REG_CAUSE    5'b01101        //ֻ��
`define CP0_REG_EPC    5'b01110          //�ɶ�д
`define CP0_REG_PrId    5'b01111         //ֻ��