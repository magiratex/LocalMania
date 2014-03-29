function G = refine_hypergraph(G, eid)

% M = size(G, 1);

for i = 1 : length(eid)
    id = eid(i);
    G(id, :) = 0;
    G(:, id) = 0;
end;