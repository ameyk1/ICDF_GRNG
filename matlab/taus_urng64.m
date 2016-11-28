function [s1,s2,s3,c_rand]=taus_urng64(s1,s2,s3)
% -----------------------------------------
% s1,s2,s3 : input / initialized values
% c_rand : Tausworthe Random number
%  Ref : 
% -----------------------------------------
% Used for testing
% s1 = 11357407135578037661;
% s2 = 16405737874297512876;
% s3 = 13098074952039773637;
b=uint64(0);
tic;
b = bitshift(bitxor(bitshift(s1,13,'uint64'),s1),-19, 'uint64');
s1=bitxor(bitshift(bitand(s1,4294967294),12,'uint64'),b);
b = bitshift(bitxor(bitshift(s2,2,'uint64'),s2),-25,'uint64');        
s2=bitxor(bitshift(bitand(s2,4294967288),4,'uint64'),b);
b = bitshift(bitxor(bitshift(s3,3,'uint64'),s3),-11,'uint64');  
s3=bitxor(bitshift(bitand(s3,4294967280),17,'uint64'),b);
c_rand=bitxor(bitxor(s1,s2),s3);
fprintf(' Random number is : %64.0f \n',c_rand);
toc;