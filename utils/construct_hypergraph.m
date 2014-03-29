function [G, indices] = construct_hypergraph(sizeG)

[I, J] = ind2sub([sizeG, sizeG], 1:sizeG*sizeG);
indices = [J; I]';

G = zeros(sizeG * sizeG);
G = mask_possible_links(G, indices);

function G = mask_possible_links(G, ind)

E = size(G, 1);
for i = 1 : E
    for j = 1 : E
        st1 = ind(i, :);
        st2 = ind(j, :);
        
        if st1(2) == st2(1) && st1(1) ~= st1(2) && st2(1) ~= st2(2)
            G(i, j) = 1;
        end;
    end;
end;