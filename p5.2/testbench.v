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
	

	task	test2;
		begin
			$readmemh("code.txt",cpu.IM.im);
			$readmemh("data_a.txt",cpu.DM.mem);
			#5000000;
		end
	endtask

endmodule

      

