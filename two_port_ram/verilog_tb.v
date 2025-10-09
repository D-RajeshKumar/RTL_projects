module two_port_ram_tb;
  reg [7:0] data_a,data_b;
  reg [5:0] addr_a,addr_b;
  reg clk;
  reg we_a,we_b,rd_a,rd_b;
  wire [7:0] qa,qb;
  
  two_port_ram one(data_a,data_b,addr_a,addr_b,clk,we_a,we_b,rd_a,rd_b,qa,qb);
  initial clk=0;
  always #5 clk=~clk;
  
  initial begin
    $monitor("Time=%0t | data_a=%b data_b=%b addr_a=%b addr_b=%b clk=%b we_a=%b we_b=%b rd_a=%b rd_b=%b qa=%b qb=%b",$time,data_a,data_b,addr_a,addr_b,clk,we_a,we_b,rd_a,rd_b,qa,qb);
    
    data_a=8'h11;
    data_b=8'h01;
    addr_a=6'd3;
    addr_b=6'd6;
    we_a=1'b1;
    we_b=1'b1;
    #30
    we_a=1'b0;
    we_b=1'b0;
    rd_a=1'b1;
    rd_b=1'b1;
	#20
    $finish;
  end
endmodule
