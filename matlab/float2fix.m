% Amey Kulkarni (PhD Student@EEHPC,UMBC)
% Floating point to Fixed Point conversion
% Please do not misuse the code ( such as a Home work solution) 
function [fix_no]=float2fix(float_no,f)
% float_no: Floating Number to be Converted
% f : Bit Resolution
% fix_no: Converted fixed point number
[float_r,float_c]=size(float_no);
for i=1:float_r
    for j=1:float_c
            fix_primary=float_no(i,j)*2^f;
            fix_round=round(fix_primary);
            fix_no(i,j)=fix_round/2^f;
     end
end



