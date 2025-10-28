module tb_fifo_syn;
reg clk,rst_n;
reg wen,ren;
reg [7:0]data_in;
wire [7:0] rdout;
wire full,empty,overflow,underflow,threshold;
integer i;

//instantiation DUT
fifo_syn DUT(.clk(clk),
	.rst_n(rst_n),
	.wen(wen),
	.ren(ren),
	.data_in(data_in),
	.rdout(rdout),
	.full(full),
	.empty(empty),
	.overflow(overflow),
	.underflow(underflow),
	.threshold(threshold)
	);

//clock generation
initial clk=1;
always #5 clk=~clk;

initial begin
$display("simulation starts");
$monitor("Time=%0t| wen=%b ren=%b data_in=%b rdout=%b full=%b empty=%b",$time,wen,ren,data_in,rdout,full,empty);

rst_n=0;
wen=0;
ren=0;
data_in=8'd0;
#15
rst_n=1;
$display("write mode Test");
for (i=0;i<7;i=i+1)begin
	@(posedge clk);
	wen=1;
	ren=0;
	data_in= data_in+1'b1;
end
@(posedge clk);
wen=0;
$display("read mode Test");
for (i=0;i<6;i=i+1)begin
	@(posedge clk);
	wen=0;
	ren=1;
end
@(posedge clk);
ren=0;

$display("read & write mode Test");
for (i=0;i<6;i=i+1)begin
	@(posedge clk);
	ren=1;
	wen=1;
	data_in=data_in +1'b1;
end

// Overflow test
$display("Overflow Test");
for (i=0; i<10; i=i+1) begin
  @(posedge clk);
  wen = 1;
  ren = 0;
  data_in = data_in + 1;
end

// Underflow test
$display("Underflow Test");
for (i=0; i<10; i=i+1) begin
  @(posedge clk);
  wen = 0;
  ren = 1;
end

$finish;
end
endmodule
