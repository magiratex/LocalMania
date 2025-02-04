function merge_trans

load graphInfo_tradeshow.mat;
tot = zeros(size(Gr.G));

clearvars -except tot;
% load ../longa.mat;
% load ../shorta5.mat;
load ../moveupa.mat;
tot = fill_match(tot, T, subGr.match);

clearvars -except tot;
% load ../longb.mat;
load ../shortb.mat;
tot = fill_match(tot, T, subGr.match);

clearvars -except tot;
% load ../longc.mat;
% load ../shortc.mat;
load ../moveleftc.mat;
% load ../avoid12c.mat;
tot = fill_match(tot, T, subGr.match);

clearvars -except tot;
% load ../longd.mat;
% load ../shortd.mat;
load ../moveupd.mat;
tot = fill_match(tot, T, subGr.match);

trans = tot;
save('trans_tradeshow_new_msmm.mat', 'trans');

%% fill the division matrix to the complete matrix
% FIXME: didn't deal with the overlapping issue
function T = fill_match(T, t, match)

for i = 1 : size(match,1)
%     j = match(i,2);
% %     T(j, match(:,2)) = t(i,match(:,1));
%     if j == 644
%     end;
    for k = 1: size(match,1)
        if t(match(i,1), match(k,1))
            T(match(i,2), match(k,2)) = t(match(i,1),match(k,1));
        end;
    end;
end;
