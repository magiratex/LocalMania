function est_att(seq, Gr)

N = Gr.size;
counter = zeros(1, N);
for i = 1 : numel(seq)
    for j = 1 : length(seq{i})
        counter(seq{i}(j)) = counter(seq{i}(j)) + 1;
    end;
end;

end