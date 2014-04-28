function xval = est_prior4(x, xhat, Gr)

wprior = 2.1;
xval = zeros(size(x));
for i = 1 : size(xhat, 1)
    if sum(x(i, :)) == 0
        k(i) = 1;
        continue;
    end;
    y = exp(wprior * xhat(i, :));
    y(y == 1) = 0;
    w = glmfit(x(i, :), y);
    k(i) = w(end);
    xv = log(k(i) * x(i,:))./wprior;
    xv(xv==-inf) = 0;
    xval(i,:) = xv;
%     xval(i,:) - xhat(i,:)
end;

end