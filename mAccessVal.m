function [K, C, I, P] = mAccessVal(T, P, Gr)

% as we have the transition probabilities
% we can access the fixed parameters

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
        coeff = [coeff; xNeg, circshift(xNeg, j)];
        C = [C; c - circshift(c, j)];
        I = [I; ones(size(c, 1), 1) * i];
    end;
end;

K = zeros(size(C, 1), N);
for i = 1 : size(coeff, 1)
    K(i, coeff(i, 1)) = 1;
    K(i, coeff(i, 2)) = -1;
end;