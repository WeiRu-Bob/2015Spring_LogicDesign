module system(clk,rst,row,column);
   input  clk,rst;
 	output [7:0]row,column;
	wire   divided_clk;
	wire [1:0]sel;
	
	led_matrix u1 (divided_clk,rst,sel,row,column);
	frequency_divider FD(clk,rst,divided_clk);
	counter C(divided_clk,rst,sel);

endmodule

--------------------------------------------------------------------------
module led_matrix(divided_clk,rst,sel,row,column);
    input  divided_clk,rst;
	 input  [1:0]sel;
	 output [7:0]row,column;
	 
	 reg  [7:0]row,column;
	 
	 always@(posedge divided_clk or posedge rst)begin
	     if(rst)row<=8'b00000001;
		  else if(row==8'b10000000)row<=8'b00000001;
		  else row<=row<<1'b1;
    end
	 always@(*)begin
	 if(sel == 2'b01)
	 begin
	     case(row)
		     8'b00000001: column=8'b00000000;
           8'b00000010: column=8'b00001000;
           8'b00000100: column=8'b00101000;
           8'b00001000: column=8'b01001011;
           8'b00010000: column=8'b00111111;
           8'b00100000: column=8'b00101011;
           8'b01000000: column=8'b01001000;
           8'b10000000: column=8'b10000100;
           default:column=8'b00000000;
	     endcase
		  end

	 else if(sel == 2'b10)
	 begin
		 case(row)
		     8'b00000001: column=8'b00000000;
           8'b00000010: column=8'b00010000;
           8'b00000100: column=8'b01001000;
           8'b00001000: column=8'b01001011;
           8'b00010000: column=8'b00111111;
           8'b00100000: column=8'b00101011;
           8'b01000000: column=8'b11000100;
           8'b10000000: column=8'b00000000;
           default:column=8'b00000000;
	     endcase
		  end
	 else if(sel == 2'b11)
	 begin
		 case(row)
		     8'b00000001: column=8'b00000000;
           8'b00000010: column=8'b00000000;
           8'b00000100: column=8'b10010000;
           8'b00001000: column=8'b01001011;
           8'b00010000: column=8'b00111111;
           8'b00100000: column=8'b11010011;
           8'b01000000: column=8'b00001000;
           8'b10000000: column=8'b00000000;
           default:column=8'b00000000;
	     endcase
		  end
	 else 
	 begin
		 case(row)
		     8'b00000001: column=8'b00000000;
           8'b00000010: column=8'b00010000;
           8'b00000100: column=8'b01001000;
           8'b00001000: column=8'b01001011;
           8'b00010000: column=8'b00111111;
           8'b00100000: column=8'b00101011;
           8'b01000000: column=8'b11000100;
           8'b10000000: column=8'b00000000;
           default:column=8'b00000000;
	     endcase
		  end
   end
		  
endmodule

--------------------------------------------------------------------------
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
	else if(count==25'd24000)begin
	    divided_clk<=~divided_clk;
       count<=25'b0;
	end
	else begin
	     count<=count+25'b1;
   end
	end
endmodule

--------------------------------------------------------------------------
module counter(divided_clk,rst,sel);
   input divided_clk, rst;
	output [1:0]sel;
	
	reg [1:0]sel;
	reg [7:0]count;
	always@(posedge divided_clk or posedge rst)begin
	   if     (rst)sel<=2'b00;
		else if(count==0)sel<=sel+2'd1;
		else    sel<=sel;
   end
	always@(posedge divided_clk)begin
		count=count+8'd1;
	end

endmodule

--------------------------------------------------------------------------

--------------------------------------------------------------------------
