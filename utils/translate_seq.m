function obs = translate_seq(seq, ind)


% obs = [];
% for i = 1 : length(seq)
%     obs = [obs, ind(seq(i), :)];
% end;

obs(1) = ind(seq(1), 1);
for i = 1 : length(seq)
    obs = [obs, ind(seq(i), 2)];
end;
