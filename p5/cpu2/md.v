module md ( da, db , clk , mdwr , h32 , l32 ); // alu
    input  [31:0] da , db   ;   // input data da and db
    input  clk          ;
    input  [2:0]  mdwr  ;
    output [31:0] h32 , l32   ;   // result data output
    reg    [31:0] h32 , l32   ;
    wire   [63:0] prod        ;
    wire   [65:0] produ       ;
    
    assign  prod =  {{32{da[31]}},da}*{{32{db[31]}},db} , produ =  {1'b0,da}*{1'b0,db} ;
    
    always @(posedge clk)
        case(mdwr)
          3'b000  :   begin
                        h32 <=  prod[63:32]           ;
                        l32 <=  prod[31:0]            ;
                      end
          3'b001  :   begin
                        h32 <=  produ[63:32]           ;
                        l32 <=  produ[31:0]            ;
                      end
          3'b010  :   begin
                        case({da[31],db[31]})
                          2'b00   : begin
                                      l32 <=  da/db           ;
                                      h32 <=  da%db           ;
                                    end
                          2'b01   : begin
                                      l32 <=  -({da}/{-db})   ;
                                      h32 <=  {da}%{-db}      ;
                                    end
                          2'b10   : begin
                                      l32 <=  -({-da}/{db})   ;
                                      h32 <=  -({-da}%{db})   ;
                                    end
                          2'b11   : begin
                                      l32 <=  {-da}/{-db}     ;
                                      h32 <=  -({-da}%{-db})  ;
                                    end
                          default : begin
                                      l32 <=  32'hfexx550d   ;
                                      h32 <=  32'hfexx550d   ;
                                    end
                          endcase
                      end
          3'b011  :   begin
                        l32 <=  {1'b0,da}/{1'b0,db}   ;
                        h32 <=  {1'b0,da}%{1'b0,db}   ;
                      end
          3'b100  :   begin
                        h32 <=  da   ;
                      end
          3'b101  :   begin
                        l32 <=  da   ;
                      end
        endcase
endmodule 