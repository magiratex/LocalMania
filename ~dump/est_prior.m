function xval = est_prior(x, xhat, Gr)

% f = @(K) sum(sum((K(1) * log(bsxfun(@times, x, K(2:end))) - xhat).^2));
% f = @(K) sum(sum((K(1) * create_log_mat(bsxfun(@times, x, K(2:end))) - xhat).^2));
% xval = K(1) * create_log_mat(bsxfun(@times, x, K(2:end)));

% options = optimoptions('fminunc','Display', 'off', 'TolFun', 1e-4);
% [K, fval] = fminunc(f, ones(size(x,1)+1, 1), options);

sum(sum(abs(xhat - Gr.attr)))

K = ones(size(x,1), 1);
beta = 15.5;
prv = -1;
while 1
    Khat = f1(x, xhat, K);
    K = Khat;
    tempK = sum(Khat)/size(x,1)
    xEst = f2(x, xhat, K, beta);
    
    % cheat
    err = sum(sum(abs(xEst - Gr.attr)))
    
    fval = evalF(x, xhat, xEst, K, beta)
    
    xhat = xEst;
    if abs(prv - fval) < 1e-2
        break;
    else
        prv = fval;
    end;
end;
xval = xEst;


%%
% function mat = create_log_mat(mat)
% 
% mat = log(mat);
% mat(mat == -inf) = 0;


%% given x and estimate K
function K = f1(x, xhat, K0)

f = @(K) sum(sum((bsxfun(@times, x, K) - xhat).^2));

options = optimoptions('fminunc','Display', 'off', 'TolFun', 1e-4);
[K, fval] = fminunc(f, K0, options);

%% given K and estimate x
function x = f2(x0, xhat, K, beta)


f = @(x) sum(sum((bsxfun(@times, x0, K) - x).^2)) + ...
         beta * sum(sum((xhat - x).^2));
     
options = optimoptions('fminunc','Display', 'off', 'TolFun', 1e-4);
[x, fval] = fminunc(f, xhat, options);

%%
function fval = evalF(x0, xhat, x, K, beta)

fval = sum(sum((bsxfun(@times, x0, K) - x).^2)) + ...
         beta * sum(sum((xhat - x).^2));