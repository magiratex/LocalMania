function [xHat, fval] = mOptimState(K, C, I, P, beta)

N = size(K, 2);
M = size(C, 1);

f = @(X) sum(sum((X - P).^2))/N^2 + beta * sum((sum(K .* X(I,:), 2) - C).^2)/M;

options = optimoptions('fminunc','Display', 'off', 'TolFun', 1e-4);
[xHat, fval] = fminunc(f, P, options);
% options = optimoptions('fmincon','Display', 'off');
% [xHat, fval] = fmincon(f, P, [], [], [], [], zeros(N), ones(N).*(P~=0), [], options);