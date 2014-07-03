function tot = merge_trans

load graphInfo_tradeshow.mat;
tot = zeros(size(Gr.G));

clearvars -except tot;
load ../longb.mat;
tot = fill_match(tot, T, subGr.match);

clearvars -except tot;
load ../longc.mat;
tot = fill_match(tot, T, subGr.match);

clearvars -except tot;
load ../longd.mat;
tot = fill_match(tot, T, subGr.match);




%% fill the division matrix to the complete matrix
% FIXME: didn't deal with the overlapping issue
function T = fill_match(T, t, match)

for i = 1 : size(match,1)
    j = match(i,2);
    T(j, match(:,2)) = t(i,match(:,1));
end;
