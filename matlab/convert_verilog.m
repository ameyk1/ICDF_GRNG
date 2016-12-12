function [coef_verilog]= convert_verilog(frac_bits,total_bits,coef)
% The code uses dec2fix and dec2twos from Matlab 
% Found this in Spring 2013 as a TA for CMPE415 course at UMBC
% --------------------------------------------------------
% frac_bits: Gathered from flot2fix and acc_mat files
% dec_bits: Interger bits in a given number
% coef: coeffiecints obtainted from Polynomical solve
% coef_verilog: converted verilog bits in binary
% --------------------------------------------------------

for i=1:size(coef,1)
    coef0_bin = dec2fix(coef(i,1),frac_bits(1),total_bits(1));
    coef1_bin = dec2fix(coef(i,2),frac_bits(2),total_bits(2));
    coef2_bin = dec2fix(coef(i,3),frac_bits(3),total_bits(3));
    
	coef_verilog{i,1} =  strjoin(cellstr(num2str(coef0_bin'))','');
	coef_verilog{i,2} =  strjoin(cellstr(num2str(coef1_bin'))','');
	coef_verilog{i,3} =  strjoin(cellstr(num2str(coef2_bin'))','');
end
end
