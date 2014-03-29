% Guess the weights of DCM based on the transition probability matrix

function w = guess_dcm_wts(tmap, attr)

N = size(tmap, 1);
X = [];
Y = [];
for i = 1 : N
    validIdx = [];
    validProb = [];
    for j = 1 : N
        if tmap(i, j)
            validIdx = [validIdx, j];
            validProb = [validProb, tmap(i, j)];
        end;
    end;
    x = attr(validIdx)';
    c = log(validProb)';
    for j = 1 : length(x)-1
        X = [X; x - circshift(x, j)];
        Y = [Y; c - circshift(c, j)];
    end;
end;

plot(X, Y, '.');
xlim([-3, 3]);
ylim([-3, 3]);
w = polyfit(X, Y, 1);