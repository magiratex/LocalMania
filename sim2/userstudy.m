clear;
clc;
close all;

% rng(141);

agt = [];
N = 300;
load data_rvo_rnd_Campus.mat;
agt = [agt, agtList(1:N)];
load data_rvo_norep_Campus.mat;
agt = [agt, agtList(1:N)];
load data_rvo_dcm_Campus.mat;
agt = [agt, agtList(1:N)];

if ~exist('rvo_indices.mat', 'file')
    indices = randperm(3 * N);
    save rvo_indices.mat indices;
else
    load rvo_indices.mat;
end;



fig = imread('map4.png');
fig2 = imresize(fig, .95);
fig = fig2;
% cmap = 'cmgrby';
sc = 0.1;

for I = 1 : length(agt)
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
    v(i) = input([num2str(I), ':', num2str(i), ':', 'input scores: ']);
end;

save scores_rvo_Campus v;

% load data_sf_dcm_Campus.mat;
% agt = [agt, agtList];
