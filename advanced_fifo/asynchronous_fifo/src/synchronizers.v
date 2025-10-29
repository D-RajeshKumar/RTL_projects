
//to Synchronize Read Pointer into Write Clock Domain
module read2write #(parameter PTR_WIDTH=4)
  (
    input wclk,
    input wrst_n,
    input [PTR_WIDTH:0] rptr_gray,
    output reg [PTR_WIDTH:0] rptr_gray_sync
  );
  reg [PTR_WIDTH:0] rptr_d1;
  
  always@(posedge wclk or negedge wrst_n)begin
    if(!wrst_n)
    {rptr_gray_sync,rptr_d1} <= 0;
    else begin
      rptr_d1 <= rptr_gray;
      rptr_gray_sync <= rptr_d1;
    end
  end
endmodule

//to Synchronize write pointer to read module
module write2read #(parameter PTR_WIDTH=4)
  (
    input rclk,
    input rrst_n,
    input [PTR_WIDTH:0] wptr_gray,
    output reg [PTR_WIDTH:0] wptr_gray_sync
  );
  reg [PTR_WIDTH:0] wptr_d1;
  always@(posedge rclk or negedge rrst_n)begin
    if(!rrst_n)
    {wptr_d1,wptr_gray_sync} <=0;
    else
      begin
        wptr_d1 <= wptr_gray;
        wptr_gray_sync <= wptr_d1;
      end
  end
endmodule
