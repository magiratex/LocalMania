function [prob] = eval_seq_likely(seq, T)

prob = 1;
for i = 1 : length(seq)-1
    prob = prob * T(seq(i), seq(i+1));
end;