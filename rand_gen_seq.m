function seq = rand_gen_seq(len, init, prior)


for i = 1 : size(prior,1)
    prior(i, :) = prior(i, :) ./ sum(prior(i, :));
end;

ind = rand_select_pool(init);
seq = ind;



for i = 2 : len
    ind = rand_select_pool(prior(ind, :));
    if ind ~= -1
        seq(i) = ind;
    else
        break;
    end;
end;

function ind = rand_select_pool(probList)

nonzeroInd = find(probList ~= 0);
if isempty(nonzeroInd) % no out-going edges
    ind = -1;
end;

nzList = probList(nonzeroInd);
probPool = cumsum(nzList);

probPool = probPool - rand(1)*0.99;
ind = find(probPool > 0, 1);
if isempty(ind)
    ind = length(probPool);
end;
ind = nonzeroInd(ind);