module ALU(
  input enable,
  input [31:0] a, b,
  input [2:0] opcode,
  output reg zf, cf,
  output reg [32:0] res
);

  always @(*) begin
	zf=1'b0;
	cf=1'b0;
    if (enable) begin
      case (opcode)
        3'b000: res = a + b;   //add     
        3'b001: res = a - b;   //sub   
        3'b010: res = a + 1;   //increment    
        3'b011: res = a - 1;   //decrement    
        3'b100: res = a & b;   //and    
        3'b101: res = a | b;   //or    
        3'b110: res = ~a;      //not    
        3'b111: res = a ^ b;   //xor      
        default: res = 33'd0;
      endcase

      // Set flags
      zf = (res == 0);            
      cf = res[32];                 
    end else begin
      res = 33'd0;
      zf = 1'b0;
      cf = 1'b0;
    end
  end

endmodule
