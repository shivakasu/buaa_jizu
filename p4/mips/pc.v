module pc (clk,rst,npc,pc);
    input clk , rst ;
    input[31:0] npc;
    output[31:0] pc;
    reg[31:0] pc; 
    always@(posedge clk or posedge rst)
        if(rst)
          pc<=32'h0000_3000;
        else
          pc<=npc;
endmodule