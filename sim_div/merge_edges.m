load edges_tradeshow_new_divA.mat;
ed{1} = edges;
load edges_tradeshow_new_divB.mat;
ed{2} = edges;
load edges_tradeshow_new_divC.mat;
ed{3} = edges;
load edges_tradeshow_new_divD.mat;
ed{4} = edges;



edges = [];

for i = 1 : 4
    edges = [edges; ed{i}];
end;

samelist = [];
for i = 1 : size(edges, 1)
    for j = i+1 : size(edges, 1)
        diff1 = edges(i,1:2) - edges(j,1:2);
        diff2 = edges(i,[2,1]) - edges(j,1:2);
        if ~norm(diff1) || ~norm(diff2)
            samelist = [samelist; i,j];
        end;
    end;
end;

edges(samelist(:,2), :) = [];

save edges_tradeshow_new edges;