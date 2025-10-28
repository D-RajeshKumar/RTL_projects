//memory block  (store data to handle data rate mismatch)
module memory #(parameter DATA_WIDTH=8,parameter DEPTH=16,parameter PTR_WIDTH=4)
(clk,data_in,rdout,wen,ren,wptr,rptr);
  input clk;
  input [DATA_WIDTH-1:0]data_in;
  input wen,ren;
  output reg [DATA_WIDTH-1:0] rdout;
  input [PTR_WIDTH-1:0] wptr,rptr;
  reg [DATA_WIDTH-1:0] mem [DEPTH-1:0];
  always@(posedge clk)begin
    if(wen)
      mem[wptr[PTR_WIDTH-1:0]] <= data_in;
    if(ren)
 	rdout <= mem[rptr[PTR_WIDTH-1:0]];
      end
endmodule
