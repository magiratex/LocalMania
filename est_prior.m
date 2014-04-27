function xval = est_prior(x, xhat)

f = @(K) sum(sum((bsxfun(@times, x, K)-xhat).^2));

options = optimoptions('fminunc','Display', 'off', 'TolFun', 1e-4);
[K, fval] = fminunc(f, P, options);
xval = bsxfun(@times, x, K);