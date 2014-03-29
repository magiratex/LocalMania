clear;
clc;
close all;

addpath('.\utils');

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
w = [0.1, 0.1];
T = dcm_trans_prob(Gr.G, Gr.ind, w, Gr.attr, Gr.corr);
% w = guess_dcm_wts2(T, Gr)

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

% Iteratively procedure
for i = 1 : 3
    tHat = [0,          Gr.init; 
            zeros(M,1), T;
            ];
    
    
    tHat (tHat < MMin) = MMin;
    estT = hmmtrain(hseq, tHat, eHat, 'Verbose',true, 'Tolerance', 1e-3);
    T = estT(2:end, 2:end);
    w = guess_dcm_wts2(T, Gr)
    T = dcm_trans_prob(Gr.G, Gr.ind, w(2:3)', Gr.attr, Gr.corr);
end;

