%% Start
clc;
clear;
close all;
%% Figure
figure;
hold on;
grid on;
xlabel('x');
ylabel('y(x)');
c = ['b', 'g', 'r', 'k', 'm', 'c'];
%% Init
M = 5;
N = 10;
x = linspace(0, 1, N);
xtL = cell(1, M);
%% Euler
for im = 1:M
    Ex = zeros(1, N);
    for in = 0:im
        sKx = zeros(1, N);
        for ik = 0:in
            sKx = sKx + (-1)^ik*nchoosek(in, ik)*(x + ik).^im;
        end
        Ex = Ex + sKx/2^in;
    end
	xtL{im} = ['E_', num2str(im), '(x)'];
    plot(x, Ex, [c(im), '-*']);
end
%% End
legend(xtL,'Location','northwest');