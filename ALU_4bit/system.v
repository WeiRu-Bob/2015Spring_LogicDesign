module system(clk, sel, in1, in2, result);
   input clk;
	input [2:0]sel;
	input [3:0]in1,in2;
	output [3:0]result;
	
	alu_4bit ALU(sel, in1, in2, result);
	
endmodule
