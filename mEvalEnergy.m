function E = mEvalEnergy(X, K, C, I, P, w, beta)

M = size(C, 1);
N = size(K, 2);

E = sum(sum((X - P).^2))/N^2 + beta * sum((sum(K .* X(I,:), 2) - C/w).^2)/M;