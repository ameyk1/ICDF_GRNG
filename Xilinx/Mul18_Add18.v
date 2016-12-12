`timescale 1ns / 1ps
module Mul18_Add18( clk,rst,	// I: Global IO (clock, reset) 
					en_ma18,    // I: Module Enable signal
					coef1,      // I: [17:0] Coefficient 1
					coef2,      // O: [17:0] Coefficient 2
					masked_in,  // O: [14:0] Masked Data
					ma18_out    // O: [17:0] Output to Multiplier 1
    );

input clk,rst;	// I: Global IO (clock, reset) 
input en_ma18;   // I: Module Enable signal	
input [17:0] coef1;      // I: [17:0] Coefficient 1	
input [17:0] coef2;      // I: [17:0] Coefficient 2	
input [14:0] masked_in;  // I: [14:0] Masked Data
output signed [17:0] ma18_out;       // O: [17:0] Output to Multiplier 1

reg signed [14:0] mask_signed;
reg signed [35:0] m0_temp;
reg signed [36:0] ma18_signed;
reg signed [17:0] c1_signed, c2_signed;

always@(posedge clk)
	if(rst | ~en_ma18)
		begin 
			ma18_signed<=37'd0;
			m0_temp<=36'd0;
		end
	else
		begin
			mask_signed<=masked_in;
			c1_signed<=coef1;
			c2_signed<=coef2;
			m0_temp<=c2_signed * mask_signed;
			ma18_signed<=m0_temp+c1_signed;
		end

// Truncation 
assign ma18_out = ma18_signed[17:0];

endmodule
