close all;
clear;
clc;
addpath('..\utils');

% load pixWayptrs.mat;
load pixWayptrs_tradeshow_new.mat;

% load edges.mat;
% load edges_tradeshow_new_divA.mat;
% load edges_tradeshow_new_divB.mat;
load edges_tradeshow_new_divC.mat;
% load edges_tradeshow_new_divD.mat;

load portals_tradeshow_new.mat;

% load graphInfo_tradeshow_divA.mat;
% load graphInfo_tradeshow_divB.mat;
load graphInfo_tradeshow_divC.mat;
% load graphInfo_tradeshow_divD.mat;

% load attr_tradeshow_divA_interested.mat;
% load attr_tradeshow_divA_low2.mat;
% load attr_tradeshow_divB.mat;
load attr_tradeshow_divC.mat;
% load attr_tradeshow_divD.mat;

fig = imread('map4.png');

cmap = 'cymgbrk';

%%



figure;
imshow(fig);
hold on;

for i = 1 : size(wayptrs, 1)
    plot(wayptrs(i,1), wayptrs(i,2), 'ob');
    text(wayptrs(i,1)+0.8, wayptrs(i,2), num2str(i));
end;

%%
% 

% tempPortal = [21, 22, 5, 17, 19, 8]; % division A's portals
% tempPortal = [4, 16, 14, 15, 18, 9]; % division B's portals
tempPortal = [7, 19, 20, 26]; % division C's portals
% tempPortal = [3,9,12,23,24,25]; % division D's portals

Nsample = 3000;
seq = cell(1, Nsample);

%%
for i = 1 : Nsample

    %%
%     id = randsample(numel(tempPortal), 1, true, [.3, .3, .1, .1, .1, .1]);% divA
%     id = randsample(numel(tempPortal), 1, true, repmat(0.1667, [1, 6]));% divA
%     id = randsample(numel(tempPortal), 1, true, repmat(0.1667, [1, 6]));% divB
    id = randsample(numel(tempPortal), 1, true, [.2, .2, .2, .4]);% divC
%     id = randsample(numel(tempPortal), 1, true, repmat(0.1667, [1, 6]));% divD
    e0 = tempPortal(id);
    
    
    %% randomly select one its connected node and its index
    idx = find(Gr.origG(e0, :)~=0);
    selectid = randi(numel(idx));
    e1 = idx(selectid);
    hyid = find(find_ind([e0, e1], Gr.hypind));
    trk = [e0 e1];
    
    % find its succedant
    while 1
        sucid = find(Gr.G(hyid,:) ~= 0);
        
        if sum(attr(hyid, sucid)) == 0
            trk = [];
            seq{i} = trk;
            break;
        end;
        w = attr(hyid, sucid)./sum(attr(hyid, sucid));
        selectsucid = randsample(numel(sucid), 1, true, w);
        selectsucid = sucid(selectsucid);

        trk = [trk, Gr.hypind(selectsucid, 2)];
        if any(tempPortal == trk(end))
            break;
        end;
        hyid = selectsucid;
    end;
%     trk
    seq{i} = trk;

    verbose = 0;
    if verbose == 1
        thiscol = cmap(randi(7));
        trk
        for j = 1 : numel(trk)-1
            I = trk(j);
            J = trk(j+1);
            plot([wayptrs(I,1), wayptrs(J,1)], ...
                 [wayptrs(I,2), wayptrs(J,2)], ['-',thiscol]);
        end;
    end;
end;

%%
longseq = [];
sid = 1;
for i = 1 : numel(seq)
    
    if length(seq{i}) > 5
        longseq{sid} = seq{i};
        sid = sid + 1;
    end;
end;

%%

shortseq = [];
sid = 1;
for i = 1 : numel(seq)
    
    if length(seq{i}) < 5 && length(seq{i})>0
        shortseq{sid} = seq{i};
        sid = sid + 1;
    end;
end;

%%
specialseq = [];
sid = 1;
for i = 1 : numel(seq)
%     destination = seq{i}(end);
%     if destination == 9 || destination == 12
%     if destination == 17 || destination == 5
%     if destination == 7
%     start = seq{i}(1);
    if ~any(seq{i}(:) == 12)
        specialseq{sid} = seq{i};
        sid = sid + 1;
    end;
end;



