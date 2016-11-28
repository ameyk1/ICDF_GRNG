% Amey Kulkarni (PhD Student@EEHPC,UMBC)
% Accuracy of fractional bits
% Please do not misuse the code (such as a Home work solution) 
function [accuracy,error_index,error_difference]=acc_mat(A,B,band)
[rowA,columnA]=size(A);
[rowB,columnB]=size(B);
total=rowA*columnA;
count=0;
for i =1:rowA
    for j=1:columnA
        if abs(A(i,j)-B(i,j))<band
            count=count+1;
        end
    end
end
accuracy=(count/total)*100;