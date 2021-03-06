
module system_testbench;

	// Inputs
	reg clk;
	reg rst;
	reg [1:0] in;

	// Outputs
	wire [3:0] out;

	// Instantiate the Unit Under Test (UUT)
	system uut (
		.clk(clk), 
		.rst(rst), 
		.out(out), 
		.in(in)
	);
	always #2 clk=~clk;

	initial begin
		// Initialize Inputs
		in=2'b01;
		rst=1'b0;
		clk = 1'b1;
		#2 rst=1'b1;
		#2 rst=1'b0;

       

		// Wait 100 ns for global reset to finish
		#10 $finish;
        
		// Add stimulus here

	end
      
endmodule

------------------------------------------------------------------------
module system(clk,rst,in,out);
   input clk,rst;
	input [1:0]in;
	output [3:0]out;
	
	wire divided_clk;

	
	frequency_divider FD(clk,rst,divided_clk);
   fsm FSM(divided_clk,rst,in,out);
	

endmodule

------------------------------------------------------------------------
module frequency_divider(clk,rst,divided_clk);
  input  clk,rst;
  output divided_clk;
  
  reg divided_clk;
  reg [24:0]count;
  
  always@(posedge clk or posedge rst)begin
    if(rst)begin
	    divided_clk<=1'b0;
       count<=25'b0;
   end
	else if(count==25'd24000000)begin
	    divided_clk<=~divided_clk;
       count<=25'b0;
	end
	else begin
	     count<=count+25'b1;
   end
	end
endmodule
------------------------------------------------------------------------
module fsm(clk,rst,in,out);
    input  clk,rst;
	 input  [1:0]in;
	 output [3:0]out;
	 
	 parameter STATE_A=2'd0,
	           STATE_B=2'd1,
				  STATE_C=2'd2,
				  STATE_D=2'd3;
				 
	reg[1:0]p_s,n_s;
	reg[3:0]out;
	
	always@(posedge clk or posedge rst)begin
	   if(rst)p_s<=STATE_A;
		else p_s<=n_s;
	end
   
   always@(*)begin
     case(p_s)	
	      STATE_A:n_s=(in==2'b00)?STATE_B:
			            (in==2'b01)?STATE_B:
							(in==2'b10)?STATE_D:
							            STATE_D;
         STATE_B:n_s=(in==2'b00)?STATE_D:
			            (in==2'b01)?STATE_C:
							(in==2'b10)?STATE_A:
							            STATE_C;
			STATE_C:n_s=(in==2'b00)?STATE_A:
			            (in==2'b01)?STATE_D:
							(in==2'b10)?STATE_B:
							            STATE_A;
			STATE_D:n_s=(in==2'b00)?STATE_C:
			            (in==2'b01)?STATE_A:
							(in==2'b10)?STATE_C:
							            STATE_B;
			default:n_s=STATE_A;
	endcase
end
   
	always@(*)begin
     case(p_s)	
	     STATE_A:out=4'b0001;
	     STATE_B:out=4'b0010;
		  STATE_C:out=4'b0100;
		  STATE_D:out=4'b1000;
		  default:out=4'b0000;
  endcase
end
endmodule

------------------------------------------------------------------------

------------------------------------------------------------------------