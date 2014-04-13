function [seq, hseq, Gr] = generate_data(Gr, NSample)

% VERBOSE = 0;
% N = 5;
% 
% % construct the graph
% [G, ind] = construct_hypergraph(N);
% 
% if VERBOSE, validG(G, ind); end;
% 
% % random generate the transition probabilities
% % T = rand_trans_prob(G);
% 
% % generate the transition probabilities using dcm
% attr = rand(1, N);

G = Gr.G;
ind = Gr.ind;
w = Gr.w;
attr = Gr.attr;
corr = Gr.corr;
N = Gr.size;
Init = Gr.init;

%%
% T = dcm_trans_prob(G, ind, w, attr, corr);
T = dcm_trans_prob(G, ind, w, attr, []);

% generate sequences
% Init = zeros(1, N*N); % initial matrix
% Init(1:3) = [0.1 0.7 0.2];
[seq, hseq] = gen_seq(T, ind, Init, N, N+10, NSample);

% save
Gr.trans = T;
Gr.init = Init;

end

% function validG(G, ind)
% 
% E = size(G, 1);
% 
% for i = 1 : E
%     for j = 1 : E
%         if G(i, j)
%             fprintf('%d,%d->%d,%d\n', ind(i, :), ind(j, :));
%         end;
%     end;
% end;
