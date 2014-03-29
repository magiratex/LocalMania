clear;
clc;
close all;

addpath('.\utils');

% rng(197);

[seq, hseq, Gr] = generate_data;

w = 0.89;
T = dcm_trans_prob(Gr.G, Gr.ind, w, Gr.attr);
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
for i = 1 : 3
    tHat = [0,          Gr.init; 
            zeros(M,1), T;
            ];
    
    
    tHat (tHat < MMin) = MMin;
%     for j = 1 : size(tHat, 1)
%         if sum(tHat(j, :)) > MMin
%             tHat(j, tHat(j,:)<MMin) = MMin;
%         end;
%     end;
%     tHat(:, 1) = 0;
%     eHat (eHat < MMin) = MMin; 
%     tHat = T;
%     eHat = diag(ones(1, M));
    estT = hmmtrain(hseq, tHat, eHat, 'Verbose',false, 'Tolerance', 1e-3);
    T = estT(2:end, 2:end);
    w = guess_dcm_wts2(T, Gr)
    T = dcm_trans_prob(Gr.G, Gr.ind, w(1), Gr.attr);
end;

