function [obs, hypseq] = gen_seq(T, ind, Init, minL, maxL, K)

M = size(T, 1);
Trans = T;
% Emis = diag(ones(1, M));

%% add the state of initialization and termination


% % add init and term
% Term = zeros(M, 1);
% Term(3) = [0.8];
% 
% tHat = [0, Init, 0; 
%         zeros(M,1), Trans, Term;
%         zeros(1, M+2)];
% eHat = [zeros(1, M+1); 
%         diag(ones(1, M+1))]; 

% only add init
tHat = [0,          Init; 
        zeros(M,1), Trans;
        ];
    
eHat = [zeros(1, M); 
        diag(ones(1, M))];


% normalization
for i = 1 : size(tHat, 1)
    accum = sum(tHat(i, :));
    if accum && accum ~= 1
        tHat(i, :) = tHat(i, :) ./ accum;
    end;
end;
    
%%
L = randi(maxL-minL, 1, K) + minL;
for k = 1 : K
    seq = hmmgenerate(L(k), tHat, eHat);
    hypseq{k} = seq;
    obs{k} = translate_seq(seq, ind);
    
end;

% seq = hmmgenerate(100, tHat, eHat);

% obs = translate_seq(seq, ind);
% 