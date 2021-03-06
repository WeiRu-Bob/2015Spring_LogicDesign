module system(A,B,C_in,S,C_in,F,Cout,overflow);
    input  [31:0]A;
    input  [31:0]B;
    input  [2:0]S;
    input  C_in;
    output [31:0]F;
    output Cout,overflow;
    wire   C_1,C_2,C_3,C_4,C_5,C_6,C_7;
    
    
    ALU_1 x1 (A,B,S,C_in,F[3:0],G,P,C_1);
    ALU_2 x2 (A,B,S,C_1,F[7:4],G,P,C_2);
    ALU_3 x3 (A,B,S,C_2,F[11:8],G,P,C_3);
    ALU_4 x4 (A,B,S,C_3,F[15:12],G,P,C_4);
    ALU_5 x5 (A,B,S,C_4,F[19:16],G,P,C_5);
    ALU_6 x6 (A,B,S,C_5,F[23:20],G,P,C_6);
    ALU_7 x7 (A,B,S,C_6,F[27:24],G,P,C_7);
    ALU_8 x8 (A,B,S,C_7,F[31:28],Cout,overflow);  
  
endmodule