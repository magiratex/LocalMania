function Gr = init_graph(sizeG, edgeN, w)

VERBOSE = 0;
% sizeG = 10;
% edgeN = 80;

% construct the hyper-graph (each node represents two states)
[G, ind] = construct_hypergraph(sizeG);

% randomize a directed graph
% edgeID = randi(sizeG*sizeG, 1, edgeN);
edgeID = randperm(sizeG*sizeG, edgeN);
[G, noedge] = refine_hypergraph(G, edgeID, ind);
edgeID(noedge) = [];
edgeN = length(edgeID);

if VERBOSE, 
%     validG(G, ind); 
% draw
    figure; hold on;
    coordinates = rand(sizeG, 2)*5;
    for i = 1 : sizeG
        text(coordinates(i, 1), coordinates(i, 2), num2str(i));
    end;
    gplot(G, coordinates);
end;



% initial probabilities
init = zeros(1, sizeG * sizeG); % initial matrix
init(edgeID) = rand(1, length(edgeID));
init(edgeID) = init(edgeID) ./ sum(init(edgeID));

% initialize attraction
attr = rand(sizeG * sizeG);
attr = attr .* G;

% initialize correlation
corrMat = init_corr(G, ind);

% save 
Gr.G = G;
Gr.ind = ind;
Gr.attr = attr;
Gr.corr = corrMat;
% Gr.w = [0.3, 0.7];
Gr.w = w;
Gr.size = sizeG;
Gr.edges = edgeN;
Gr.edgeID = edgeID;
Gr.init = init;

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