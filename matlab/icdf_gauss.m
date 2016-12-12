clear all;clc;

iterations=100;
% initial parameters for s1,s2,s3
s1 = 11357407135578037661;
s2 = 16405737874297512876;
s3 = 13098074952039773637;

load('coef.mat');

for i = 1: iterations
[s1,s2,s3,c_rand]=taus_urng64(s1,s2,s3);
% Spliting URNG output in 4 different ways
tauss_rand=dec2bin(c_rand);
urng_seg_temp0=[repmat('0', 1, 64 - length(tauss_rand)), tauss_rand];
urng_seg1=bin2dec(cellstr(urng_seg_temp0(1:1))); % Sign
urng_seg2=bin2dec(cellstr(urng_seg_temp0(2:3))); % Offset
urng_seg3=bin2dec(cellstr(urng_seg_temp0(4:18))); % Goes to Mask2Zero
urng_seg_temp4=char(cellstr(urng_seg_temp0(4:64))); % Goes to Leadineg Zero Detector
% Converting Binary string to decimal
urng_seg4 = 0;
for i = length(urng_seg_temp4):-1:1
  urng_seg4 = urng_seg4 + str2num(urng_seg_temp4(i))*2^(length(urng_seg_temp4)-i);
end
% Leading Zero detector 
zero_pos=Lead0Detect64(urng_seg4);
% Data Masking to Zero
[mask, masked_data]=mask20_15(zero_pos,urng_seg3);
segment_sel=zero_pos+urng_seg2; % ROM_coef Selection
Coef0=coef(segment_sel,1);
Coef1=coef(segment_sel,2);
Coef2=coef(segment_sel,3);
% Multiplication and Adder 
mul0 = Coef2 * masked_data; % Q1.17 * Q15
mul0_fix = float2fix(mul0,3);% Q14.3 
mul0_fix_acc=acc_mat(mul0,mul0_fix,0.000005);

add0= mul0 + Coef1; % Q14.3 + Q3.14 = Q14.4
mul1 = add0 * masked_data; % Q14.4 * Q15
add1 = mul1 + Coef0; % Q14.4
add1_fix = float2fix(add1,3);% Q14.3 
add1_fix_acc=acc_mat(add1,add1_fix,0.05);
add1_bin = dec2fix(add1,4,18);
end
% if(urng_seg1)
