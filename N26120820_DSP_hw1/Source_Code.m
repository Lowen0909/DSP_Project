%Problem 1 solution
function discrete_exp(range,e)
   result=e.^range;
   figure;
   stem(range,result);
   str=sprintf('x[n]= %.1f^n',e);
   title(str);
   xlabel('n');
   ylabel('x[n]');
   
end

discrete_exp(0:20,0.9);

%Problem 2 solution
%Problem 2(a)
function y = func(x, n,prev)
 if (n < 0)
 %assume initial rest conditions i.e. y=0 for n<0
   y=0;
 elseif (n == 0)
    y=x(11);
 else 
 %# The recursive loop
    y=1.8 * cos(pi/16)*prev(n+10) - 0.81 * prev(n+9) + x(n+11) +0.5*x(n+10);
 end
end

y=zeros(1,111);
x=zeros(1,111);
x(11)=1;
i=-10;
while i<101
    y(i+11)=func(x,i,y);
    i=i+1;
end
x1=-10:100;
figure; 
stem(x1,y);
title('h[n] by recursion');
xlabel('n');
ylabel('h[n]');


%Problem 2(b)
B = [1, 0.5, 0]; %# Coefficients for x
A = [1, -1.8*cos(pi/16), 0.81]; %# Coefficients for y
y = filter(B, A, x); 
figure; 
x1=-10:100;
stem(x1,y);
title('h[n] using filter function');
xlabel('n');
ylabel('h[n]');