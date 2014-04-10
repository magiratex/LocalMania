function [wHat, fval] = mOptimWeight(X, K, C, I, w0)

M = size(C, 1);

f = @(w) sum((sum(K .* X(I,:), 2) - w * C).^2)/M;

options = optimoptions('fminunc','Display', 'off');
[wHat, fval] = fminunc(f, w0, options);
wHat = 1/wHat;
