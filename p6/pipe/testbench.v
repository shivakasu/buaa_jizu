module testbench;

	reg clk;
	reg rst;

	MIPS cpu (
		.clk(clk), 
		.rst(rst)
	);
	
	initial begin
		sys_reset;
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
			$readmemh("code.txt",cpu.IM.im);
			$display("im loaded successfully");
			$readmemh("data.txt",cpu.DM.mem);
			$display("dm loaded successfully");
			#230000;
		end
	endtask
	

endmodule
