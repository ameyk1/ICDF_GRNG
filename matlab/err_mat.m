function [error_rate]=err_mat(A,B)
[rowA,columnA]=size(A);
[rowB,columnB]=size(B);
total=rowA*columnA;
c=zeros(rowA,columnA);
for i =1:rowA
    for j=1:columnA
        c(i,j)=abs(A(i,j)-B(i,j))/abs(B(i,j));    
        end
    end

avg_c=mean(c);
avg_c_dash=mean(avg_c');
error_rate=avg_c_dash*100;
end