function w = guess_dcm_wts2(T, Gr)

MMin = 1e-5;
N = size(T, 1);
X = [];
Y = [];

for i = 1 : N
%     validIdx = [];
%     validProb = [];
    x = [];
    c = [];
    for j = 1 : N
        if T(i,j) > MMin && Gr.G(i,j)
%             validIdx = [validIdx, j];
%             validProb = [validProb, tmap(i, j)];
            prev = Gr.ind(i, :);
            curr = Gr.ind(j, :);
            if prev(1) == curr(2)
                x = [x; 0.01];
                %x = [x; 0.01, Gr.corr(i,j)];
            else
                x = [x; Gr.attr(curr(2))];
                %x = [x; Gr.attr(curr(2)), Gr.corr(i,j)];
            end;
            c = [c; log(T(i, j))];
        end;
    end;
    for j = 1 : length(x)-1
        X = [X; x - circshift(x, j)];
        Y = [Y; c - circshift(c, j)];
    end;
end;

% figure;
% hold on;
% plot(X(:,1), Y, '.');
% plot(X(:,2), Y, 'xr');
% xlim([-3, 3]);
% ylim([-3, 3]);
[w, dev] = glmfit(X, Y);