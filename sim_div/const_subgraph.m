addpath('..\utils');

load pixWayptrs_tradeshow_new.mat;
% load edges_tradeshow_new_divA.mat;
% load edges_tradeshow_new_divB.mat;
load edges_tradeshow_new_divC.mat;
% load edges_tradeshow_new_divD.mat;

%% construct a small graph
% divptrs = [1,2,3,4,5,21,22,16,17,8,19]; % nodes id of division A
% tempout = [21,22,17,5,8,19];
% divptrs = [4,16,5,6,17,7,9,14,15,18]; % division B
% tempout = [4,16,14,15,18,9];
divptrs = [7,14,15,18,13,9,12,26,19,20]; % division C
tempout = [7,19,20,26];
% divptrs = [9,12,3,19,10,20,25,8,11,23,24]; % division D
% tempout = [3,9,12,23,24,25];
% divptrs = [9,12,3,19,10,20,25,8,11,23,24,16]; % division D
% tempout = [3,9,12,23,24,25,16];

%%
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
% load attr_tradeshow_divA_interested.mat;
% load attr_tradeshow_divA_low2.mat;
% load attr_tradeshow_divB.mat;
load attr_tradeshow_divC.mat;
% load attr_tradeshow_divD.mat;
% load graphInfo_tradeshow_divA.mat;
% load graphInfo_tradeshow_divB.mat;
load graphInfo_tradeshow_divC.mat;
% load graphInfo_tradeshow_divD.mat;

%%
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

% % tweak down the return behavior
% for i = 1 : size(subGr.G, 1)
%     idx = find(subGr.G(i, :)~=0);
%     for j = idx
%         e0 = subGr.ind(i,1);
%         e2 = subGr.ind(j,2);
%         if any(tempout == divptrs(e0)) && any(tempout == divptrs(e2))
%             subattr(i, j) = 0;
%         end;
%     end;
% end;
subGr.attr = subattr;
subGr.tempout = tempout;

%% re-index the sequences and compute the initial probability
clear hseq;
% targseq = longseq;
% targseq = shortseq;
targseq = specialseq;
for i = 1 : numel(targseq)
    trk = targseq{i};
    
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

%% 
save('seq_tradeshow_new_divC_avoid12.mat', 'subGr');