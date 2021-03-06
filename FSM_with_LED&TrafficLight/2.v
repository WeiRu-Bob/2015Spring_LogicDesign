
module system_testbench;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire [2:0] out;
	wire [6:0] count_7seg;

	// Instantiate the Unit Under Test (UUT)
	system uut (
		.clk(clk), 
		.rst(rst), 
		.out(out), 
		.count_7seg(count_7seg)
	);

always #2 clk=~clk;

	initial begin
		// Initialize Inputs

		rst=1'b0;
		clk = 1'b1;
		#2 rst=1'b1;
		#2 rst=1'b0;

       

		// Wait 100 ns for global reset to finish
		#10 $finish;
        
		// Add stimulus here

	end
      
endmodule


-------------------------------------------------------------------------
module system(clk,rst,out,count_7seg);
   input clk,rst;
	output [2:0]out;
	output [6:0]count_7seg;
	
	wire divided_clk;
	wire [1:0]p_s, n_s;
	wire [2:0]count;

	
	frequency_divider FD(clk,rst,divided_clk);
   bin_to_7seg BT7(count, count_7seg);
	traffic_light TL(divided_clk,rst,count,p_s,n_s,out);
	counter C(divided_clk, rst, p_s, n_s, count);
	

endmodule

-------------------------------------------------------------------------
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
-------------------------------------------------------------------------
module bin_to_7seg(count, count_7seg);
   input  [2:0]count;
	output [6:0]count_7seg;
	
	reg [6:0]count_7seg;
	
	always@(*)begin
	   case(count)
		   3'b000: count_7seg=7'b0111111;
			3'b001: count_7seg=7'b0000110;
			3'b010: count_7seg=7'b1011011;
			3'b011: count_7seg=7'b1001111;
			3'b100: count_7seg=7'b1100110;
			
			default: count_7seg=7'b0000000;
      endcase
   end		

endmodule

-------------------------------------------------------------------------
module traffic_light(divided_clk,rst,count,p_s,n_s,out);
    input   divided_clk,rst;
	 input   [2:0]count;
	 output  [1:0]p_s,n_s;
	 output  [2:0]out;
	 parameter GREEN  = 2'd0,
	           YELLOW = 2'd1,
				  RED    = 2'd2;
	 reg[1:0]p_s,n_s;
	 reg[2:0]out;
	 
	 always@(posedge divided_clk or posedge rst)begin
	   if(rst)p_s<=RED;
		else p_s<=n_s;
	 end
	 
    always@(*)begin
	    case(p_s)
		      GREEN   :n_s=(count==4)? YELLOW : GREEN; 
	         YELLOW  :n_s=(count==1)? RED    : YELLOW;
			   RED     :n_s=(count==5)? GREEN  : RED;
				default :n_s=RED;
		endcase
	end
	always@(*)begin
	    case(p_s)
		      GREEN   :out=3'b001; 
	         YELLOW  :out=3'b010;
			   RED     :out=3'b100;
				default :out=3'b000;
			endcase
	end
		 
	
	
endmodule
-------------------------------------------------------------------------
module counter(divided_clk, rst, p_s, n_s, count);
   input divided_clk, rst;
	input [1:0]p_s, n_s;
	output [2:0]count;
	
	reg [2:0]count, n_count;
	
	always@(posedge divided_clk or posedge rst)begin
	   if(rst)count<=3'b1;
		else count<=n_count;
   end
	
	always@(*)begin
	   if(p_s==n_s)n_count=count+3'b1;
		else n_count=3'b1;
	end

endmodule
-------------------------------------------------------------------------