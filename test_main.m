clc;

%% Section A

%%
clear;
load ./sim_div/seq_tradeshow_new_divA_moveup.mat;
mainst
save('moveupa.mat');
obs = eval_gen(T, Gr, [5,6,7,9,10,11]);
for i = 1:numel(obs), L(i) = (obs{i}(end)==5 | obs{i}(end)==9); end; sum(L)
% for i = 1 : numel(obs), L(i) = numel(obs{i}); end;
% n = hist(L,1:10)

%%

clear;
% load ./sim_div/shortseq_tradeshow_new_divA3.mat;
load ./sim_div/shortseq_tradeshow_new_divA5.mat;
mainst
save('shorta5.mat');
obs = eval_gen(T, Gr, [5,6,7,9,10,11]);
for i = 1 : numel(obs), L(i) = numel(obs{i}); end;
n = hist(L,1:10)


%%
clear;
load ./sim_div/longseq_tradeshow_new_divA2.mat;
mainst
save('longa.mat');
obs = eval_gen(T, Gr, [5,6,7,9,10,11]);
for i = 1 : numel(obs), L(i) = numel(obs{i}); end;
n = hist(L,1:10)


%%
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


%% section C
clear;
load seq_tradeshow_new_divC_avoid12.mat;
mainst
save('avoid12c.mat');
obs = eval_gen(T, Gr, [1,8,9,10]);
for i = 1 : numel(obs), L(i) = ~any(obs{i}(:) == 7); end; sum(L)


%%
clear;
load ./sim_div/seq_tradeshow_new_divC_moveleft.mat;
mainst
save('moveleftc.mat');
obs = eval_gen(T, Gr, [1,8,9,10]);
for i = 1:numel(obs), L(i) = (obs{i}(end)==1); end; sum(L)

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


%% Section D
%%
clear;
load ./sim_div/seq_tradeshow_new_divD_moveup.mat;
mainst
save('moveupd.mat');
obs = eval_gen(T, Gr, [1,2,3,7,10,11,12]);
obs = eval_gen(T, Gr, [1,2,3,7,10,11]);
for i = 1 : numel(obs), L(i) = numel(obs{i}); end;
n = hist(L,1:10)


%%

% clear;
% load seq_tradeshow_new_divD_nostart2324.mat;
% mainst
% save('nostart2324.mat');
% obs = eval_gen(T, Gr, [1,2,3,7,10,11]);
% for i = 1 : numel(obs), L(i) = (obs{i}(1)==10 || obs{i}(1)==11); end;
% sum(L)

%%

clear;
load ./sim_div/shortseq_tradeshow_new_divD.mat;
mainst
save('shortd.mat');
obs = eval_gen(T, Gr, [1,2,3,7,10,11,12]);
obs = eval_gen(T, Gr, [1,2,3,7,10,11]);
for i = 1 : numel(obs), L(i) = numel(obs{i}); end;
n = hist(L,1:10)

%%
clear;
load ./sim_div/longseq_tradeshow_new_divD.mat;
mainst
save('longd.mat');
obs = eval_gen(T, Gr, [1,2,3,7,10,11,12]);
obs = eval_gen(T, Gr, [1,2,3,7,10,11]);
for i = 1 : numel(obs), L(i) = numel(obs{i}); end;
n = hist(L,1:10)



