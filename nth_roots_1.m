clc;
clear;
close all;

n = input('n: ');
x = zeros(n+1, 1);
y = x;
for k = 0:(n-1)
    x(k+1) = cos(2*k*pi/n);
    y(k+1) = sin(2*k*pi/n);
end
x(n+1) = x(1);
y(n+1) = y(1);

plot(x, y);
hold on;
grid on;
axis equal;
fimplicit(@(a,b)(a.^2 + b.^2 - 1));