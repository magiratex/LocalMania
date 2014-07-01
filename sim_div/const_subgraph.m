addpath('..\utils');

load pixWayptrs_tradeshow_new.mat;
load edges_tradeshow_new_divA.mat;

%% construct a small graph
divptrs = [1,2,3,4,5,21,22,16,17,8,19]; % nodes id of division A
wayptrs = wayptrs(divptrs, :);
sizeg = size(wayptrs, 1);

[subhG, subhind] = construct_hypergraph(sizeg);

% re-index the nodes in division A to [1...N]
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

% setup a new graph and mark out the edges
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


%% load the corresponding prior
load attr_tradeshow_divA_interested.mat;
load graphInfo_tradeshow_divA.mat;
completeHypind = Gr.hypind;
hymatch = [];
for i = 1 : size(subedges, 1)
    pids = divptrs(subedges(i,1:2));
    hid = find(find_ind(pids, completeHypind));
    subhid = find(find_ind(subedges(i,1:2), subhind));
    
    hymatch = [hymatch; subhid, hid];
    
    pids = divptrs(subedges(i,[2,1]));
    hid = find(find_ind(pids, completeHypind));
    subhid = find(find_ind(subedges(i,[2,1]), subhind));
    
    hymatch = [hymatch; subhid, hid];
end;
subGr.match = hymatch;

usededges = hymatch(:,end)';
newedges = hymatch(:,1)';
subattr = zeros(subGr.size * subGr.size);
for i = 1 : numel(newedges)
    I = newedges(i);
    J = usededges(i);
    subattr(I,newedges) = attr(J,usededges);
end;
subGr.attr = subattr;

%% re-index the sequences and compute the initial probability
for i = 1 : numel(longseq)
    trk = longseq{i};
    
    h = [];
    for j = 1 : numel(trk)-1
        e0 = find(divptrs == trk(j));
        e1 = find(divptrs == trk(j+1));
        h(j) = find(find_ind([e0,e1], subhind));
    end;
    hseq{i} = h;
    initstate(i) = h(1);
end;

subGr.hseq = hseq;
for i = 1 : sizeg * sizeg
    init(i) = sum(initstate == i);
end;
subGr.init = init ./ sum(init);