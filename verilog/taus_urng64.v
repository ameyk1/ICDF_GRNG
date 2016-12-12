module taus_urng64
//					#( // initial parameters for s1,s2,s3
//					parameter s1_init = 64'd11357407135578037661,
//					parameter s2_init = 64'd16405737874297512876,
//					parameter s3_init = 64'd13098074952039773637
//					)
					( clk,rst,		// I: Global IO (clock, reset)
					  en_taus,		// I: Module Enable signal
					  taus_out,		// O: [63:0] Tausworthe Random number
					  s1_init,
					  s2_init,
					  s3_init
					);
					
input clk,rst;				// I: Global IO (clock, reset)
input en_taus;              // I: Module Enable signal
input [63:0] s1_init,s2_init,s3_init; // I: Seed values for s1,s2,s3
output reg [63:0] taus_out; // O: [63:0] Tausworthe Random number

reg [63:0] s1,s2,s3; 		// 64-bit temporary registers
reg [63:0] b1,b2,b3;				// 64-bit temporary register
always@(posedge clk)
	if(rst | ~en_taus)
		begin
			s1<=s1_init;
			s2<=s2_init;
			s3<=s3_init;
			b1 <= 64'd0;
			b2 <= 64'd0;
			b3 <= 64'd0;
			taus_out<=64'd0;
		end
	else
		begin
			b1<=(((s1 <<13)^s1) >>19);
			s1<=(((s1 & 64'd4294967294) << 12)^ b1);
			b2<=(((s2 <<2)^s2) >>25);
			s2<=(((s2 & 64'd4294967288) << 4)^ b2);
			b3<=(((s3 <<3)^s3) >>11);
			s3<=(((s3 & 64'd4294967280) << 17)^ b3);
			taus_out<=s1^s2^s3;
		end

endmodule
