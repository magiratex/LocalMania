function attr = guess_attr(T, w, P, Gr)

MMin = 1e-5;
N = size(T, 1);

coeff = [];
C = [];

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
    end;
end;

C = C / w;
K = zeros(size(C, 1), N);
for i = 1 : size(coeff, 1)
    K(i, coeff(i, 1)) = 1;
    K(i, coeff(i, 2)) = -1;
end;

x = eye(N)/(eye(N) + K' * K) * (P' + K' * C);
attr = x';