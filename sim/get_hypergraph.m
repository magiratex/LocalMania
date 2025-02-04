close all;
clear;
clc;
addpath('..\utils');

load pixWayptrs.mat;
sizeG = size(wayptrs, 1);

load edges.mat;
G = zeros(sizeG);

load portals.mat;

[hyG, hyind] = construct_hypergraph(sizeG);

edgeID = [];
for i = 1 : size(edges, 1)
    id = find(find_ind(edges(i,:), hyind) == 1);
    edgeID = [edgeID, id];
    
    id = find(find_ind(edges(i,[2,1]), hyind) == 1);
    edgeID = [edgeID, id];
    
    G(edges(i,1),edges(i,2)) = 1;
    G(edges(i,2),edges(i,1)) = 1;
end;

[hyG, noedge] = refine_hypergraph(hyG, edgeID, hyind);
% sparseG = sparse(hyG);

%%
[ei,ej] = find(hyG);

fig = imread('scene.png');
attr = zeros(size(hyG));
sparseRecord = [];

for i = 1 : size(ei, 1)

    imshow(fig);
    hold on;
    
    e0 = hyind(ei(i), 1); e1 = hyind(ei(i), 2);
    plot(wayptrs([e0,e1],1), wayptrs([e0,e1],2), '-b');
    
    
    % check
    if hyind(ei(i), 2) ~= hyind(ej(i), 1)
        fprintf('error!');
        break;
    end;
    
    if any(portals == e1) % portals cannot be the middle point
        continue;
    end;
    
    e1 = hyind(ej(i), 1); e2 = hyind(ej(i), 2);
    plot(wayptrs([e1,e2],1), wayptrs([e1,e2],2), '-r');
    text(wayptrs(e0,1)+0.8, wayptrs(e0,2), num2str(e0));
    text(wayptrs(e1,1)+0.8, wayptrs(e1,2), num2str(e1));
    text(wayptrs(e2,1)+0.8, wayptrs(e2,2), num2str(e2));
    
    fprintf('e0: %d ---> e1: %d ---> e2: %d\n', e0, e1, e2);
    
    val = input('attr: ');
    
    sparseRecord = [sparseRecord; ei(i), ej(i), e0, e1, e2, val];
    %attr(ei, ej) = val;
    hold off;
end;

for i = 1 : size(sparseRecord)
    attr(sparseRecord(i,1), sparseRecord(i,2)) = sparseRecord(i, end);
end;

% save attr attr;