function [wHat, fval] = mOptimWeight(X, K, C, I, w0)


% f = @(w) sum((sum(K .* X(I,:), 2) - w * C).^2);
% 
% options = optimoptions('fminunc','Display', 'off');
% [wHat, fval] = fminunc(f, 1/w0, options);
% wHat = 1/wHat;

x = sum(K .* X(I, :), 2);
y = C;
[w, fval] = glmfit(x, y);
wHat = w(end);
