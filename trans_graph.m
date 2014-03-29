function newG = trans_graph(G, zeroState, ind)

newG = zeros(size(ind, 1));


for i = 1 : size(newG, 1)
    for j = 1 : size(newG, 2)
        if ind(i, 2) ~= ind(j, 1)
            continue;
        end;
        
        if ind(i, 2) == 0, continue; end; % stop
        if ind(j, 1) == 0, continue; end; % impossible
        
        if ind(i, 1) == 0, % initialize
            if zeroState(1, ind(i, 2)) == 0
                continue;
            elseif ind(j, 2)
                newG(i, j) = G(ind(j, 1), ind(j, 2));
            else
                newG(i, j) = zeroState(end, ind(j, 1));
            end;
        end;
        
        if ind(j, 2) == 0 % FIXME: ending
            
        end;
        
        
        if G(ind(i, 1), ind(i, 2)) == 0 || ...
           G(ind(j, 1), ind(j, 2)) == 0 
            continue;
        end;
        newG(i, j) = G(ind(j, 1), ind(j, 2));
    end
end
