addpath('..\utils');

load pixWayptrs_tradeshow_new.mat;
load edges_tradeshow_new_divA.mat;

%% construct a small graph
divptrs = [1,2,3,4,5,21,22,16,17,8,19]; % nodes id of division A
wayptrs = wayptrs(divptrs, :);
sizeg = size(wayptrs, 1);

[subhG, subhind] = construct_hypergraph(sizeg);

subedges = [];
for i = 1 : size(edges, 1)
    e0 = find(divptrs == edges(i,1));
    e1 = find(divptrs == edges(i,2));
    if ~isempty(e0) && ~isempty(e1)
        subedges = [subedges; [e0, e1, edges(i,3:4)]];
    end;
end;
subGr.size = sizeg;
subGr.edges = subedges;

subedgeID = [];
subG = zeros(sizeg);
for i = 1 : size(subedges, 1)
    id = find(find_ind(subedges(i,1:2), subhind) == 1);
    subedgeID = [subedgeID, id];
    
    id = find(find_ind(subedges(i,[2,1]), subhind) == 1);
    subedgeID = [subedgeID, id];
    
    subG(subedges(i,1), subedges(i,2)) = 1;
    subG(subedges(i,2), subedges(i,1)) = 1;
end;

[subhG, ~] = refine_hypergraph(subhG, subedgeID, subhind);
subGr.G = subhG;
subGr.ind = subhind;
subGr.edgeID = subedgeID;

%%
load attr_tradeshow_divA_interested.mat;
attr = attr(divptrs, :);
attr = attr(:, divptrs);
subGr.attr = attr;

%%


for i = 1 : numel(longseq)
    trk = longseq{i};
    for j = 1 : numel(trk)-1
        e0 = find(divptrs == trk(j));
        e1 = find(divptrs == trk(j+1));
        h(j) = find(find_ind([e0,e1], subhind));
    end;
    hseq{i} = h;
end;

subGr.hseq = hseq;
