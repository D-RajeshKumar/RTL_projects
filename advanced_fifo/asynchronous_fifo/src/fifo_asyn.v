module fifo_asyn#(parameter DEPTH=16,
             parameter DATA_WIDTH=8,
             parameter PTR_WIDTH=4
             )
  (input wclk,wrst_n,
   input rclk,rrst_n,
   input wen,ren,
   input [DATA_WIDTH-1:0] data_in,
   output [DATA_WIDTH-1:0] data_out,
   output full,
   output empty,
   output overflow,
   output underflow
  );
  wire [PTR_WIDTH:0] wptr_bin,wptr_gray,rptr_bin,rptr_gray;
  wire [PTR_WIDTH:0] rptr_gray_sync,wptr_gray_sync;
  
  write_pointer #(.PTR_WIDTH(PTR_WIDTH))  dut1(.wclk(wclk),.wrst_n(wrst_n),.wen(wen),.full(full),
                     .wptr_bin(wptr_bin),.wptr_gray(wptr_gray));
  
  read_pointer #(.PTR_WIDTH(PTR_WIDTH)) dut2(.rclk(rclk),.rrst_n(rrst_n),.ren(ren),.empty(empty),.rptr_bin(rptr_bin),.rptr_gray(rptr_gray) );
  
  read2write #(.PTR_WIDTH(PTR_WIDTH)) dut3(.wclk(wclk),.wrst_n(wrst_n),.rptr_gray(rptr_gray),.rptr_gray_sync(rptr_gray_sync));
  
  write2read #(.PTR_WIDTH(PTR_WIDTH)) dut4(.rclk(rclk),.rrst_n(rrst_n),.wptr_gray(wptr_gray),.wptr_gray_sync(wptr_gray_sync));
  
  status #(.PTR_WIDTH(PTR_WIDTH)) dut5(.wclk(wclk),.wrst_n(wrst_n),.rclk(rclk),.rrst_n(rrst_n),.wen(wen),.ren(ren),.wptr_bin(wptr_bin),.rptr_bin(rptr_bin),.wptr_gray(wptr_gray),.rptr_gray(rptr_gray),.rptr_gray_sync(rptr_gray_sync),.wptr_gray_sync(wptr_gray_sync),.full(full),.empty(empty),.overflow(overflow),.underflow(underflow) );

  memory_array #(.PTR_WIDTH(PTR_WIDTH),.DATA_WIDTH(DATA_WIDTH),.DEPTH(DEPTH))  dut6(.wclk(wclk),.rclk(rclk),.wen(wen),.ren(ren),.full(full),.empty(empty),.wptr_bin(wptr_bin),.rptr_bin(rptr_bin),.data_in(data_in),.data_out(data_out));
  
endmodule
