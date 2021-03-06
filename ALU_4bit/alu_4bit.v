module alu_4bit(sel, in1, in2, result);
   input [2:0]sel;
	input [3:0]in1, in2;
	output [3:0]result;
	
	parameter ADD = 3'b000,
	          SUB = 3'b001,
				 AND = 3'b010,
				 OR  = 3'b011,
				 XOR = 3'b100,
				 SHR = 3'b101,
				 SHL = 3'b110,
				 CMP = 3'b111;

	reg [3:0]result;
	
	always@(sel or in1 or in2)begin
	   case(sel)
		   ADD: result=in1+in2;
			SUB: result=in1-in2;
			AND: result=in1&in2;
			OR : result=in1|in2;
			XOR: result=in1^in2;
			SHR: result=in1>>in2;
			SHL: result=in1<<in2;
			CMP: result=in1>in2;
			default: result=4'b0;
		endcase
   end

endmodule	