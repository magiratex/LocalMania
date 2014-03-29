clear; 
clc; 
close all;

%%
% sizeG = 6;
% 
% [I, J] = ind2sub([sizeG, sizeG], 1:sizeG*sizeG);
% indices = [J; I]';
% startInd = [zeros(sizeG, 1), [1:sizeG]'];
% endInd = [[1:sizeG]', zeros(sizeG, 1)];
% indices = [startInd; endInd; indices];
% 
% % split sequence
% seq = [1, 3, 2, 2, 6, 4, 4, 4, 5, 2, 1, 4, 5];
% sseq = split_seq(seq, indices)
% 
% % % transform graph
% % zeroState = [0.1 0.3 0.6;  % initial probability
% %              0.4 0.5 0.1]; % ending probability
% % G = [0.0    0.1 0.9;
% %      0.0    0.0 0.0;
% %      0.2    0.3 0.5];
% % nG = trans_graph(G, zeroState, indices)

%% randomly build up a graph and gets its transition map
rng(19937);

sizeG = 10;
edgeN = 32;
edgeID = randi(sizeG*sizeG, 1, edgeN);
[I, J] = ind2sub([sizeG, sizeG], edgeID);
edges = [I; J]';
newGraph = zeros([sizeG, sizeG]);
for i = 1 : size(edges, 1)
    newGraph(edges(i,1), edges(i,2)) = 1;
end;
attr = rand(1, 10);

% generate ground-truth
T = gen_trans_attr(newGraph, attr, 0.31);
Emis = diag(ones(1, sizeG));

% generate seqences
% for i = 1 : 100
%     seq{i} = hmmgenerate(20, T, Emis);
% end;
seq = hmmgenerate(10000, T, Emis);

% generate initial transition map
trans = gen_trans_attr(newGraph, attr, 0.31)

for i = 1 : 3
    estT = hmmtrain(seq, trans, Emis);
    estW = guess_dcm_wts(estT, attr)
    estW = estW(1);
    trans = gen_trans_attr(newGraph, attr, estW)
end;

% % draw
% figure; hold on;
% coordinates = rand(sizeG, 2)*5;
% for i = 1 : sizeG
%     text(coordinates(i, 1), coordinates(i, 2), num2str(i));
% end;
% gplot(newGraph, coordinates);




