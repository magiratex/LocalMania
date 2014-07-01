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

for I = 467 : length(agt)
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
    v(i) = input([num2str(I), ':', num2str(i), ':', 'input scores: ']);
end;

save scores_rvo_Campus v;

% load data_sf_dcm_Campus.mat;
% agt = [agt, agtList];

%%

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

load scores_rvo_Campus1+2+3.mat;
% id5 = find(v == 5);
id1 = find(v == 1);
% for I = 1 : numel(id5)
%     i = id5(I)
for I = 1 : numel(id1)
    i = id1(I)
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
    
% i = 22;
i = 5;
if ~isempty(agt(i).traj)
    %plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], 'LineSmooth', 'on', ...
        %'LineWidth', 2.0);
    plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, '-b', 'LineSmooth', 'on', 'LineWidth', 2.0);
    plot(agt(i).traj(1,1)/sc, agt(i).traj(1,2)/sc, 'ob', 'LineSmooth', 'on', 'LineWidth', 2.0);
end;
    
% i = 711
i = 473;
if ~isempty(agt(i).traj)
    %plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], 'LineSmooth', 'on', ...
        %'LineWidth', 2.0);
    plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, '-r', 'LineSmooth', 'on', 'LineWidth', 2.0);
    plot(agt(i).traj(1,1)/sc, agt(i).traj(1,2)/sc, 'or', 'LineSmooth', 'on', 'LineWidth', 2.0);
end;    


% i = 685
i = 639;
if ~isempty(agt(i).traj)
    %plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], 'LineSmooth', 'on', ...
        %'LineWidth', 2.0);
    plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, '-g', 'LineSmooth', 'on', 'LineWidth', 2.0);
    plot(agt(i).traj(1,1)/sc, agt(i).traj(1,2)/sc, 'og', 'LineSmooth', 'on', 'LineWidth', 2.0);
end; 

% % i = 71
% i = 5;
% if ~isempty(agt(i).traj)
%     %plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], 'LineSmooth', 'on', ...
%         %'LineWidth', 2.0);
%     plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, '-m', 'LineSmooth', 'on', 'LineWidth', 2.0);
%     plot(agt(i).traj(1,1)/sc, agt(i).traj(1,2)/sc, 'om', 'LineSmooth', 'on', 'LineWidth', 2.0);
% end; 

% % i = 303
% i = 228;
% if ~isempty(agt(i).traj)
%     %plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], 'LineSmooth', 'on', ...
%         %'LineWidth', 2.0);
%     plot(agt(i).traj(:,1)/sc, agt(i).traj(:,2)/sc, '-c', 'LineSmooth', 'on', 'LineWidth', 2.0);
%     plot(agt(i).traj(1,1)/sc, agt(i).traj(1,2)/sc, 'oc', 'LineSmooth', 'on', 'LineWidth', 2.0);
% end; 


%%

% clc;
% clear;
close all;


% load scores_sf_tradeshow.mat;
load scores_sf_Campus.mat;

N = size(v, 2)/3;
vh1 = reshape(v, N, 3);
% hist(vh, [1:5]);

% load scores_rvo_tradeshow1+2.mat;
load scores_rvo_Campus1+2+3.mat;
% figure;
N = size(v, 2)/3;
vh2 = reshape(v, N, 3);
% hist(vh, [1:5]);
vh = [vh1; vh2];
hist(vh, [1:5]);
