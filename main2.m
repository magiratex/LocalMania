clear;
clc;
close all;

addpath('.\utils');
warning('OFF', 'optim:fminunc:SwitchingMethod');

rng(371);

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
w = 0.8;
T = dcm_trans_prob(Gr.G, Gr.ind, w, Gr.attr, []);
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
beta = 0.01;
eHat = [zeros(1, M); 
        diag(ones(1, M))];    
% eHat = [diag(ones(1, M))];
% attrPrior = max((Gr.attr + rand(M)*0.1), 0) .* Gr.G;
% attrPrior = (Gr.attr + rand(M)*0.1) .* Gr.G;
attrPrior = Gr.attr;

%%
tHat = [0,          Gr.init; 
        zeros(M,1), T;
        ];
estT = hmmtrain(hseq, tHat, eHat, 'Verbose',true, 'Tolerance', 1e-3);
T = estT(2:end, 2:end);

[K, C, I, P] = mAccessVal(T, attrPrior, Gr);

pE = -1;
flag = false;
for i = 1 : 1000
    [xHat, ~] = mOptimState(K, C/w, I, P, beta);
    [wHat, ~] = mOptimWeight(X, K, C, I, w);
    E = mEvalEnergy(xHat, K, C, I, P, wHat, beta);
    E
    if abs(E - pE) > 1e-3
        pE = E;
        if flag, break; end;
    else
        flag = true;
        
        % update T
        T = dcm_trans_prob(Gr.G, Gr.ind, wHat, xHat, []);
        tHat = [0,          Gr.init; 
                zeros(M,1), T;
                ];
        estT = hmmtrain(hseq, tHat, eHat, 'Verbose',true, 'Tolerance', 1e-3);
        T = estT(2:end, 2:end);        
        [K, C, I, P] = mAccessVal(T, attrPrior, Gr);
    end;
end;

