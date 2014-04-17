function [stat, origStat] = est_attr_data

% load results\data_30.1.mat;
load results\data_0.mat;

seq = backup.seq;

stat = zeros(size(backup.Gr.G));
for i = 1 : length(seq)
    stat = count_app(seq{i}, stat);
end;

origStat = stat;
for i = 1 : size(stat, 1)
    if sum(stat(i, :))
        stat(i, :) = stat(i, :) ./ sum(stat(i, :));
    end;
end;

function stat = count_app(seq, stat)

for i = 1 : length(seq)-1
    stat(seq(i), seq(i+1)) = stat(seq(i), seq(i+1)) + 1;
end

