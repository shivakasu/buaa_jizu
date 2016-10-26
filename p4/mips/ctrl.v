module ctrl (instr,regdst,alusrc,memtoreg,memwrite,regwrite,npc_sel,ext_op,alu_ctr);
    input[31:0] instr;
    output alusrc,regwrite,memwrite;
    output[1:0] memtoreg,regdst,ext_op;
    output[2:0] npc_sel,alu_ctr;
    wire[5:0] opcode,funct; 
    assign opcode=instr[31:26];
    assign funct=instr[5:0];
    
    wire addu = (opcode == 6'h00) & (funct == 6'h21);
    wire subu = (opcode == 6'h00) & (funct == 6'h23);
    wire jr   = (opcode == 6'h00) & (funct == 6'h08);
    wire ori  = (opcode == 6'h0d);
    wire lw   = (opcode == 6'h23);
    wire sw   = (opcode == 6'h2b);
    wire beq  = (opcode == 6'h04);
    wire lui  = (opcode == 6'h0f);
    wire jal  = (opcode == 6'h03);
    
    wire[1:0] memtoreg,regdst,ext_op;
    wire[2:0] npc_sel,alu_ctr;
    assign regdst  =  jal                           ? 2'b10:
                     (addu || subu )                ? 2'b01:
                                                        2'b00;
    assign alusrc  = (addu || subu || beq || jr)    ? 0:
                                                      1;
    assign memtoreg= jal                            ? 2'b10:
                     lw                             ? 2'b01:
                                                      2'b00;
    assign regwrite= (sw || beq || jr)              ? 0:
                                                      1;
    assign npc_sel = beq                            ? 3'b001:
                     jal                            ? 3'b010:
                     jr                             ? 3'b011:
                                                      3'b000;
    assign memwrite= sw                             ? 1:
                                                      0;
    assign ext_op  = lui                            ? 2'b10:
                     ori                            ? 2'b00:
                                                      2'b01;
    assign alu_ctr = (ori  ||  lui )                ? 3'b010:
                     (subu ||  beq )                ? 3'b001:
                                                      3'b000;
endmodule                                                              