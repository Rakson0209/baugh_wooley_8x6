`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/23 23:36:22
// Design Name: 
// Module Name: baugh_wooley
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module baugh_wooley(mult,a,b,clk,rst);

input clk, rst;
input [7:0] a;
input [5:0] b;
output [13:0] mult;

wire [7:0] x; //inputs after register
wire [5:0] y;
wire [13:0] prod; //output before register
wire [7:0] w1,w2,w3,w4,w5,w6; //for AND or NAND gates
wire [7:0] h1, h2, h3, h4, h5; // for outputs of HA
wire [6:0] f1,f2,f3,f4,f5; //for outputs of FA
wire [7:0] c1, c2, c3, c4, c5, c6; //carrys of HA
wire [6:0] fc1,fc2,fc3,fc4,fc5,fc6; //carrys of FA

reg8 r1(x,a,clk,rst); //register operations for i/p
reg6 r2(y,b,clk,rst);

assign prod[0] = x[0] & y[0];
assign w1[0] = x[1] & y[0]; //row 1
assign w1[1] = x[2] & y[0];
assign w1[2] = x[3] & y[0];
assign w1[3] = x[4] & y[0];
assign w1[4] = x[5] & y[0];
assign w1[5] = x[6] & y[0];
assign w1[6] = ~(x[7] & y[0]);

assign w2[0] = x[0] & y[1]; //row 2
assign w2[1] = x[1] & y[1];
assign w2[2] = x[2] & y[1];
assign w2[3] = x[3] & y[1];
assign w2[4] = x[4] & y[1];
assign w2[5] = x[5] & y[1];
assign w2[6] = x[6] & y[1];
assign w2[7] = ~(x[7] & y[1]);

assign w3[0] = x[0] & y[2]; //row 3
assign w3[1] = x[1] & y[2];
assign w3[2] = x[2] & y[2];
assign w3[3] = x[3] & y[2];
assign w3[4] = x[4] & y[2];
assign w3[5] = x[5] & y[2];
assign w3[6] = x[6] & y[2];
assign w3[7] = ~(x[7] & y[2]);

HA a1(prod[1],c1[0],w1[0],w2[0]); //stage 1
FA a2(f1[0],fc1[0],w1[1],w2[1],w3[0]);
FA a3(f1[1],fc1[1],w1[2],w2[2],w3[1]);
FA a4(f1[2],fc1[2],w1[3],w2[3],w3[2]);
FA a5(f1[3],fc1[3],w1[4],w2[4],w3[3]);
FA a6(f1[4],fc1[4],w1[5],w2[5],w3[4]);
FA a7(f1[5],fc1[5],w1[6],w2[6],w3[5]);
HA a8(h1[0],c1[1],w2[7],w3[6]);

assign w4[0] = x[0] & y[3]; //row4
assign w4[1] = x[1] & y[3];
assign w4[2] = x[2] & y[3];
assign w4[3] = x[3] & y[3];
assign w4[4] = x[4] & y[3];
assign w4[5] = x[5] & y[3];
assign w4[6] = x[6] & y[3];
assign w4[7] = ~(x[7] & y[3]);

HA b1(prod[2],c2[0],f1[0], c1[0]); //stage 2
FA b2(f2[0],fc2[0],f1[1],fc1[0],w4[0]);
FA b3(f2[1],fc2[1],f1[2],fc1[1],w4[1]);
FA b4(f2[2],fc2[2],f1[3],fc1[2],w4[2]);
FA b5(f2[3],fc2[3],f1[4],fc1[3],w4[3]);
FA b6(f2[4],fc2[4],f1[5],fc1[4],w4[4]);
FA b7(f2[5],fc2[5],h1[0],fc1[5],w4[5]);
FA b8(f2[6],fc2[6],w3[7],w4[6],c1[1]);

assign w5[0] = x[0] & y[4]; //row5
assign w5[1] = x[1] & y[4];
assign w5[2] = x[2] & y[4];
assign w5[3] = x[3] & y[4];
assign w5[4] = x[4] & y[4];
assign w5[5] = x[5] & y[4];
assign w5[6] = x[6] & y[4];
assign w5[7] = ~(x[7] & y[4]);

HA ac1(prod[3],c3[0],f2[0], c2[0]); //stage 3
FA ac2(f3[0],fc3[0],f2[1],fc2[0],w5[0]);
FA ac3(f3[1],fc3[1],f2[2],fc2[1],w5[1]);
FA ac4(f3[2],fc3[2],f2[3],fc2[2],w5[2]);
FA ac5(f3[3],fc3[3],f2[4],fc2[3],w5[3]);
FA ac6(f3[4],fc3[4],f2[5],fc2[4],w5[4]);
FA ac7(f3[5],fc3[5],f2[6],fc2[5],w5[5]);
FA ac8(f3[6],fc3[6],w4[7],w5[6],fc2[6]);

assign w6[0] = ~(x[0] & y[5]); //row6
assign w6[1] = ~(x[1] & y[5]);
assign w6[2] = ~(x[2] & y[5]);
assign w6[3] = ~(x[3] & y[5]);
assign w6[4] = ~(x[4] & y[5]);
assign w6[5] = ~(x[5] & y[5]);
assign w6[6] = ~(x[6] & y[5]);
assign w6[7] = x[7] & y[5];

HA d1(prod[4],c4[0],f3[0], c3[0]); //stage 4
FA d2(f4[0],fc4[0],f3[1],fc3[0],w6[0]);
FA d3(f4[1],fc4[1],f3[2],fc3[1],w6[1]);
FA d4(f4[2],fc4[2],f3[3],fc3[2],w6[2]);
FA d5(f4[3],fc4[3],f3[4],fc3[3],w6[3]);
FA d6(f4[4],fc4[4],f3[5],fc3[4],w6[4]);
FA d7(f4[5],fc4[5],f3[6],fc3[5],w6[5]);
FA d8(f4[6],fc4[6],w5[7],w6[6],fc3[6]);

FA e1(prod[5],fc5[0], 1'b1, f4[0], c4[0]); //stage 5
HA e2(h5[0],c5[0], f4[1] ,fc4[0]);
FA e3(f5[1] ,fc5[1] ,1'b1 ,f4[2] ,fc4[1]);
HA e4(h5[1],c5[1], f4[3] ,fc4[2]);
HA e5(h5[2],c5[2], f4[4] ,fc4[3]);
HA e6(h5[3],c5[3], f4[5] ,fc4[4]);
HA e7(h5[4],c5[4], f4[6] ,fc4[5]);
HA e8(h5[5],c5[5], w6[7] ,fc4[6]);

// fast carry-propagate adder using full-adder
HA af1(prod[6], c6[0], fc5[0], h5[0]);
FA af2(prod[7], fc6[0], f5[1], c5[0], c6[0]);
FA af3(prod[8], fc6[1], h5[1], fc5[1], fc6[0]);
FA af4(prod[9], fc6[2], h5[2], c5[1], fc6[1]);
FA af5(prod[10], fc6[3], h5[3], c5[2], fc6[2]);
FA af6(prod[11], fc6[4], h5[4], c5[3], fc6[3]);
FA af7(prod[12], fc6[5], h5[5], c5[4], fc6[4]);
FA af8(prod[13], fc6[6], 1'b1, c5[5], fc6[5]);

reg14 r3(mult,prod,clk,rst); //register operations for o/p

endmodule

module HA(s,c,a,b);

input a,b;
output s,c;

assign s = a^b;
assign c = a&b;

endmodule



module FA(sum,car,a,b,c);

input a,b,c;
output sum,car;

assign sum = (a^b^c);
assign car = ((a&b)|(b&c)|(c&a));

endmodule

module d_ff(q,d,clk,rst);

input d,clk,rst;
output reg q;

always @(posedge clk)
begin
 if(rst==1'b1)
  q <= 1'b0;
 else
  q <= d;
end

endmodule

module reg8(out,in,clk,rst);

input [7:0] in;
input clk, rst;
output [7:0] out;

d_ff a0(out[0],in[0],clk,rst);
d_ff a1(out[1],in[1],clk,rst);
d_ff a2(out[2],in[2],clk,rst);
d_ff a3(out[3],in[3],clk,rst);
d_ff a4(out[4],in[4],clk,rst);
d_ff a5(out[5],in[5],clk,rst);
d_ff a6(out[6],in[6],clk,rst);
d_ff a7(out[7],in[7],clk,rst);

//module d_ff(q,d,clk,rst);

endmodule

module reg6(out,in,clk,rst);

input [5:0] in;
input clk, rst;
output [5:0] out;

d_ff a0(out[0],in[0],clk,rst);
d_ff a1(out[1],in[1],clk,rst);
d_ff a2(out[2],in[2],clk,rst);
d_ff a3(out[3],in[3],clk,rst);
d_ff a4(out[4],in[4],clk,rst);
d_ff a5(out[5],in[5],clk,rst);

//module d_ff(q,d,clk,rst);

endmodule



module reg14(out,in,clk,rst);

input [13:0] in;
input clk, rst;
output [13:0] out;

d_ff a0(out[0],in[0],clk,rst);
d_ff a1(out[1],in[1],clk,rst);
d_ff a2(out[2],in[2],clk,rst);
d_ff a3(out[3],in[3],clk,rst);
d_ff a4(out[4],in[4],clk,rst);
d_ff a5(out[5],in[5],clk,rst);
d_ff a6(out[6],in[6],clk,rst);
d_ff a7(out[7],in[7],clk,rst);
d_ff a8(out[8],in[8],clk,rst);
d_ff a9(out[9],in[9],clk,rst);
d_ff a10(out[10],in[10],clk,rst);
d_ff a11(out[11],in[11],clk,rst);
d_ff a12(out[12],in[12],clk,rst);
d_ff a13(out[13],in[13],clk,rst);

//module d_ff(q,d,clk,rst);

endmodule