close all;
clear;
clc;
addpath('..\utils');

% load pixWayptrs.mat;
load pixWayptrs_Campus.mat;
sizeG = size(wayptrs, 1);

% load edges.mat;
load edges_Campus1+2.mat;
G = zeros(sizeG);

load portals_Campus1+2.mat;

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

% fig = imread('scene.png');
fig = imread('map2.png');
attr = zeros(size(hyG));
%% load previous data
load attr_Campus1.mat;

%%
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
    
%     if any(portals == e1) % portals cannot be the middle point
%         continue;
%     end;

    e1 = hyind(ej(i), 1); e2 = hyind(ej(i), 2);
    
    %% special conditions (limited in this map!)
    I1 = find(find_ind([e0,e1], hyind));
    I2 = find(find_ind([e1,e2], hyind));
    if attr(I1,I2)~=0
        hold off;
        continue;
    end;
    
    if ~isempty(sparseRecord)
        existSame = arrayfun(@(k) sparseRecord(k,1)==ei(i) && sparseRecord(k,2)==ej(i), ...
                      1:size(sparseRecord, 1));
        if sum(existSame)
            hold off;
            continue;
        end;
    end;
    
    if e1 == 1
        val = -1.5;
        sparseRecord = [sparseRecord; ei(i), ej(i), e0, e1, e2, val];
%         fprintf('e0: %d ---> e1: %d ---> e2: %d\n', e0, e1, e2);
%         fprintf('also fill in e2: %d ---> e1: %d ---> e0: %d\n', e2, e1, e0);
        I1 = find(find_ind([e2,e1], hyind));
        I2 = find(find_ind([e1,e0], hyind));
        sparseRecord = [sparseRecord; I1, I2, e2, e1, e0, val];
        hold off;
        continue;
    end;
    
    if e0 == e2 % return behavior
        val = -1.0;
        sparseRecord = [sparseRecord; ei(i), ej(i), e0, e1, e2, val];
%         fprintf('e0: %d ---> e1: %d ---> e2: %d\n', e0, e1, e2);
        hold off;
        continue;
    end;
    
    
    
    %%
    plot(wayptrs([e1,e2],1), wayptrs([e1,e2],2), '-r');
    text(wayptrs(e0,1)+0.8, wayptrs(e0,2), num2str(e0));
    text(wayptrs(e1,1)+0.8, wayptrs(e1,2), num2str(e1));
    text(wayptrs(e2,1)+0.8, wayptrs(e2,2), num2str(e2));
    
    fprintf('e0: %d ---> e1: %d ---> e2: %d\n', e0, e1, e2);
    
    val = input('attr: ');
    
    sparseRecord = [sparseRecord; ei(i), ej(i), e0, e1, e2, val];
    fprintf('also fill in e2: %d ---> e1: %d ---> e0: %d\n~~~~~~~~~\n', e2, e1, e0);
    I1 = find(find_ind([e2,e1], hyind));
    I2 = find(find_ind([e1,e0], hyind));
    sparseRecord = [sparseRecord; I1, I2, e2, e1, e0, val];
    hold off;
end;

for i = 1 : size(sparseRecord)
    attr(sparseRecord(i,1), sparseRecord(i,2)) = sparseRecord(i, end);
end;

% save attr attr;