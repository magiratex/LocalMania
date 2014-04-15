function main2(nsample, sizeG, edgeN, gtW, initW, fid)

% clear;
% clc;
close all;

addpath('.\utils');
warning('OFF', 'optim:fminunc:SwitchingMethod');

rseed = 1431;
rng(rseed);

%% ground-truth values
% nsample     = 5000;
% sizeG       = 15;
% edgeN       = 150;
% gtW         = 2.5;
% initW       = 1.0;
% fid         = 1.0;    

%% initialize graph information
%   - graph structure
%   - attractions of nodes
%   - attractions affected by other nodes based on distances
%   - correlation between links

Gr = init_graph(sizeG, edgeN, gtW);



%% generate sequences
[seq, hseq, Gr] = generate_data(Gr, nsample, false);


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
% attrPrior = (Gr.attr + rand(M)*0.1) .* Gr.G;
attrPrior = Gr.attr;
% attrPrior = (Gr.attr + 0.1) .* Gr.G;

backup.rngSeed = rseed;
backup.xPrior = attrPrior;
backup.Gr = Gr;
%% test
debug = 0;
if debug
    w = 2.12;
    T = dcm_trans_prob(Gr.G, Gr.ind, w, Gr.attr, []);
    T = (T + rand(size(T))*0.5) .* Gr.G;
    for i = 1 : size(T, 1)
        if sum(T(i, :))
            T(i, :) = T(i, :) ./ sum(T(i, :));
        end;
    end;
    [K, C, I, P] = mAccessVal(T, attrPrior, Gr);
    [wHat, ~] = mOptimWeight(P, K, C, I, 0.1);
    wHat
    [xHat, ~] = mOptimState(K, C/w, I, (P + 0.1).*Gr.G, beta);
else % prior
    w = initW;
    T = dcm_trans_prob(Gr.G, Gr.ind, w, attrPrior, []);
    backup.initw = w;
end;

%%
tic
tHat = [0,          Gr.init; 
        zeros(M,1), T;
        ];
estT = hmmtrain(hseq, tHat, eHat, 'Verbose',true, 'Tolerance', 1e-3);
T = estT(2:end, 2:end);
backup.hmmT = T;
backup.seq = hseq;
toc

[K, C, I, P] = mAccessVal(T, attrPrior, Gr);
xHat = P;

pE = -1;
flag = false;
for i = 1 : 30
    fprintf('------------ %d ------------\n', i);
    tic
    [wHat, ~] = mOptimWeight(xHat, K, C, I, w);
    toc
    
    tic
    [xHat, ~] = mOptimState(K, C/w, I, P, beta); 
    toc
    
    w = wHat
    
    T = dcm_trans_prob(Gr.G, Gr.ind, w, xHat, []);
    [K, C, I, ~] = mAccessVal(T, P, Gr);
    
    E = mEvalEnergy(xHat, K, C, I, P, wHat, beta)
    
    iter(i).w = wHat;
    iter(i).E = E;
    iter(i).x = xHat;
    iter(i).T = T;
    
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

backup.iter = iter;
save(['results\data_',num2str(fid),'.mat'], 'backup'); 

