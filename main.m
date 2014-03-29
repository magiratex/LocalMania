clear;
clc;
close all;

addpath('.\utils');

% rng(197);

[seq, hseq, Gr] = generate_data;

w = 1.0;
T = dcm_trans_prob(Gr.G, Gr.ind, w, Gr.attr);
M = size(T, 1);

% % draw
% figure; hold on;
% coordinates = rand(M, 2)*5;
% for i = 1 : M
%     text(coordinates(i, 1), coordinates(i, 2), num2str(i));
% end;
% gplot(Gr.G, coordinates);
MMin = 1e-5;

for i = 1 : 1
    tHat = [0,          Gr.init; 
            zeros(M,1), T;
            ];
    
    eHat = [zeros(1, M); 
            diag(ones(1, M))];
    tHat (tHat < MMin) = MMin;
    eHat (eHat < MMin) = MMin; 
%     tHat = T;
%     eHat = diag(ones(1, M));
    estT = hmmtrain(hseq, tHat, eHat, 'Verbose',true, 'Tolerance', 1e-3);
    
end;

