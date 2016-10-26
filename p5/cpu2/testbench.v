module testbench;
reg	clk;
reg	rst;
wire[31:0]	D_NPC;
wire[31:0]	D_IR;
wire[31:0]	ALUResult;
wire[31:0]	MEMDataOut;
MIPS MIPS (
	clk,
	rst,
	D_NPC,
	D_IR,
	ALUResult,
	MEMDataOut
);

always
 #10 clk =~clk;

  initial 
  begin
   $readmemh ("code.txt",MIPS.IF.coderom.memory );
	$readmemh ("data.txt",MIPS.MEM.dataram.mem );
	clk=0;rst=1;
   #100 rst=0;
  end
endmodule
