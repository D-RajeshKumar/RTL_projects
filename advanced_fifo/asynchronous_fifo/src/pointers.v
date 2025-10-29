//write pointer module
module write_pointer #(parameter PTR_WIDTH=4)
  (
 input wclk,
 input wrst_n,
  input wen,
  input full,
  output reg [PTR_WIDTH:0] wptr_bin,
  output [PTR_WIDTH:0] wptr_gray
);
  //binary write pointer
  always@(posedge wclk or negedge wrst_n)begin
    if(!wrst_n)begin
      wptr_bin <= {(PTR_WIDTH+1){1'b0}};
    end
    else if((~full) && wen)
      wptr_bin <= wptr_bin+1'b1;
  end
  //gray write pointer
  assign wptr_gray = (wptr_bin >> 1) ^ wptr_bin;
endmodule


//read pointer module
module read_pointer #(parameter PTR_WIDTH=4)
  (
    input rclk,
    input rrst_n,
    input ren,
    input empty,
    output reg [PTR_WIDTH:0] rptr_bin,
    output [PTR_WIDTH:0] rptr_gray
  );
  //binary read pointer 
  always@(posedge rclk or negedge rrst_n)begin
    if(!rrst_n)
      rptr_bin <= {(PTR_WIDTH+1){1'b0}};
    else if (ren && (!empty))
      rptr_bin <= rptr_bin + 1'b1;
  end
  //gray read pointer
  assign rptr_gray = (rptr_bin >> 1)^rptr_bin;
endmodule
