% Generate the transition proability based on attributes
% Input:
% - attr: attraction values of each node

function T = gen_trans_attr(G, attr, w)

T = ones(size(G));

N = size(G, 1);

% w = 0.01;
% w = 0.361;
% w = 1;

for i = 1 : N
    % edges from i to j
    utils = [];
    for j = 1 : N
        if G(i, j)
            utils(j) = exp(w * attr(j));
        else
            utils(j) = 0;
        end;
    end;
    if sum(utils)
        T(i, :) = utils ./ sum(utils);
    else
        T(i, :) = 0;
    end;
end;