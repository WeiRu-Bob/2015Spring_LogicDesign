
module led_matrix(divided_clk,rst,row,column);
    input  divided_clk,rst;
	 output [7:0]row,column;
	 
	 reg  [7:0]row,column;
	 
	 always@(posedge divided_clk or posedge rst)begin
	     if(rst)row<=8'b00000001;
		  else if(row==8'b10000000)row<=8'b00000001;
		  else row<=row<<1'b1;
    end
	 always@(*)begin
	   case(row)
		8'b00000001: column=8'b00011000;
      8'b00000010: column=8'b00100100;
      8'b00000100: column=8'b01000010;
      8'b00001000: column=8'b11011011;
      8'b00010000: column=8'b01011010;
      8'b00100000: column=8'b01000010;
      8'b01000000: column=8'b01000010;
      8'b10000000: column=8'b01111110;
      default:column=8'b00000000;
	endcase
 end	

endmodule

--------------------------------------------------------------------------------------
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
	else if(count==4'd2400)begin
	    divided_clk<=~divided_clk;
       count<=25'b0;
	end
	else begin
	     count<=count+25'b1;
   end
	end
endmodule
--------------------------------------------------------------------------------------
module system(clk,rst,row,column);
   input  clk,rst;
 	output [7:0]row,column;
	wire   divided_clk;
	
	led_matrix u1 (divided_clk,rst,row,column);
	frequency_divider FD(clk,rst,divided_clk);


endmodule

--------------------------------------------------------------------------------------

module sys_testbench;

	reg clk;
	reg rst;

	
	
	// Instantiate the Unit Under Test (UUT)
     system  u1 (clk,rst,row,column);

always #2 clk=~clk;

	initial begin
		// Initialize Inputs

		rst=1'b0;
		clk = 1'b1;
		#2 rst=1'b1;
		#2 rst=1'b0;


	end
      
endmodule

--------------------------------------------------------------------------------------
