%% evaluating the estimation results by generating sequences
function obs = eval_gen(T, Gr, exits)

L = 10;
nsample = 1000;
M = size(T, 1);
Trans = T;
Init = Gr.init;
ind = Gr.ind;

% only add init
tHat = [0,          Init; 
        zeros(M,1), Trans;
        ];
% tHat = Trans;
    
eHat = [zeros(1, M); 
        diag(ones(1, M))];
% eHat = diag(ones(1, M));

% normalization
for i = 1 : size(tHat, 1)
    accum = sum(tHat(i, :));
    if accum && accum ~= 1
        tHat(i, :) = tHat(i, :) ./ accum;
    end;
end;
    
%%
seqCount = 1;
for k = 1 : nsample

    seq = hmmgenerate(L, tHat, eHat);
    for t = 1 : length(seq)
        if ~any(Gr.edgeID == seq(t))
            break; % if there is no ending point, hmm will initialize a new start
        end;
    end;
    if t == 1, continue;
    elseif t < length(seq)
        seq = seq(1:t-1);
    end;
    hypseq{seqCount} = seq;
    
    ss = translate_seq(seq, ind);
    for j = 2 : length(ss)
        if any(exits == ss(j))
            break;
        end;
    end;
    ss = ss(1:j);
    obs{seqCount} = ss;
    seqCount = seqCount + 1;
end;

if ~exist('obs', 'var'), obs = []; end;