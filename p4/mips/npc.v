module npc ( pc , npc_sel , zero , imme , rs ,  npc , pc_4 );
    input[25:0] imme;
    input[31:0] pc;
    input[31:0] rs;
    input[2:0] npc_sel;
    input zero;
    output[31:0] npc;
    output[31:0] pc_4; 
    wire[15:0] offset;
    assign offset=imme[15:0];
    assign pc_4=pc+4;
    parameter R  =  3'b000,
              BEQ=  3'b001,
              J  =  3'b010,
              JR =  3'b011,
              BNE=  3'b100;       
    assign npc=(npc_sel== R)?pc_4:
               ((npc_sel == BEQ && zero) || (npc_sel == BNE && !zero)) ?  pc_4 + {{14{offset[15]}},offset,2'b0}:
               (npc_sel == J)?{pc[31:28],imme,2'b0}:
               (npc_sel == JR)?rs:
                pc_4;
endmodule