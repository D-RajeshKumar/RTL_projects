module two_port_ram(
  input [7:0] data_a,data_b,
  input [5:0] addr_a,addr_b,
  input clk,
  input we_a,we_b,rd_a,rd_b,
  output reg [7:0] qa,qb);
  
  reg [7:0] ram [63:0];//creates 64loc with 8bit width
  
  always@(posedge clk)begin
    if(we_a)begin
      ram[addr_a]<=data_a;
    end
    if(rd_a)begin
      qa<=ram[addr_a];
    end
  end
  always@(posedge clk)begin
    if(we_b)begin
      ram[addr_b]<=data_b;
    end
    if(rd_b)begin
      qb<=ram[addr_b];
    end
  end
endmodule
