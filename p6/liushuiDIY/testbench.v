module testbench;

	// Inputs
	reg clk;
	reg rst;

	// Instantiate the Unit Under Test (UUT)
	mips cpu (
		.clk(clk), 
		.rst(rst)
	);
	
	initial begin
		sys_reset;
		$stop;
		test;
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
	
	task	test;
		begin
			$readmemh("code.txt",cpu.P_IM.im);
			$display("im loaded successfully");
			$readmemh("data.txt",cpu.P_DM.DM);
			$display("dm loaded successfully");
			#230000;
		end
	endtask

   
endmodule

      

