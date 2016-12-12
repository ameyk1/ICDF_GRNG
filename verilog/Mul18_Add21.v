`timescale 1ns / 1ps
module Mul18_Add21( clk,rst,	// I: Global IO (clock, reset) 
					en_ma21,    // I: Module Enable signal
					coef0,      // I: [20:0] Coefficient 0
					masked_in,  // I: [14:0] Masked Data
					ma18_in,	// I: [17:0] Output from Mul18Add18
					ma21_out    // O: [15:0] Output to Multiplier 1
    );

input clk,rst;	// I: Global IO (clock, reset) 
input en_ma21;   // I: Module Enable signal	
input [20:0] coef0;      // I: [17:0] Coefficient 1	
input [14:0] masked_in;  // I: [14:0] Masked Data
input [17:0] ma18_in;  // I: [14:0] Masked Data
output signed [15:0] ma21_out;       // O: [17:0] Output to Multiplier 1

reg signed [14:0] mask_signed;
reg signed [35:0] m1_temp;
reg signed [17:0] ma18_signed;
reg signed [36:0] ma21_signed;
reg signed [20:0] c0_signed;

always@(posedge clk)
	if(rst | ~en_ma21)
		begin 
			ma21_signed<=37'd0;
			m1_temp<=36'd0;
		end
	else
		begin
			mask_signed<=masked_in;
			c0_signed<=coef0;
			ma18_signed<=ma18_in;
			m1_temp<=mask_signed * ma18_signed;
			ma21_signed<=m1_temp+c0_signed;
		end
// Truncation
assign ma21_out = ma21_signed[15:0];

endmodule