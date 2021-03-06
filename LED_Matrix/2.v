module led_matrix(divided_clk,rst,sel,row,column);
    input  divided_clk,rst,sel;
	 output [7:0]row,column;
	 
	 reg  [7:0]row,column;
	 
	 always@(posedge divided_clk or posedge rst)begin
	     if(rst)row<=8'b00000001;
		  else if(row==8'b10000000)row<=8'b00000001;
		  else row<=row<<1'b1;
    end
	 always@(*)begin
	 if(sel == 1'b1)
	 begin
	     case(row)
		     8'b00000001: column=8'b00011110;
           8'b00000010: column=8'b00100001;
           8'b00000100: column=8'b01000001;
           8'b00001000: column=8'b10000010;
           8'b00010000: column=8'b10000010;
           8'b00100000: column=8'b01000001;
           8'b01000000: column=8'b00100001;
           8'b10000000: column=8'b00011110;
           default:column=8'b00000000;
	     endcase
		  end

	 else
	 begin
		 case(row)
		     8'b00000001: column=8'b00011110;
           8'b00000010: column=8'b00100001;
           8'b00000100: column=8'b01000001;
           8'b00001000: column=8'b11010110;
           8'b00010000: column=8'b10101010;
           8'b00100000: column=8'b01000001;
           8'b01000000: column=8'b00100001;
           8'b10000000: column=8'b00011110;
           default:column=8'b00000000;
	     endcase
		  end
   end
		  
endmodule

-----------------------------------------------------------------------
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
	else if(count==25'd2400)begin
	    divided_clk<=~divided_clk;
       count<=25'b0;
	end
	else begin
	     count<=count+25'b1;
   end
	end
endmodule
-----------------------------------------------------------------------
module system(clk,rst,sel,row,column);
   input  clk,rst,sel;
 	output [7:0]row,column;
	wire   divided_clk;
	
	led_matrix u1 (divided_clk,rst,sel,row,column);
	frequency_divider FD(clk,rst,divided_clk);

endmodule

-----------------------------------------------------------------------

-----------------------------------------------------------------------