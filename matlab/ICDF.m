 % % ------- ICDF Function Plot ----------
 mu = 0;
 sigma = 1;
 pd = makedist('Normal',mu,sigma);
 y=rand(10000,1);
 x = icdf(pd,y);
 scatter(y,x)
 grid on;
 % % ----------------------------
