//write pointer block
module write_pointer #(parameter PTR_WIDTH=4)
(clk,rst_n,wptr,full,wen);
  input clk,rst_n,wen;
  output reg [PTR_WIDTH:0] wptr;
  input full;
  always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
      wptr<={(PTR_WIDTH+1){1'b0}};
    else if((~full)&& wen)
      wptr<=wptr+1'b1;
    else
      wptr<=wptr;
  end
endmodule

//read pointer block
module read_pointer #(parameter PTR_WIDTH=4)
(clk,rst_n,rptr,empty,ren);
  input clk,rst_n;
  output reg [PTR_WIDTH:0]rptr;
  input empty,ren;
  always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
      rptr<={(PTR_WIDTH+1){1'b0}};
    else if((~empty) && ren)
      rptr<= rptr +1'b1;
    else
      rptr<=rptr;
  end
endmodule
