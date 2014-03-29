function G = dcm_trans_prob(G, ind, w, attr)

E = size(G, 1);

%% randomly generate transition probability
for i = 1 : E

    I = find(G(i, :) == 1);
    prev = ind(i, :);
    for j = 1 : length(I)
        curr = ind(I(j), :);
        if prev(1) == curr(2)
            G(i, I(j)) = exp(w * 0.01);
        else
            G(i, I(j)) = exp(w * attr(curr(2)));
        end;
    end;
    G(i, I) = G(i, I) ./ sum(G(i, I));
end;
