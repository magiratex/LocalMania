function [attr, fval] = guess_attr(T, w, P, Gr)

MMin = 1e-5;
N = size(T, 1);

coeff = [];
C = [];
I = [];

for i = 1 : N
    xNeg = []; % neighboring indices
    c = [];
    for j = 1 : N
        if T(i, j) > MMin && Gr.G(i, j)
            xNeg = [xNeg; j];
            c = [c; log(T(i, j))];
        end;
    end;
    for j = 1 : length(c)-1
        %X = [X; x - circshift(x, j)];
        coeff = [coeff; xNeg, circshift(xNeg, j)];
        C = [C; c - circshift(c, j)];
        I = [I; ones(size(c, 1), 1) * i];
    end;
end;

C = C / w;
K = zeros(size(C, 1), N);
for i = 1 : size(coeff, 1)
    K(i, coeff(i, 1)) = 1;
    K(i, coeff(i, 2)) = -1;
end;
M = size(C, 1);

% x = (eye(N) + K' * K) - (P' + K' * C);
% attr = x';

beta = 0.01;
f = @(X) sum(sum((X - P).^2))/N^2 + beta * sum((sum(K .* X(I,:), 2) - C).^2)/M;

options = optimoptions('fminunc','Display', 'off');
[attr, fval] = fminunc(f, P, options);

% X = fminunc(@efunc, P);

% function F = efunc(X, P, I, C)
% 
% F = sum(sum((X - P).^2)) + sum((sum(K .* X(I,:), 2) - C).^2);
