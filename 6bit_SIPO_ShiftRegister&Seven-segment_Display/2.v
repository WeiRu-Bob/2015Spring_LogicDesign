module system(clk,rst,out1_7seg,out2_7seg,data_out[0],data_out[1]
			 ,data_out[2] ,data_out[3] ,data_out[4],data_out[5]);
			 
			input  clk,rst;
			output out1_7seg,out2_7seg,data_out[0],data_out[1]
			        ,data_out[2] ,data_out[3] ,data_out[4],data_out[5];
			 
			 wire data_out[5],divided_clk,out1,out2;
       
		 bin_6bit_to_bcd(data_out[5],out1,out2);
       bin_to_7seg-1(out1, out1_7seg);
		 bin_to_7seg-2(out2, out2_7seg);
		 frequency_divider(clk,rst,divided_clk);
		 sipo_shifter_6bit(divided_clk,rst,data_out[5]);

endmodule

--------------------------------------------

module bin_6bit_to_bcd(data_out[5],out1,out2);
     input  [5:0]data_out[5];
	  output [3:0]out1,[3:0]out2;
	  
	  BCD #(6) b(data_out[5],out1,out2);
endmodule

---------------------------------------------

module sipo_shifter_6bit(divided_clk,rst,data_out[5]);
   input   divided_clk,rst,;
	output  data_out[5];
	
	reg  data_out[5];
	
	always@(posedge clk or posedge rst)begin
	     if(rst)data_out[0]<=1'b0;
		  else data_out[0]<=data_out[5];
		       data_out[1]<=data_out[0];
				 data_out[2]<=data_out[1];
				 data_out[3]<=data_out[2];
				 data_out[4]<=data_out[3];
			    data_out[5]<=data_out[4];
   end





endmodule

---------------------------------------------------

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

-------------------------------------

module bin_to_7seg-2(out2, out2_7seg);
   input [3:0]out2;
	output [6:0]out2_7seg;
	
	reg [6:0]out2_7seg;
	
	always@(*)begin
	   case(out)
		   4'b0000: out2_7seg=7'b0111111;
			4'b0001: out2_7seg=7'b0000110;
			4'b0010: out2_7seg=7'b1011011;
			4'b0011: out2_7seg=7'b1001111;
			4'b0100: out2_7seg=7'b1100110;
			4'b0101: out2_7seg=7'b1101101;
			4'b0110: out2_7seg=7'b1111101;
			4'b0111: out2_7seg=7'b0000111;
			4'b1000: out2_7seg=7'b1111111;
			4'b1001: out2_7seg=7'b1101111;
			4'b1010: out2_7seg=7'b1110111;
			4'b1011: out2_7seg=7'b1111100;
			4'b1100: out2_7seg=7'b0111001;
			4'b1101: out2_7seg=7'b1011110;
			4'b1110: out2_7seg=7'b1111001;
			4'b1111: out2_7seg=7'b1110001;
			default: out2_7seg=7'b0000000;
      endcase
   end		

endmodule

--------------------------------------------

module bin_to_7seg-1(out1, out1_7seg);
   input [3:0]out1;
	output [6:0]out1_7seg;
	
	reg [6:0]out1_7seg;
	
	always@(*)begin
	   case(out)
		   4'b0000: out1_7seg=7'b0111111;
			4'b0001: out1_7seg=7'b0000110;
			4'b0010: out1_7seg=7'b1011011;
			4'b0011: out1_7seg=7'b1001111;
			4'b0100: out1_7seg=7'b1100110;
			4'b0101: out1_7seg=7'b1101101;
			4'b0110: out1_7seg=7'b1111101;
			4'b0111: out1_7seg=7'b0000111;
			4'b1000: out1_7seg=7'b1111111;
			4'b1001: out1_7seg=7'b1101111;
			4'b1010: out1_7seg=7'b1110111;
			4'b1011: out1_7seg=7'b1111100;
			4'b1100: out1_7seg=7'b0111001;
			4'b1101: out1_7seg=7'b1011110;
			4'b1110: out1_7seg=7'b1111001;
			4'b1111: out1_7seg=7'b1110001;
			default: out1_7seg=7'b0000000;
      endcase
   end		

endmodule

------------------------------------------

module BCD(binary,Hundreds,out1,out2);
   parameter width=8;
	
	input[width - 1:0]binary;
	output reg [3:0]Hundreds;
	output reg [3:0]out1;
	output reg [3:0]out2;
	integer i;
	
	always@(binary)begin
	Hundreds=4'd0;
	out1=4'd0;
   out2=4'd0;
	    for(i=width - 1;i>=0;i=i-1)begin
		   if(Hundreds>=5)
			   Hundreds = Hundreds + 4'd3;
			if(out1>=5)
			   out1=out1+4'd3;
			if(out2>=5)
			   out2=out2+4'd3;
				
			Hundreds = Hundreds<<1;
         Hundreds[0] = out1[3];
			out1=out1<<1;
         out1[0]=out1[3];
         out2=out2<<1;
         out2[0]=binary[i];
      end
    end		
				
			
			     
endmodule




