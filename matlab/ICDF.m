% % % ------- ICDF Function Plot ----------
% mu = 0;
% sigma = 1;
% pd = makedist('Normal',mu,sigma);
% y=rand(10000,1);
% x = icdf(pd,y);
% scatter(y,x)
% grid on;
% % % ----------------------------

clearvars;
clc;

N=256;
% upper bound 1-2^-14
upb = 1 - (2.^-14);

fprintf(1, '\nCalculating Natural Log coefficients\n');

% create vector of equally spaced points in [0,upb]
x = linspace(1,2,N+2);
y = -log(x);
syms C2 C1 C0 ;
% compute 2nd-degree interpolating polynomial
for i = 1: size(x,2)-2;
    YY = solve([(C2*(x(1,i))+C1)*x(1,i)+C0 == y(1,i),(C2*(x(1,i+1))+C1)*y(1,i+1)+C0 == y(1,i+1),(C2*(x(1,i+2))+C1)*x(1,i+2)+C0 == y(1,i+2)],[C0,C1,C2]);
    coef(i,1) = single(YY.C0);
    coef(i,2) = single(YY.C1);
    coef(i,3) = single(YY.C2);
    fprintf('    i=%4d X=%12.8f C2=%12.8f C1=%12.8f C0=%12.8f\n', i, x(1,i), coef(i,3), coef(i,2), coef(i,1))
end
