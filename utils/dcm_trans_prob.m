function G = dcm_trans_prob(G, ind, w, attr, corr)

E = size(G, 1);

%% randomly generate transition probability

if isempty(corr)
    
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

else
    
    for i = 1 : E

        I = find(G(i, :) == 1);
        prev = ind(i, :);
        for j = 1 : length(I)
            curr = ind(I(j), :);
            if prev(1) == curr(2)
                G(i, I(j)) = exp(w * [0.01, corr(i,I(j))]');
            else
                G(i, I(j)) = exp(w * [attr(curr(2)), corr(i,I(j))]');
            end;
        end;
        G(i, I) = G(i, I) ./ sum(G(i, I));
    end;

    
end;
