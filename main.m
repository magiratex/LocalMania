clear;
clc;
close all;

addpath('.\utils');

rng(197);

%% initialize graph information
%   - graph structure
%   - attractions of nodes
%   - attractions affected by other nodes based on distances
%   - correlation between links

Gr = init_graph;



%% generate sequences
[seq, hseq, Gr] = generate_data(Gr);


%% estimate weights of dcm
% Initialization
% w = [0.5, 0.1];
% T = dcm_trans_prob(Gr.G, Gr.ind, w, Gr.attr, Gr.corr);
w = 0.1;
T = dcm_trans_prob(Gr.G, Gr.ind, w, Gr.attr, []);
w = guess_dcm_wts2(T, Gr)

M = size(T, 1);

% % draw
% figure; hold on;
% coordinates = rand(M, 2)*5;
% for i = 1 : M
%     text(coordinates(i, 1), coordinates(i, 2), num2str(i));
% end;
% gplot(Gr.G, coordinates);

MMin = 1e-5;
eHat = [zeros(1, M); 
        diag(ones(1, M))];    
% eHat = [diag(ones(1, M))];
attrPrior = Gr.attr;

% Iteratively procedure
for i = 1 : 3
    tic
    tHat = [0,          Gr.init; 
            zeros(M,1), T;
            ];
%     tHat = T;
%     tHat (tHat < MMin) = MMin;
    
    estT = hmmtrain(hseq, tHat, eHat, 'Verbose',true, 'Tolerance', 1e-3);
    T = estT(2:end, 2:end);
%     T = estT;
    w = guess_dcm_wts2(T, Gr)
    estAttr = guess_attr(T, w, attrPrior, Gr);
    T = dcm_trans_prob(Gr.G, Gr.ind, w(2:3)', estAttr, []);
    toc
end;

