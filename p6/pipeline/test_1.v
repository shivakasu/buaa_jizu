`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:20:00 11/24/2015
// Design Name:   CPU_all
// Module Name:   C:/lab/liushuiDIY/test_1.v
// Project Name:  liushuiDIY
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU_all
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_1;

	// Inputs
	reg clk;
	reg rst;

	// Instantiate the Unit Under Test (UUT)
	CPU_all uut (
		.clk(clk), 
		.rst(rst)
	);
	
	initial begin
		sys_reset;
		$stop;
		test2;
		$stop;
	end

   always#500 clk=~clk;
	
	task	sys_reset;
		begin
			clk=0;
			rst=1;
			#500 rst=0;
		end
	endtask
	
	task	tset1;
		begin
			$readmemh("code.txt",uut.P_IM.im);
			$display("im loaded successfully");
			$readmemh("data.txt",uut.P_DM.DM);
			$display("dm loaded successfully");
			#230000;
		end
	endtask
	
	task	test2;
		begin
			$readmemh("test_a.txt",uut.P_IM.im);
			$display("im loaded successfully");
			$readmemh("data_a.txt",uut.P_DM.DM);
			$display("dm loaded successfully");
			#500000;
		end
	endtask
			
	initial begin
		$display("\n TIME PC INSTR OPCODE DATA");
		$monitor($time,,"%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h",uut.NPC_out,uut.PC_4P,uut.BoJ,uut.NPC,uut.PC,uut.PC_4D,uut.PC_8D,uut.instrF,uut.instrD,uut.memreadE,uut.stallF,uut.stallD,uut.flushE,uut.forwardAD,uut.forwardBD,uut.forwardAE,uut.forwardBE,uut.npc_sel,uut.B_type,uut.zero,uut.alusrcD,uut.ALU_outM,uut.WriteRegM,uut.ResultW,uut.regdstD,uut.regdstE);
	end

   
endmodule

      

