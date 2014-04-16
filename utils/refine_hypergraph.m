function [G, invalidEdgeID] = refine_hypergraph(G, eid, ind)

% gMask = zeros(size(G));
% 
% for i = 1 : length(eid)
%     id = eid(i);
%     gMask(id, :) = 1;
%     gMask(:, id) = 1;
% end;

N = size(G, 1);
gMask = ones(N, N);

for i = 1 : N
    if ~any(eid == i)
        gMask(i, :) = 0;
        gMask(:, i) = 0;
    end;
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