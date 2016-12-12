`timescale 1ns / 1ps

module top_icdf_tb;

	// Inputs
	reg clk;
	reg rst;
	reg en_icdf;
	reg [63:0] seed_s1;
	reg [63:0] seed_s2;
	reg [63:0] seed_s3;

	// Outputs
	wire [15:0] gauss_rng;

	// Instantiate the Unit Under Test (UUT)
	top_icdf uut (
		.clk(clk), 
		.rst(rst), 
		.en_icdf(en_icdf), 
		.seed_s1(seed_s1), 
		.seed_s2(seed_s2), 
		.seed_s3(seed_s3), 
		.gauss_rng(gauss_rng)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		en_icdf = 0;
		seed_s1 = 64'd11357407135578037661;
		seed_s2 = 64'd16405737874297512876;
		seed_s3 = 64'd13098074952039773637;

		// Wait 100 ns for global reset to finish
		#100;
		rst=0;
		en_icdf = 1;
		
		repeat(1000) 
			@(posedge clk);
		$finish;

	end
      always #10 clk=~clk;
		
endmodule

