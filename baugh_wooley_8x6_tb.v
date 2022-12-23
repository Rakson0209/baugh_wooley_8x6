`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/24 01:50:53
// Design Name: 
// Module Name: baugh_wooley_tb
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


module baugh_wooley_tb;
    // Inputs
	reg [7:0] a;
	reg [5:0] b;
	reg clk;
	reg rst;

	// Outputs
	wire [13:0] mult;

	// Instantiate the Unit Under Test (UUT)
	baugh_wooley uut (
		.mult(mult), 
		.a(a), 
		.b(b), 
		.clk(clk), 
		.rst(rst)
	);
	initial begin
	clk = 1'b1;
	end
	always #2 clk = ~clk;
	
	initial begin
		// Initialize Inputs
		a = 1; b = 1; rst = 0;
		#4 a = 1; b = 1; rst = 1;
		#4 a = 1; b = 1; rst = 0;
		#4 a = 1; b = 2;
		#4 a = 2; b = 3;
		#4 a = 3; b = 4;
		#4 a = 4; b = 5;
		#4 a = 5; b = 6;
		#4 a = 25; b = 7;
		#4 a = 125; b = 31;
		#4 a = 4; b = -5;
		#4 a = -5; b = 6;
		#4 a = -6; b = -7;
		#4 a = -9; b = 9;
		#4 a = -10; b = 20;
		#4 a = -7; b = 15;
		#4 a = -128; b = -32;
		#4 a = -128; b = 31;
		#4 a = 127; b = -32;
		#4 a = -9; b = -32;
	end
endmodule
