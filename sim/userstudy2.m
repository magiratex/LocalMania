clear;
clc;
close all;

% rng(141);

agt = [];
N = 300;
load data_sf_rnd_tradeshow.mat;
agt = [agt, agtList(1:N)];
load data_sf_norep_tradeshow.mat;
agt = [agt, agtList(1:N)];
load data_sf_dcm_tradeshow.mat;
agt = [agt, agtList(1:N)];

if ~exist('sf_indices.mat', 'file')
    indices = randperm(3 * N);
    save sf_indices.mat indices;
else
    load sf_indices.mat;
end;



fig = imread('map4.png');
fig2 = imresize(fig, .88);
fig = fig2;
% cmap = 'cmgrby';
sc = 0.03;


v = zeros(1, 3*N);

for I = 1 : length(agt)
% for I = 206
    imshow(fig);
    hold on;
    i = indices(I);
    if ~isempty(agt(i).traj)
        %plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], 'LineSmooth', 'on');
        plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, '-r', 'LineSmooth', 'on');
        plot(agt(i).traj(1,1)/sc, agt(i).traj(1,2)/sc, 'or', 'LineSmooth', 'on');
    end;
    hold off;
    %disp(i);
    %pause;
    while 1
        r = input([num2str(I), ':', num2str(i), ':', 'input scores: ']);
        if ~isempty(r)
            v(i) = r;
            break;
        end;
    end;
end;

save scores_sf_tradeshow v;