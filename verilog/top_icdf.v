`timescale 1ns / 1ps
module top_icdf( clk,rst,   // I: Global IO (clock, reset)
				 en_icdf,   // I: Module Enable signal
				 seed_s1,   // I: [63:0]Initial Parameter for S1
				 seed_s2,   // I: [63:0]Initial Parameter for S2
				 seed_s3,   // I: [63:0]Initial Parameter for S3
				 gauss_rng  // O: [15:0] Gaussian random number
    );

input clk,rst;   			// I: Global IO (clock, reset)
input en_icdf;   			// I: Module Enable signal
input [63:0] seed_s1;   	// I: [63:0]Initial Parameter for S1
input [63:0] seed_s2;   	// I: [63:0]Initial Parameter for S2
input [63:0] seed_s3;   	// I: [63:0]Initial Parameter for S3
output reg signed [15:0] gauss_rng;// O: [15:0] Gaussian random number

wire [63:0] taus_out;
// Spliting URNG output in 4 different ways
wire [5:0] zero_pos;
wire [14:0] masked_data;
wire [6:0] segment; // Address for ROM_coef table 2
 // signed operations 
 wire [17:0] coef1,coef2;
 wire [20:0] coef0;
 wire signed [17:0] ma18_out;
 wire signed [15:0] ma21_out;

// --------------------------------------
// Uniform random number generator (URNG)
// --------------------------------------
taus_urng64 urng (
    .clk(clk), 
    .rst(rst), 			// I: Global IO (clock, reset)
    .en_taus(en_icdf),  // I: Module Enable signal
    .taus_out(taus_out) // O: [63:0] Tausworthe Random number
    );
// --------------------------------------
// Polynomial Interpolation 
// --------------------------------------
Lead0Detect64 LZD (
    .clk(clk), 
    .rst(rst), 			// I: Global IO (clock, reset)
    .en_lzd(en_icdf),       // I: Module Enable signal
    .in(taus_out[63:3]),// I: [60:0]number to detect leading zeros 
    .zero_pos(zero_pos) // O: [5:0] Leading zero position
    );
// Lead detector Output goes to two module ROM_trans and mask to zero
mask20_15 mask20 (
    .clk(clk), 				
    .rst(rst), 					// I: Global IO (clock, reset)
    .en_mask(en_icdf),          // I: Module Enable signal
    .zero_pos(zero_pos),        // I: [5:0] Leading Zero Position
    .urng_seg3(taus_out[17:3]),      // I: [14:0] URNG data [17:3]
    .masked_data(masked_data)   // O: [14:0] Masked data
    );	 

// ROM_trans is nothing but LZD (Bullet Point 5 : section 3A)
assign segment = (rst | ~en_icdf) ? 7'd0 : zero_pos + taus_out[2:1];

ROM_coef rom_coef (
    .clk(clk), 
    .rst(rst), 			// I: Global IO (clock, reset) 
    .en_coef(en_icdf),  // I: Module Enable signal
    .segment(segment),  // I: [6:0] Segment (Offset + ROM_trans)
    .coef0(coef0),      // O: [20:0] Coefficient 0
    .coef1(coef1),      // O: [17:0] Coefficient 1
    .coef2(coef2)       // O: [17:0] Coefficient 2
    );

 
Mul18_Add18 ma18 (
    .clk(clk), 
    .rst(rst), 				// I: Global IO (clock, reset) 
    .en_ma18(en_icdf),      // I: Module Enable signal
    .coef1(coef1),          // I: [17:0] Coefficient 1
    .coef2(coef2),          // O: [17:0] Coefficient 2
    .masked_in(masked_data),  // O: [14:0] Masked Data
    .ma18_out(ma18_out)     // O: [17:0] Output to Multiplier 1
    );

Mul18_Add21 ma21 (
    .clk(clk), 					
    .rst(rst), 					// I: Global IO (clock, reset) 
    .en_ma21(en_icdf),          // I: Module Enable signal
    .coef0(coef0),              // I: [20:0] Coefficient 0
    .masked_in(masked_data),    // I: [14:0] Masked Data
    .ma18_in(ma18_out),         // I: [17:0] Output from Mul18Add18
    .ma21_out(ma21_out)         // O: [15:0] Output to Multiplier 1
    );
// Last Multiplexer
always@(posedge clk)
	if (rst | ~en_icdf)
		gauss_rng<=16'd0;
	else if (taus_out[0])
		gauss_rng<=ma21_out;
	else 
		gauss_rng<=~ma21_out+1'b1;

endmodule
