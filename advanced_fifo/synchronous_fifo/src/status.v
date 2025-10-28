//status block (to set or reset the flags)
module status #(parameter PTR_WIDTH=4)
(clk,rst_n,ren,wen,wptr,rptr,full,empty,overflow,underflow,threshold);
  input ren,wen;
  input clk,rst_n;
  input [PTR_WIDTH:0] wptr,rptr;
  output reg full,empty,underflow,overflow,threshold;
  wire [PTR_WIDTH:0]diff;
  
  assign diff = wptr - rptr;
always@(posedge clk or negedge rst_n)begin
if(!rst_n)begin
full <= 0; empty <= 1; overflow <= 0; underflow <= 0; threshold <= 0;
end
else begin
    empty <= (rptr==wptr);	//empty
    full  <= ((wptr[PTR_WIDTH-1:0] == rptr[PTR_WIDTH-1:0])&& (wptr[PTR_WIDTH] != rptr[PTR_WIDTH]));	//full
    
    threshold <= diff[PTR_WIDTH] | diff[PTR_WIDTH-1];
    //underflow
    underflow <= (ren && empty);
    //overflow
    overflow <= (wen && full);
  end
end
endmodule
