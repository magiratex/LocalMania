function xval = est_prior3(x, xhat, Gr)

% f = @(K) sum(sum((K(1) * log(bsxfun(@times, x, K(2:end))) - xhat).^2));
% f = @(K) sum(sum((K(1) * create_log_mat(bsxfun(@times, x, K(2:end))) - xhat).^2));
% xval = K(1) * create_log_mat(bsxfun(@times, x, K(2:end)));

% options = optimoptions('fminunc','Display', 'off', 'TolFun', 1e-4);
% [K, fval] = fminunc(f, ones(size(x,1)+1, 1), options);

beta = 0.5;
K0 = ones(size(x,1), 1);
% x0 = (xhat - 0.1).*Gr.attr;
x0 = xhat;

f = @(P) sum(sum((bsxfun(@times, x, P(:,1)) - P(:,2:end)).^2)) + ...
         beta * sum(sum((xhat - P(:,2:end)).^2));

options = optimoptions('fminunc','Display', 'off', 'TolFun', 1e-4);
[P, fval] = fminunc(f, [K0, x0], options);
xval = bsxfun(@times, x, P(:,1));
sum(sum(abs(xhat - Gr.attr)))
sum(sum(abs(xval - Gr.attr)))

end