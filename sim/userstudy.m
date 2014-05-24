clear;
clc;
close all;

% rng(141);

agt = [];
N = 200;
load data_rvo_rnd_tradeshow.mat;
agt = [agt, agtList(1:N)];
load data_rvo_norep_tradeshow.mat;
agt = [agt, agtList(1:N)];
load data_rvo_dcm_tradeshow.mat;
agt = [agt, agtList(1:N)];

if ~exist('rvo_indices.mat', 'file')
    indices = randperm(3 * N);
    save rvo_indices.mat indices;
else
    load rvo_indices.mat;
end;



% origfig = imread('scene.png');
fig = imread('map4.png');
fig2 = imresize(fig, .88);
fig = fig2;
% cmap = 'cmgrby';
sc = 0.03;

% for I = 289 : length(agt)
% for I = 206
    imshow(fig);
    hold on;
    %i = indices(I);
    i = 461;
    if ~isempty(agt(i).traj)
        %plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], 'LineSmooth', 'on');
        plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, '-r', 'LineSmooth', 'on');
        plot(agt(i).traj(1,1)/sc, agt(i).traj(1,2)/sc, 'or', 'LineSmooth', 'on');
    end;
    hold off;
    %disp(i);
    %pause;
    v(i) = input([num2str(I), ':', num2str(i), ':', 'input scores: ']);
% end;

save scores_rvo_tradeshow v;

%%
clc;
clear;
close all;

load scores_rvo_tradeshow1+2.mat;
id5 = find(v == 5);

agt = [];
N = 200;
load data_rvo_rnd_tradeshow.mat;
agt = [agt, agtList(1:N)];
load data_rvo_norep_tradeshow.mat;
agt = [agt, agtList(1:N)];
load data_rvo_dcm_tradeshow.mat;
agt = [agt, agtList(1:N)];

fig = imread('map4.png');
fig2 = imresize(fig, .88);
fig = fig2;
sc = 0.03;

for I = 1 : numel(id5)
    i = id5(I)
    imshow(fig);
    hold on;
    %i = indices(I);
    if ~isempty(agt(i).traj)
        plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, '-r', 'LineSmooth', 'on');
        plot(agt(i).traj(1,1)/sc, agt(i).traj(1,2)/sc, 'or', 'LineSmooth', 'on');
    end;
    hold off;
    pause;
end;

%%

close all;
cmap = 'cmgrby';
imshow(fig);
hold on;
    
% for i = [99, 309, 356, 360, 404, 407, 429]
% i = 407;
i = 429;
if ~isempty(agt(i).traj)
    %plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], 'LineSmooth', 'on', ...
        %'LineWidth', 2.0);
    plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, '-b', 'LineSmooth', 'on', 'LineWidth', 2.0);
    plot(agt(i).traj(1,1)/sc, agt(i).traj(1,2)/sc, 'ob', 'LineSmooth', 'on', 'LineWidth', 2.0);
end;
    
% % i = 469
% i = 410
% % i = 429
% if ~isempty(agt(i).traj)
%     %plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], 'LineSmooth', 'on', ...
%         %'LineWidth', 2.0);
%     plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, '-r', 'LineSmooth', 'on', 'LineWidth', 2.0);
%     plot(agt(i).traj(1,1)/sc, agt(i).traj(1,2)/sc, 'or', 'LineSmooth', 'on', 'LineWidth', 2.0);
% end;    

% i = 99
i = 439
if ~isempty(agt(i).traj)
    %plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], 'LineSmooth', 'on', ...
        %'LineWidth', 2.0);
    plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, '-g', 'LineSmooth', 'on', 'LineWidth', 2.0);
    plot(agt(i).traj(1,1)/sc, agt(i).traj(1,2)/sc, 'og', 'LineSmooth', 'on', 'LineWidth', 2.0);
end; 

% i = 430
i = 410
if ~isempty(agt(i).traj)
    %plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], 'LineSmooth', 'on', ...
        %'LineWidth', 2.0);
    plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, '-r', 'LineSmooth', 'on', 'LineWidth', 2.0);
    plot(agt(i).traj(1,1)/sc, agt(i).traj(1,2)/sc, 'or', 'LineSmooth', 'on', 'LineWidth', 2.0);
end; 

%%

clc;
clear;
close all;


load scores_sf_tradeshow.mat;

N = size(v, 2)/3
vh = reshape(v, N, 3);
vh1 = vh(1:200, :);
% hist(vh, [1:5]);

load scores_rvo_tradeshow1+2.mat;
N = size(v, 2)/3;
vh = reshape(v, N, 3);
% size(vh)
% hist(vh, [1:5]);
vh2 = vh;
vh = [vh1; vh2];
% size(vh)

figure;
hist(vh, [1:5]);
