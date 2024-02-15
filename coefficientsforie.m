clc;
clear;
close all;
%%-------------------------------------------------

f = @(x)(exp(x));
N = 10;
tN = 100;

T = linspace(-pi, pi, tN);
fT = zeros(1, tN);
fV = zeros(1, tN);

a_0 = (1./pi).*(integral(f, -pi, pi));
a_n = zeros(1, N);
b_n = a_n;
for n = 1:N
    a_n(n) = (1./pi).*integral(@(x)(f(x).*cos(n.*x)), -pi, pi);
    b_n(n) = (1./pi).*integral(@(x)(f(x).*sin(n.*x)), -pi, pi);
end
for t = 1:numel(T)
    f1 = a_0/2;
    for n = 1:N
        f1 = f1 + a_n(n)*cos(n*T(t)) + b_n(n)*sin(n*T(t));
    end
    fT(t) = f1;
    %%------------------------------------------------------
    fV(t) = f(T(t));
end
%%-------------------------------------------------------------
plot(T, fV, '-', T, fT, ':');

