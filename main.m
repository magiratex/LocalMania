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
eHat = [zeros(1, M); 
        diag(ones(1, M))];    
% eHat = [diag(ones(1, M))];
% attrPrior = max((Gr.attr + rand(M)*0.1), 0) .* Gr.G;
attrPrior = (Gr.attr + rand(M)*0.1) .* Gr.G;
% attrPrior = Gr.attr;

%% Iteratively procedure
% for i = 1 : 50
%     tic
%     tHat = [0,          Gr.init; 
%             zeros(M,1), T;
%             ];
%     estT = hmmtrain(hseq, tHat, eHat, 'Verbose',true, 'Tolerance', 1e-3);
%     T = estT(2:end, 2:end);
%     w = guess_dcm_wts2(T, Gr)
%     w = w(end);
%     [estAttr, fval] = guess_attr(T, w, attrPrior, Gr);
%     fval
%     T = dcm_trans_prob(Gr.G, Gr.ind, w, estAttr, []);
%     
% %     [estAttr, fval] = guess_attr(T, w, attrPrior, Gr);
% %     fval
% %     T = dcm_trans_prob(Gr.G, Gr.ind, w, estAttr, []);
% %     w = guess_dcm_wts2(T, Gr)
% %     w = w(end);
%     toc
% end;

%%
tHat = [0,          Gr.init; 
        zeros(M,1), T;
        ];
estT = hmmtrain(hseq, tHat, eHat, 'Verbose',true, 'Tolerance', 1e-3);
T = estT(2:end, 2:end);
prevw = -1;
prevfval = 1000;
for i = 1 : 1000
    [estAttr, fval] = guess_attr(T, w, attrPrior, Gr);
    fval
    T = dcm_trans_prob(Gr.G, Gr.ind, w, estAttr, []);
    w = guess_dcm_wts2(T, Gr)
    w = w(end);
    
%     if prevfval < fval
%         break;
%     end;
    
    if abs(w - prevw) > MMin
        prevw = w;
%         prevfval = fval;
    else
        disp('converges... recompute T');
        tHat = [0,          Gr.init; 
                zeros(M,1), T;
                ];
        estT = hmmtrain(hseq, tHat, eHat, 'Verbose',true, 'Tolerance', 1e-3);
        T = estT(2:end, 2:end);
%         prevfval = 1000;
    end;
    
end;

