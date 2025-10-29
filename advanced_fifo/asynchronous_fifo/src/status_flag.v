//status block 
module status #(parameter PTR_WIDTH=4)
  (
    input wclk,
    input wrst_n,
    input rclk,
    input rrst_n,
    input wen,
    input ren,
    input [PTR_WIDTH:0] wptr_bin,
    input [PTR_WIDTH:0] rptr_bin,
    input [PTR_WIDTH:0] wptr_gray,
    input [PTR_WIDTH:0] rptr_gray,
    input [PTR_WIDTH:0] rptr_gray_sync,
    input [PTR_WIDTH:0] wptr_gray_sync,
    output reg full,
    output reg empty,
    output  overflow,
    output  underflow
  );
  always@(posedge wclk or negedge wrst_n)begin
    if(!wrst_n)begin
      full<=0;
    end
    else
      full <= (rptr_gray_sync[PTR_WIDTH-1:0]==wptr_gray[PTR_WIDTH-1:0]) && 							(rptr_gray_sync[PTR_WIDTH] != wptr_gray[PTR_WIDTH]);
  end
  always@(posedge rclk or negedge rrst_n)begin
    if(!rrst_n)begin
      empty<=1;
    end
    else 
      empty <= (wptr_gray_sync == rptr_gray);
  end
  assign overflow = (full && wen);
  assign underflow = (empty && ren);
endmodule
