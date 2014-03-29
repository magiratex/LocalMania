function id = find_ind(x, ind)

id = arrayfun(@(i) ind(i,1)==x(1) & ind(i,2)==x(2), 1:size(ind,1));