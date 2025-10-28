module fifo_syn #(parameter DEPTH=16,parameter DATA_WIDTH=8,parameter PTR_WIDTH=4)
(clk,rst_n,data_in,rdout,full,empty,overflow,underflow,threshold,wen,ren);
  input clk,rst_n,wen,ren;
  wire [PTR_WIDTH:0] wptr,rptr;
  input [DATA_WIDTH-1:0]data_in;
  output [DATA_WIDTH-1:0] rdout;
  output full,empty,overflow,underflow,threshold;
  
  write_pointer #(.PTR_WIDTH(PTR_WIDTH)) 
		one(.clk(clk),.rst_n(rst_n),.wptr(wptr),.full(full),.wen(wen));
  
  read_pointer  #(.PTR_WIDTH(PTR_WIDTH))
		two(.clk(clk),.rst_n(rst_n),.rptr(rptr),.empty(empty),.ren(ren));
  
  memory 	#(.PTR_WIDTH(PTR_WIDTH),.DEPTH(DEPTH),.DATA_WIDTH(DATA_WIDTH)) 
		three(.clk(clk),.data_in(data_in),.rdout(rdout),.wen(wen),.ren(ren),.wptr(wptr[PTR_WIDTH-1:0]),.rptr(rptr[PTR_WIDTH-1:0]) );
  
  status 	#(.PTR_WIDTH(PTR_WIDTH)) 
		four(.clk(clk),.rst_n(rst_n),.ren(ren),.wen(wen),.wptr(wptr),.rptr(rptr),.full(full),.empty(empty),.overflow(overflow),.underflow(underflow),.threshold(threshold) );
endmodule
