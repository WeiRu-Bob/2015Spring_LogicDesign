module ALUtestbench;

	// Inputs
	reg clk;
	reg [2:0] sel;
	reg [3:0] in1;
	reg [3:0] in2;

	// Outputs
	wire [3:0] result;

	// Instantiate the Unit Under Test (UUT)
	system uut (
		.sel(sel), 
		.in1(in1), 
		.in2(in2), 
		.result(result),
		.clk(clk)
	);
	
	initial clk=1'b1;
	always #5 clk=~clk;

	initial begin
		   sel=3'b000; in1=9; in2=3;
     #10 sel=3'b001; in1=9; in2=3;
     #10 sel=3'b010; in1=9; in2=3;
     #10 sel=3'b011; in1=9; in2=3;
     #10 sel=3'b100; in1=9; in2=3;
     #10 sel=3'b101; in1=9; in2=3;
     #10 sel=3'b110; in1=9; in2=3;
     #10 sel=3'b111; in1=9; in2=3;
     #10 $finish;

	end
      
  
		
		

	end
      
endmodule