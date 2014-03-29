function Gr = init_graph

VERBOSE = 0;
sizeG = 5;
edgeN = 5;

% construct the hyper-graph (each node represents two states)
[G, ind] = construct_hypergraph(sizeG);

% randomize a directed graph
edgeID = randi(sizeG*sizeG, 1, edgeN);
G = refine_hypergraph(G, edgeID);

if VERBOSE, 
    validG(G, ind); 
end;

% initialize attraction
attr = rand(1, sizeG);

% initialize correlation
corrMat = init_corr(G, ind);

% save 
Gr.G = G;
Gr.ind = ind;
Gr.attr = attr;
Gr.corr = corrMat;
Gr.w = [0.3, 0.7];
Gr.size = sizeG;
Gr.edges = edgeN;

end

function corrMat = init_corr(G, ind)

M = size(G, 1);
corrMat = zeros(size(G));

for i = 1 : M
    for j = 1 : M
        if G(i, j)
            corrMat(i, j) = rand(1);
        end;
    end;
end;


end


function validG(G, ind)

E = size(G, 1);

for i = 1 : E
    for j = 1 : E
        if G(i, j)
            fprintf('%d,%d->%d,%d\n', ind(i, :), ind(j, :));
        end;
    end;
end;

end