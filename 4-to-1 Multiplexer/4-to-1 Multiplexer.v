// Initialize Inputs
		   sel=2'b00; in1=1'b1; in2=1'b0; in3=1'b0; in4=1'b0;
		#1	sel=2'b01; in1=1'b1; in2=1'b0; in3=1'b1; in4=1'b0;
		#1	sel=2'b10; in1=1'b1; in2=1'b0; in3=1'b1; in4=1'b0;
		#1	sel=2'b11; in1=1'b1; in2=1'b0; in3=1'b1; in4=1'b0;
		#1	sel=2'b00; in1=1'b0; in2=1'b0; in3=1'b0; in4=1'b0;
		#1	sel=2'b01; in1=1'b0; in2=1'b1; in3=1'b0; in4=1'b0;
	   #1 $finish;
	end
   initial
	begin
      $monitor($time, " sel=%d, in1=%b,in2=%b, in3=%b, in4=%b, out=%b",sel, in1, in2, in3, in4, out);


module mux_4to1_v2(in1,in2,in3,in4,sel,out);
   input in1,in2,in3,in4;
	input [1:0]sel;
	output out;
	
	wire a_out, b_out, c_out;
	
	mux_2to1 a(.in1(in1), .in2(in2), .sel(sel[0]), .out(a_out)); 
	mux_2to1 b(.in1(in3), .in2(in4), .sel(sel[0]), .out(b_out));
	mux_2to1 c(.in1(a_out), .in2(b_out), .sel(sel[1]), .out(out));
	
endmodule

module mux_2to1(in1,in2,sel,out);
   input in1,in2,sel;
	output out;
	
	wire a_out,b_out,c_out;
	
	not a(a_out,sel);
	and b(b_out,in1,a_out);
	and c(c_out,in2,sel);
	or d(out,b_out,c_out);
endmodule





