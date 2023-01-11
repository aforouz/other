%% Start
clc;
clear;
close all;

%% Prob
% Max Z: c*x, A*x=b
%{
% Prob 1
Mm = true;
cj = [2, 1];
A = [3, 4; 6, 1];
cb = [6; 3];
%}
%{
% Prob 2
Mm = true;
cj = [1, 2];
A = [1, 1; 1, 2; 3, 1];
cb = [3; 5; 6];
%}
%{
% Prob 3
Mm = false;
cj = [2, -1];
A = [-1, 1; 2, 1];
cb = [2; 6];
%}
%{
% Prob 4
Mm = false;
cj = [1,2,-7,1];
A = [6,-4,15,-2; 1,-1,5,-1];
cb = [20; 8];
%}
%
% Prob 5
Mm = false;
cj = [0, 1];
A = [-1, 1; 1, 1];
cb = [1; 2];
%}
%% Algo
N = length(cb)+1;
Nx = length(cj);
% 1
S = [eye(N), [-cj; A], [0; cb]];
while true
    S
    % 2
    Sb = S(:, end);
    SA = S(:, 2:end-1);
    B = S(:, 1:N);
    % 3
    u = B*SA;
    if Mm
        if all(u(1,:) > -eps)
            break;
        end
    else
        if all(u(1,:) < eps)
            break;
        end
    end
    % 4
    if Mm
        [~, idxJ] = min(u(1,:));
    else
        [~, idxJ] = max(u(1,:));
    end
    % 5
    uj = u(:,idxJ);
    if all(uj < eps)
        error('Inf');
    end
    % 6
    xb = Sb./uj;
    idxI = 0;
    minx = max(xb);
    for i = 1:N
        if 0 < xb(i) && xb(i) < minx
            idxI = i;
            minx = xb(i);
        end
    end
    if idxI == 0
        error('Inf');
    end
    % 7
    E = eye(N);
    E(:, idxI) = -SA(:, idxJ)/SA(idxI, idxJ);
    E(idxI, idxI) = 1/SA(idxI, idxJ);
    % 8
    S = E*S;
end
%% Sol
if Mm
    fprintf('Max Z: %f\n', S(1, end));
else
    fprintf('Min Z: %f\n', S(1, end));
end
xZ = zeros(Nx, 1);
for i = 1:Nx
    p = S(:, N+i);
    if length(p(p<eps))==N-1 && length(p(p==1))==1
        p = find(p==1);
        xZ(p) = S(p, end);
    end
end
for i = 1:Nx
    fprintf('x%d: %f\n', i, xZ(i));
end