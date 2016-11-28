clear all;clc;

% N=10000;
% initial parameters for s1,s2,s3
s1 = 11357407135578037661;
s2 = 16405737874297512876;
s3 = 13098074952039773637;

load('coef.mat');

[s1,s2,s3,c_rand]=taus_urng64(s1,s2,s3);
% Spliting URNG output in 4 different ways
tauss_temp=int64(18446744073709551615);
tauss_rand=bitand(c_rand,tauss_temp);
urng_seg_temp0=dec2bin(tauss_rand);
% urng_seg_temp1=bitor(urng_seg_temp0,int64(0));
urng_seg_temp1=cellstr(urng_seg_temp0(1:1));
urng_seg_temp2=cellstr(urng_seg_temp0(2:3));
urng_seg_temp3=cellstr(urng_seg_temp0(4:18));
urng_seg_temp4=cellstr(urng_seg_temp0(4:64));
urng_seg1=bin2dec(urng_seg_temp1);
urng_seg2=bin2dec(urng_seg_temp2);
urng_seg3=bin2dec(urng_seg_temp3);
urng_seg4=bin2dec(urng_seg_temp4);

