//memory array module
module memory_array #(parameter DATA_WIDTH=8,
                      parameter DEPTH=16,
                      parameter PTR_WIDTH=4)
  (
    input wclk,
    input rclk,
    input wen,
    input ren,
    input full,
    input empty,
    input [PTR_WIDTH:0] wptr_bin,
    input [PTR_WIDTH:0] rptr_bin,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out
  );
  //memory
  reg [DATA_WIDTH-1:0] mem [DEPTH-1:0];
  always@(posedge wclk)begin
    if(wen && ~full)
      mem[wptr_bin[PTR_WIDTH-1:0]] <= data_in;
  end
  always@(posedge rclk)begin
    if(ren && ~empty)
      data_out <= mem[rptr_bin[PTR_WIDTH-1:0]];
  end
endmodule
