module MIPS_test() ;
    reg clk,rst;
    
    mips My_CPU(.clk(clk),.rst(rst));
    
	 initial begin
        sys_reset;
        test;
        $stop;
    end
    always  
        #(100/2) clk = ~clk ;
    
    task    sys_reset;
      begin
        clk     = 0 ;
        rst     = 1 ;
        #(100*0.6) rst = 0;
      end
    endtask
    
    task  test ;      
        begin
            $readmemh ("code.txt",My_CPU.My_IM.rom )  ;
            $display  ("rom loaded  successfully")  ;
            $readmemh ("data.txt",My_CPU.My_DM.ram )  ;
            $display  ("ram loaded  successfully")  ;
            #23000  ;
        end
    endtask
               
    
    initial
    begin
      $display("\n  TIME    PC    INSTR   OPCODE    DATA  ");
      $monitor($time,,"%h  %h  %b  %h",My_CPU.PC , My_CPU.INSTR , My_CPU.INSTR[31:26] , My_CPU.RD2)  ;
    end
        
endmodule