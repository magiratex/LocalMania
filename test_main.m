clc;

clear;
load ./sim_div/shortseq_tradeshow_new_divB.mat;
mainst
save('shortb.mat');
obs = eval_gen(T, Gr, [1,2,7,8,9,10]);
for i = 1 : numel(obs), L(i) = numel(obs{i}); end;
n = hist(L,1:10)


%%
clear;
disp('running...')
load ./sim_div/longseq_tradeshow_new_divB2.mat;
mainst
save('longb2.mat');
obs = eval_gen(T, Gr, [1,2,7,8,9,10]);
for i = 1 : numel(obs), L(i) = numel(obs{i}); end;
n = hist(L,1:10)


%%
clear;
load ./sim_div/shortseq_tradeshow_new_divC.mat;
mainst
save('shortc.mat');
obs = eval_gen(T, Gr, [1,8,9,10]);
for i = 1 : numel(obs), L(i) = numel(obs{i}); end;
n = hist(L,1:10)

clear;
load ./sim_div/longseq_tradeshow_new_divC.mat;
mainst
save('longc.mat');
obs = eval_gen(T, Gr, [1,8,9,10]);
for i = 1 : numel(obs), L(i) = numel(obs{i}); end;
n = hist(L,1:10)

clear;
load ./sim_div/shortseq_tradeshow_new_divD.mat;
mainst
save('shortd.mat');
obs = eval_gen(T, Gr, [1,2,3,7,10,11]);
for i = 1 : numel(obs), L(i) = numel(obs{i}); end;
n = hist(L,1:10)

clear;
load ./sim_div/longseq_tradeshow_new_divD.mat;
mainst
save('longd.mat');
obs = eval_gen(T, Gr, [1,2,3,7,10,11]);
for i = 1 : numel(obs), L(i) = numel(obs{i}); end;
n = hist(L,1:10)