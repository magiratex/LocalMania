function G = rand_trans_prob(G)

E = size(G, 1);

%% randomly generate transition probability
for i = 1 : E
    N = sum(G(i, :));
    pr = rand(1, N);
    pr = pr ./ sum(pr);
    G(i, G(i,:)==1) = pr;
end;
