clear all; clc;
% ----------------------------------------------------------------
%  This script is used to generate 2nd degree polynomial for Chebyshev 
%  As discussed in Section 3A Ref 
% ----------------------------------------------------------------
N=128; % Based on Segment bits locations = 128
a= linspace(1,2,N+2);
b = chebyshevT(2,a);
coef=zeros((size(a,2)-2),3);
syms coef2 coef1 coef0;
for i = 1: size(a,2)-2;
%     By Prof Luk et.al. "Hierarchical segmentation schemes for function
%     evaluation" Section 2 According Horner's rule (equ.5)
    YY = solve([(coef2*(a(1,i))+coef1)*a(1,i)+coef0 == b(1,i),(coef2*(a(1,i+1))+coef1)*b(1,i+1)+coef0 == b(1,i+1),(coef2*(a(1,i+2))+coef1)*a(1,i+2)+coef0 == b(1,i+2)],[coef0,coef1,coef2]);
    coef(i,1) = single(YY.coef0);
    coef(i,2) = single(YY.coef1);
    coef(i,3) = single(YY.coef2);
end
% Saving Coefficients for Matlab use
save('coef.mat','coef');
%  Fixed to Q2.18 fixed point
coef0_fix=float2fix(coef(:,1),18);
coef0_fix_acc=acc_mat(coef(:,1),coef0_fix,0.000005);
% Fixed to Q3.14 fixed point
coef1_fix=float2fix(coef(:,2),14);
coef1_fix_acc=acc_mat(coef(:,2),coef1_fix,0.00005);
% Fixed to Q1.17 fixed point
coef2_fix=float2fix(coef(:,3),17);
coef2_fix_acc=acc_mat(coef(:,3),coef2_fix,0.000005);
%  Integer and Fractional Bits
frac_bits = [18,14,17];
dec_bits = [3,4,1];
%  Converting Decimal to Binary for Hardware Verilog Code
[coef_verilog]=convert_verilog(frac_bits,dec_bits,coef);
% Printing coef_verilog in file to copy in ROM_coef.v verilog file
fileID = fopen('coef_verilog.txt', 'w');
for i= 1: N
    fprintf(fileID,'7''d%4d : coef_acc = %4d''b%s___%s___%s;\n',i-1,57,coef_verilog{i,3}, coef_verilog{i,2}, coef_verilog{i,1});
end