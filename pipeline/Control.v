`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:35:04 11/23/2015 
// Design Name: 
// Module Name:    Control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Control(instrD,regwriteD,memtoregD,memwriteD,memreadD,alu_ctrD,alusrcD,regdstD,npc_sel,ext_op,B_type,ss_chD
    );

	input [31:0] instrD;
	
	output memwriteD,memreadD,regwriteD,alusrcD,ss_chD;
	output [1:0] memtoregD,regdstD,ext_op;
	output [2:0] npc_sel;
	output [3:0] alu_ctrD;
	output [2:0] B_type;
	
	wire [5:0] Op,code,Func;;
	
	assign Op=instrD[31:26];
	assign code=instrD[20:16];
	assign Func=instrD[5:0];
	
	wire slt	 = (Op == 6'h00) & (Func == 6'h2a);
	wire slti = (Op == 6'h0a);                    // slti
   wire sltu = (Op == 6'h00) & (Func == 6'h2b); // sltu
   wire sltiu= (Op == 6'h0b);                    // sltiu
	
	wire add  = (Op == 6'h00) & (Func == 6'h20); // add 
   wire addu = (Op == 6'h00) & (Func == 6'h21); // addu
   wire sub  = (Op == 6'h00) & (Func == 6'h22); // sub
   wire subu = (Op == 6'h00) & (Func == 6'h23); // subu
   wire o_r  = (Op == 6'h00) & (Func == 6'h25); // or 

   wire an_d = (Op == 6'h00) & (Func == 6'h24); // and
   wire xo_r = (Op == 6'h00) & (Func == 6'h26); // xor
   wire no_r = (Op == 6'h00) & (Func == 6'h27); // nor
	
   wire sll  = (Op == 6'h00) & (Func == 6'h00); // sll
   wire sllv = (Op == 6'h00) & (Func == 6'h04); // sllv
   wire sra  = (Op == 6'h00) & (Func == 6'h03); // sra
   wire srav = (Op == 6'h00) & (Func == 6'h07); // srav
   wire srl  = (Op == 6'h00) & (Func == 6'h02); // srl
   wire srlv = (Op == 6'h00) & (Func == 6'h06); // srlv
	
	wire xori = (Op == 6'h0e);                    // xori
   wire andi = (Op == 6'h0c);                    // andi
   wire addi = (Op == 6'h08);                    // addi
   wire addiu= (Op == 6'h09);                    // addiu

   wire ori  = (Op == 6'h0d);                    // ori
   wire lui  = (Op == 6'h0f);                    // lui
	
	wire lw   = (Op == 6'h23);                    // lw
   wire lb   = (Op == 6'h20);                    // lb
   wire lbu  = (Op == 6'h24);                    // lbu
   wire lh   = (Op == 6'h21);                    // lh
   wire lhu  = (Op == 6'h25);                    // lhu
    
   wire sw   = (Op == 6'h2b);                    // sw
   wire sb   = (Op == 6'h28);                    // sb
   wire sh   = (Op == 6'h29);                    // sh
	
	wire beq	 = (Op == 6'h04);
	wire bne	 = (Op == 6'h05);
	wire bgez = (Op == 6'h01) & (code == 5'h01)    ;// bgez
   wire bgtz = (Op == 6'h07);                    // bgtz
	wire blez = (Op == 6'h06);
   wire bltz = (Op == 6'h01) & (code == 5'h00);                    
	
	wire j    = (Op == 6'h02);                    // j
   wire jal  = (Op == 6'h03);                    // jal
   wire jalr = (Op == 6'h00) & (Func == 6'h09); // jalr
   wire jr   = (Op == 6'h00) & (Func == 6'h08); // jr

	
	parameter       R  =  3'b000,           // R_type
                   B  =  3'b001,           // B_type
                   J  =  3'b010,           // J_type
                   MA =  3'b011;           // lw/sw_type
    
   wire  [2:0]     op  = (add || addu || sub || subu || addi || addiu || slt || slti || 
                         sltu || sltiu || o_r || ori || an_d || andi || lui || xo_r || 
                         xori || no_r || sll || sllv || srl || srlv || sra || srav )                    ? R    :
                         (beq || bne || bgtz || bgez || blez || bltz )                                  ? B    :
                         (j || jal || jr || jalr )                                                      ? J    :
                         (sw || sb || sh || lw || lb || lbu || lh || lhu )                              ? MA   :
                                                                                                           3'bx ;
    // judge u or i
   wire  i   = (addi || addiu || slti || sltiu || ori || lui || andi || xori )       ? 1'b1 :
                                                                                       1'b0 ;
	
				/*(addu || subu || slt || sltu || add || sub || an_d || o_r || xo_r || 
               no_r || sll || sllv || srl || srlv || sra || srav)     					 ?   0 :
               (addi || addiu || slti || sltiu || ori || lui || andi || xori )       ?   1 :
                                                                                       1'b0;*/
   wire  b	 = (beq || bne || bgtz || bgez || blez || bltz );                                                            
   wire  s   = (sw || sb || sh ) ;               
   wire  l   = (lw || lb || lbu || lh || lhu ) ;
	 

	assign regdstD=
						jal?2'b10:
						(i||s||l)?2'b00:
						2'b01;
						
	assign alusrcD=
						(i||l||s)		?1'b1:
											 1'b0;
						
	assign memtoregD=
						(jal||jalr)?2'b10:
						l?2'b01:
						2'b00;
						
	assign regwriteD=
						(s||j||jr||b)?1'b0:1'b1;

						
	assign  npc_sel	=
								b									?   3'b001:
								(j  || jal )               ?   3'b010:
								(jr || jalr)               ?   3'b011:
																		 3'b000;
																						
	assign B_type	=	beq?3'b001:
							bne?3'b010:
							bgez?3'b011:
							bgtz?3'b100:
							blez?3'b101:
							bltz?3'b110:
							3'b000;
							
	assign memwriteD=
							s?1'b1:1'b0;
							
	assign memreadD=
							l?1'b1:1'b0;
							
	assign ext_op=
						lui?2'b10:
						(ori || xori)?2'b00:
						2'b01;
						
	assign alu_ctrD=
						(sub||subu)		?	4'b0001:
						(ori||lui||o_r)?	4'b0010:
						(slt || slti)	?	4'b0011:
						(sltu||sltiu)	?	4'b0100:
						(an_d || andi)	?	4'b0101:
						(xo_r || xori)	?	4'b0110:
						(no_r			)	?	4'b0111:
						(sll || sllv)	?	4'b1000:
						(srl || srlv)	?	4'b1001:
						(sra || srav)	?	4'b1010:
						4'b0000;
	assign ss_chD=
						(sll||srl||sra)?	1'b1:
												1'b0;
	
endmodule
