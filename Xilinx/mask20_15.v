module mask20_15( clk,rst,		// I: Global IO (clock, reset)
				  en_mask, 		// I: Module Enable signal
				  zero_pos, 	// I: [5:0] Leading Zero Position
				  urng_seg3, 	// I: [14:0] URNG data [17:3]
				  masked_data 	// O: [14:0] Masked data
				  );

input clk,rst;				// I: Global IO (clock, reset)
input en_mask;              // I: Module Enable signal
input [5:0] zero_pos;       // I: [5:0] Leading Zero Position
input [14:0] urng_seg3;     // I: [14:0] URNG data [17:3]
output reg [14:0] masked_data;  // O: [14:0] Masked data

wire [14:0] shiftLSB2MSB; // Temporary variables for mask and shift operation
reg [14:0] mask;
// According to figure 3 from reference
always@(*)
	case(zero_pos)
		6'b111101: mask = 15'b1111_1111_1111_111;
		6'b111100: mask = 15'b0111_1111_1111_111;
		6'b111011: mask = 15'b1011_1111_1111_111;
		6'b111010: mask = 15'b1101_1111_1111_111;
		6'b111001: mask = 15'b1110_1111_1111_111;
		6'b111000: mask = 15'b1111_0111_1111_111;
		6'b110111: mask = 15'b1111_1011_1111_111;
		6'b110110: mask = 15'b1111_1101_1111_111;
		6'b110101: mask = 15'b1111_1110_1111_111;
		6'b110100: mask = 15'b1111_1111_0111_111;
		6'b110011: mask = 15'b1111_1111_1011_111;
		6'b110010: mask = 15'b1111_1111_1101_111;
		6'b110001: mask = 15'b1111_1111_1110_111;
		6'b110000: mask = 15'b1111_1111_1111_011;
		6'b101111: mask = 15'b1111_1111_1111_101;
		6'b101110: mask = 15'b1111_1111_1111_110;
		default: mask =15'b1111_1111_1111_111;
	endcase

// According to last note in Section 3 A
assign shiftLSB2MSB = {urng_seg3[0],urng_seg3[1],urng_seg3[2],urng_seg3[3],						 urng_seg3[4],urng_seg3[5],urng_seg3[6],urng_seg3[7],
					  urng_seg3[8],urng_seg3[9],urng_seg3[10],urng_seg3[11],urng_seg3[12],urng_seg3[13],urng_seg3[14]};

// Mask to Zero
always@(posedge clk)
	if(rst | ~en_mask)
		masked_data <= 15'd0;
	else
		masked_data <= mask & shiftLSB2MSB;

endmodule