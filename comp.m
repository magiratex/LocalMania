close all;
clc;
clear;

addpath('.\utils\');

% load results\data_30.6.mat; % data with noise at transition probability
% load results\data_10.6.mat;
% load results\data_11.3.mat; % large w matters
% load results\data_25.4.mat;

gtTrans = backup.Gr.trans;

init = backup.Gr.init;
attrPrior = backup.xPrior;

len = 10;
nsample = 5000;

% random choice
pscr1 = zeros(1, nsample);
for i = 1 : nsample
    rcSeq = rand_gen_seq(len, init, attrPrior);
    pscr1(i) = eval_seq_likely(rcSeq, gtTrans);
end;

% dcm
estTrans = backup.iter(end-1).T;
pscr2 = zeros(1, nsample);
for i = 1 : nsample
    dcmSeq = rand_gen_seq(len, init, estTrans);
    pscr2(i) = eval_seq_likely(dcmSeq, gtTrans);
end;


% evaluation
pscr1 = log(pscr1);
pscr2 = log(pscr2);

mean(pscr1), mean(pscr2)