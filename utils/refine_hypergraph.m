function [G, invalidEdgeID] = refine_hypergraph(G, eid, ind)

% gMask = G(:, :) ~= 0;
gMask = zeros(size(G));

for i = 1 : length(eid)
    id = eid(i);
    gMask(id, :) = 1;
    gMask(:, id) = 1;
end;
bakG = G;
G = G .* gMask;

invalidEdgeID = [];
for i = 1 : length(eid)
    id = eid(i);
    if sum(G(id, :))==0 && sum(G(:,id))==0
        invalidEdgeID = [invalidEdgeID, i];
    end;
end;