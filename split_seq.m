function states = split_seq(seq, ind)


for i = 1 : length(seq)-1
%     id = intersect(find(ind(:,1)==seq(i)), find(ind(:,2)==seq(i+1)));
%     states(i) = id;
    id = find_ind(seq([i,i+1]), ind);
    states(i) = find(id ~= 0);
end

% with initial & ending probabilities
states = [find(find_ind([0, seq(1)], ind)~=0), states];
states = [states, find(find_ind([seq(end),0], ind)~=0)];