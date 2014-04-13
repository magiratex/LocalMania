clear;
clc;
close all;

addpath('.\utils');
warning('OFF', 'optim:fminunc:SwitchingMethod');

rng(1431);

%% initialize graph information
%   - graph structure
%   - attractions of nodes
%   - attractions affected by other nodes based on distances
%   - correlation between links

Gr = init_graph;



%% generate sequences
[seq, hseq, Gr] = generate_data(Gr);


M = size(Gr.G, 1);

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
attrPrior = (Gr.attr + rand(M)*0.1) .* Gr.G;
% attrPrior = Gr.attr;
% attrPrior = (Gr.attr + 0.1) .* Gr.G;

%% test
debug = 0;
if debug
    w = 0.92;
    T = dcm_trans_prob(Gr.G, Gr.ind, w, Gr.attr, []);
    [K, C, I, P] = mAccessVal(T, attrPrior, Gr);
    [wHat, ~] = mOptimWeight(P, K, C, I, 0.1);
    wHat
    [xHat, ~] = mOptimState(K, C/w, I, (P + 0.1).*Gr.G, beta);
else % prior
    w = 0.7;
    T = dcm_trans_prob(Gr.G, Gr.ind, w, attrPrior, []);
end;

%%
tHat = [0,          Gr.init; 
        zeros(M,1), T;
        ];
estT = hmmtrain(hseq, tHat, eHat, 'Verbose',true, 'Tolerance', 1e-3);
T = estT(2:end, 2:end);

[K, C, I, P] = mAccessVal(T, attrPrior, Gr);
xHat = P;

pE = -1;
flag = false;
for i = 1 : 1000
    fprintf('------------ %d ------------\n', i);
    
    [wHat, ~] = mOptimWeight(xHat, K, C, I, w);
    
    [xHat, ~] = mOptimState(K, C/w, I, P, beta); 

    
    w = wHat
    
    T = dcm_trans_prob(Gr.G, Gr.ind, w, xHat, []);
    [K, C, I, ~] = mAccessVal(T, P, Gr);
    
    E = mEvalEnergy(xHat, K, C, I, P, wHat, beta)
    
    
    if abs(E - pE) > 1e-3
        pE = E;
        flag = false;
    else
        if flag, break; end;
        
        % update T
        T = dcm_trans_prob(Gr.G, Gr.ind, wHat, xHat, []);
        tHat = [0,          Gr.init; 
                zeros(M,1), T;
                ];
        estT = hmmtrain(hseq, tHat, eHat, 'Verbose',true, 'Tolerance', 1e-3);
        T = estT(2:end, 2:end);        
        [K, C, I, P] = mAccessVal(T, P, Gr);
        flag = true;
    end;
end;

