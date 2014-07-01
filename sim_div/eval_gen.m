%% evaluating the estimation results by generating sequences

length = 10;
nsample = 100;
M = size(T, 1);
Trans = T;
Init = Gr.init;

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
for k = 1 : K

    seq = hmmgenerate(length, tHat, eHat);
    for t = 1 : length(seq)
        if any(Gr.edgeID == seq(t))
            break; % if there is no ending point, hmm will initialize a new start
        end;
    end;
    if t == 1, continue;
    elseif t < length(seq)
        seq = seq(1:t-1);
    end;
    hypseq{seqCount} = seq;
    
    obs{seqCount} = translate_seq(seq, ind);
    seqCount = seqCount + 1;
end;