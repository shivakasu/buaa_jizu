module timer(input CLK_I,RST_I,WE_I,
             input  [1:0]  ADD_I,
				 input  [31:0] DAT_I,
				 output [31:0] DAT_O,
				 output        IRQ
				 );

   reg    [31:0] CTRL,PRESET,COUNT;
   wire   [27:0] Reserved;
   wire          IM,Enable;
   wire   [1:0]  Mode;
	reg           IRQ;
   assign Reserved = CTRL[31:4];
   assign IM       = CTRL[3];
   assign Mode     = CTRL[2:1];
   assign Enable   = CTRL[0];
   
   always@(posedge CLK_I)
   begin
      if(RST_I)    //��λ
		   begin
		   CTRL   <= 32'b0;
		   PRESET <= 32'b0;
		   COUNT  <= 32'b0;
			IRQ    <= 1'b0;
		   end
	   else if(WE_I)      //д�Ĵ���
		   begin
		   case(ADD_I)
			   2'b00:CTRL   <=DAT_I;
				2'b01:PRESET <=DAT_I;
			endcase
		   end
		else if(count!=32'b0 && Enable)   //������
		   count <= count - 1;
		else if(Mode==2'b00 && IM==1'b1 && count==32'b0)  //ģʽ0+�ж�����+����������
		   IRQ<=1'b1;
		else if(Mode==2'b01 && count==32'b0)     //ģʽ1+����������
		   count<=PRESET;
		
   end

endmodule
