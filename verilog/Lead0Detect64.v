module Lead0Detect64( clk,rst, 	// I: Global IO (clock, reset)
					  en_lzd, 		// I: Module Enable signal
					  in,		// I: [60:0]number to detect leading zeros
					  zero_pos  // O: [5:0] Leading zero position
					);
input clk, rst; 		// Global IO
input en_lzd;			// I: Module Enable signal
input [60:0] in;        // I: [60:0]number to detect leading zeros
output reg [5:0] zero_pos;  // O: [5:0] Leading zero position

wire [63:0] in_64; 		// Making input 61-bit to 64-bit
assign in_64 = {in, 3'b111};

// It takes log2(64) stages to get the leading zero in the given input
wire [31:0] p1,v1;		// Position and Valid bit for 1st stage (LZD2)
wire [1:0] p2 [15:0];	// Position bit for 2nd stage (LZD4) 
wire [15:0] v2;			// Valid bit for 2nd stage (LZD4)
wire [2:0] p3 [7:0];	// Position bit for 3rd stage (LZD8) 
wire [7:0] v3;			// Valid bit for 3rd stage (LZD8)
wire [3:0] p4 [3:0];	// Position bit for 4th stage (LZD16) 
wire [3:0] v4;			// Valid bit for 4th stage (LZD16)
wire [4:0] p5 [1:0];	// Position bit for 5th stage (LZD32) 
wire v5;				// Valid bit for 5th stage (LZD32)
wire [5:0] p6;			// Position bit for 6th stage (LZD64)
wire v6;                // Valid bit for 6th stage (LZD64)
// -----------------------------------------
// Stage -1 : Position bit Calculation
// -----------------------------------------
assign p1 [0] = ~in_64[1] & in_64[0];
assign p1 [1] = ~in_64[3] & in_64[2];
assign p1 [2] = ~in_64[5] & in_64[4];
assign p1 [3] = ~in_64[7] & in_64[6];
assign p1 [4] = ~in_64[9] & in_64[8];
assign p1 [5] = ~in_64[11] & in_64[10];
assign p1 [6] = ~in_64[13] & in_64[12];
assign p1 [7] = ~in_64[15] & in_64[14];
assign p1 [8] = ~in_64[17] & in_64[16];
assign p1 [9] = ~in_64[19] & in_64[18];
assign p1 [10] = ~in_64[21] & in_64[20];
assign p1 [11] = ~in_64[23] & in_64[22];
assign p1 [12] = ~in_64[25] & in_64[24];
assign p1 [13] = ~in_64[27] & in_64[26];
assign p1 [14] = ~in_64[29] & in_64[28];
assign p1 [15] = ~in_64[31] & in_64[30];
assign p1 [16] = ~in_64[33] & in_64[32];
assign p1 [17] = ~in_64[35] & in_64[34];
assign p1 [18] = ~in_64[37] & in_64[36];
assign p1 [19] = ~in_64[39] & in_64[38];
assign p1 [20] = ~in_64[41] & in_64[40];
assign p1 [21] = ~in_64[43] & in_64[42];
assign p1 [22] = ~in_64[45] & in_64[44];
assign p1 [23] = ~in_64[47] & in_64[46];
assign p1 [24] = ~in_64[49] & in_64[48];
assign p1 [25] = ~in_64[51] & in_64[50];
assign p1 [26] = ~in_64[53] & in_64[52];
assign p1 [27] = ~in_64[55] & in_64[54];
assign p1 [28] = ~in_64[57] & in_64[56];
assign p1 [29] = ~in_64[59] & in_64[58];
assign p1 [30] = ~in_64[61] & in_64[60];
assign p1 [31] = ~in_64[63] & in_64[62];
// -----------------------------------------
// Stage -1 : Valid bit Calculation
// -----------------------------------------
assign v1 [0] = in_64[1] | in_64[0];
assign v1 [1] = in_64[3] | in_64[2];
assign v1 [2] = in_64[5] | in_64[4];
assign v1 [3] = in_64[7] | in_64[6];
assign v1 [4] = in_64[9] | in_64[8];
assign v1 [5] = in_64[11] | in_64[10];
assign v1 [6] = in_64[13] | in_64[12];
assign v1 [7] = in_64[15] | in_64[14];
assign v1 [8] = in_64[17] | in_64[16];
assign v1 [9] = in_64[19] | in_64[18];
assign v1 [10] = in_64[21] | in_64[20];
assign v1 [11] = in_64[23] | in_64[22];
assign v1 [12] = in_64[25] | in_64[24];
assign v1 [13] = in_64[27] | in_64[26];
assign v1 [14] = in_64[29] | in_64[28];
assign v1 [15] = in_64[31] | in_64[30];
assign v1 [16] = in_64[33] | in_64[32];
assign v1 [17] = in_64[35] | in_64[34];
assign v1 [18] = in_64[37] | in_64[36];
assign v1 [19] = in_64[39] | in_64[38];
assign v1 [20] = in_64[41] | in_64[40];
assign v1 [21] = in_64[43] | in_64[42];
assign v1 [22] = in_64[45] | in_64[44];
assign v1 [23] = in_64[47] | in_64[46];
assign v1 [24] = in_64[49] | in_64[48];
assign v1 [25] = in_64[51] | in_64[50];
assign v1 [26] = in_64[53] | in_64[52];
assign v1 [27] = in_64[55] | in_64[54];
assign v1 [28] = in_64[57] | in_64[56];
assign v1 [29] = in_64[59] | in_64[58];
assign v1 [30] = in_64[61] | in_64[60];
assign v1 [31] = in_64[63] | in_64[62];
// -----------------------------------------
// Stage -2 : Position bit Calculation
// -----------------------------------------
assign p2 [0] = {~v1[1], v1[1]? p1[1] :p1[0]};
assign p2 [1] = {~v1[3], v1[3]? p1[3] :p1[2]};
assign p2 [2] = {~v1[5], v1[5]? p1[5] :p1[4]};
assign p2 [3] = {~v1[7], v1[7]? p1[7] :p1[6]};
assign p2 [4] = {~v1[9], v1[9]? p1[9] :p1[8]};
assign p2 [5] = {~v1[11], v1[11]? p1[11] :p1[10]};
assign p2 [6] = {~v1[13], v1[13]? p1[13] :p1[12]};
assign p2 [7] = {~v1[15], v1[15]? p1[15] :p1[14]};
assign p2 [8] = {~v1[17], v1[17]? p1[17] :p1[16]};
assign p2 [9] = {~v1[19], v1[19]? p1[19] :p1[18]};
assign p2 [10] = {~v1[21], v1[21]? p1[21] :p1[20]};
assign p2 [11] = {~v1[23], v1[23]? p1[23] :p1[22]};
assign p2 [12] = {~v1[25], v1[25]? p1[25] :p1[24]};
assign p2 [13] = {~v1[27], v1[27]? p1[27] :p1[26]};
assign p2 [14] = {~v1[29], v1[29]? p1[29] :p1[28]};
assign p2 [15] = {~v1[31], v1[31]? p1[31] :p1[30]};
// -----------------------------------------
// Stage -2 : Valid bit Calculation
// -----------------------------------------
assign v2 [0] = v1[1] | v1[0];
assign v2 [1] = v1[3] | v1[2];
assign v2 [2] = v1[5] | v1[4];
assign v2 [3] = v1[7] | v1[6];
assign v2 [4] = v1[9] | v1[8];
assign v2 [5] = v1[11] | v1[10];
assign v2 [6] = v1[13] | v1[12];
assign v2 [7] = v1[15] | v1[14];
assign v2 [8] = v1[17] | v1[16];
assign v2 [9] = v1[19] | v1[18];
assign v2 [10] =v1[21] | v1[20];
assign v2 [11] =v1[23] | v1[22];
assign v2 [12] =v1[25] | v1[24];
assign v2 [13] =v1[27] | v1[26];
assign v2 [14] =v1[29] | v1[28];
assign v2 [15] =v1[31] | v1[30];
// -----------------------------------------
// Stage -3 : Position bit Calculation
// -----------------------------------------
assign p3 [0] =  {~v2[1],  v2[1]?  p2[1] : p2[0]};
assign p3 [1] =  {~v2[3],  v2[3]?  p2[3] : p2[2]};
assign p3 [2] =  {~v2[5],  v2[5]?  p2[5] : p2[4]};
assign p3 [3] =  {~v2[7],  v2[7]?  p2[7] : p2[6]};
assign p3 [4] =  {~v2[9],  v2[9]?  p2[9] : p2[8]};
assign p3 [5] =  {~v2[11], v2[11]? p2[11] :p2[10]};
assign p3 [6] =  {~v2[13], v2[13]? p2[13] :p2[12]};
assign p3 [7] =  {~v2[15], v2[15]? p2[15] :p2[14]};
// -----------------------------------------
// Stage -3 : Valid bit Calculation
// -----------------------------------------
assign v3 [0] = v2[1]  | v2[0];
assign v3 [1] = v2[3]  | v2[2];
assign v3 [2] = v2[5]  | v2[4];
assign v3 [3] = v2[7]  | v2[6];
assign v3 [4] = v2[9]  | v2[8];
assign v3 [5] = v2[11] | v2[10];
assign v3 [6] = v2[13] | v2[12];
assign v3 [7] = v2[15] | v2[14];
// -----------------------------------------
// Stage -4 : Position bit Calculation
// -----------------------------------------
assign p4 [0] =  {~v3[1],  v3[1]?  p3[1] : p3[0]};
assign p4 [1] =  {~v3[3],  v3[3]?  p3[3] : p3[2]};
assign p4 [2] =  {~v3[5],  v3[5]?  p3[5] : p3[4]};
assign p4 [3] =  {~v3[7],  v3[7]?  p3[7] : p3[6]};
// -----------------------------------------
// Stage -4 : Valid bit Calculation
// -----------------------------------------
assign v4 [0] = v3[1]  | v3[0];
assign v4 [1] = v3[3]  | v3[2];
assign v4 [2] = v3[5]  | v3[4];
assign v4 [3] = v3[7]  | v3[6];
// -----------------------------------------
// Stage -5 : Position bit Calculation
// -----------------------------------------
assign p5 [0] =  {~v4[1],  v4[1]?  p4[1] : p4[0]};
assign p5 [1] =  {~v4[3],  v4[3]?  p4[3] : p4[2]};
// -----------------------------------------
// Stage -5 : Valid bit Calculation
// -----------------------------------------
// v5 [0] = v4[1]  | v4[0];
// v5 [1] = v4[3]  | v4[2]; // Not required
assign v5 = v4[1]  | v4[0];
// -----------------------------------------
// Stage -6 : Position and Valid bit Calculation
// -----------------------------------------
assign p6 =  {~v5,  v5 ?  p5[1] : p5[0]};
// v6 = v5[1]  | v5[0];  // Not required

always@(posedge clk)
	if(rst | ~en_lzd)
		zero_pos<=6'd0;
	else
		zero_pos<=p6;
		
endmodule
