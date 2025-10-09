module ALU_tb;
  reg enable;
  reg [31:0]a,b;
  reg [2:0]opcode;
  wire cf,zf;
  wire [32:0]res;
  
  ALU dut(enable,a,b,opcode,zf,cf,res);
  
integer i;	//loop variable
initial begin

   enable=1;
   a=32'h0000_00A5;	//test inputs
   b=32'h0000_000F;

    $display("=== Testing all 8 opcodes ===");

for(i=0;i<8; i=i+1)begin
	opcode= i;
	#10;
	$display("Time=%0t | enable=%b a=%b b=%b opcode=%b cf=%b zf=%b res=%b",$time,enable,a,b,opcode,cf,zf,res);
	#20;

case (i)
        0: begin // ADD
             if (res[31:0] == a + b)
               $display("test case 1 passed");end

        1: begin // SUB
             if (res[31:0] == a - b)
               $display("test case 2 passed");end

        2: begin // INC
             if (res[31:0] == a + 32'b1)
               $display("test case 3 passed");end

        3: begin // DEC
             if (res[31:0] == a - 32'b1)
               $display("test case 4 passed");end

        4: begin // AND
             if (res[31:0] == (a & b))
               $display("test case 5 passed");end

        5: begin // OR
             if (res[31:0] == (a | b))
               $display("test case 6 passed");end

        6: begin // NOT
             if (res[31:0] == (~a))
               $display("test case 7 passed");end

        7: begin // XOR
             if (res[31:0] == (a ^ b))
               $display("test case 8 passed");end

      endcase
 end
enable=0;
#10;
$finish;
end
endmodule
