clear;
clc;
close all;

fig = imread('map4.png');
fig2 = imresize(fig, .95);
fig = fig2;


% load data4.mat;
load data_norep_Campus.mat;
cmap = 'cmgrby';
sc = 0.1;

imshow(fig);
hold on;
for i = 1 : length(agtList)
    if ~isempty(agtList(i).traj)
        plot(agtList(i).traj(:,1)/sc, agtList(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], 'LineSmooth', 'on');
    end;
end;

%%
for i = 1 : length(agtList)
    imshow(fig);
    hold on;
    if ~isempty(agtList(i).traj)
        plot(agtList(i).traj(:,1)/sc, agtList(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], 'LineSmooth', 'on');
        plot(agtList(i).traj(1,1)/sc, agtList(i).traj(1,2)/sc, ['o',cmap(mod(i,6)+1)], 'LineSmooth', 'on');
    end;
    hold off;
    disp(i);
    pause;
    %v(i) = input('input scores: ');
end;
save score_dcm_Campus1 v;

%%
clc;
clear;
K = 200;
load score_rnd.mat;
V = v(1:K);
load score_dcm.mat;
V = [V; v(1:K)]';
% histc(V, [-0.5,.5,1.5,2.5,3.5,4.5,5.5])
% bar(x,f/sum(f));
hist(V, [0,1,2,3,4,5]);

%%
clear;
clc;
% load data-rnd4.mat;
load data-rnd3.mat;
L = zeros(length(agtList), 2);
for i = 1 : length(agtList)
    L(i,1) = size(agtList(i).traj, 1);
end;
% load data5-dcm.mat;
load data4.mat;
for i = 1 : length(agtList)
    L(i,2) = size(agtList(i).traj, 1);
end;

hist(L, 7);

%%

clear;
clc;
% load stat-rnd4.mat;
% load stat5-dcm.mat;
load stat5-dcm-nodyn.mat;
L = zeros(3000,2);
for i = 1 : 3000
%     if any(statGoals(i,:) > 10)
%         L = [L; i];
%     end;
    L(i,1) = mean(statGoals(i,:));
end;

load stat5-dcm.mat;
for i = 1 : 3000
    L(i,2) = mean(statGoals(i,:));
end;

%%

clear;
clc;
close all;

fig = imread('scene.png');
% fig = imread('scene-label.png');

imshow(fig);
hold on;
% load data4.mat;
load data-rnd3.mat;
cmap = 'cgmrby';
sc = 0.03;
% for i = [33,52,61]
% for i = [33, 34]
for i = [7, 26,  33]
    plot(agtList(i).traj(1,1)/sc, agtList(i).traj(1,2)/sc, ['o',cmap(mod(i,6)+1)], ...
        'LineSmooth', 'on', 'LineWidth', 2.0);
    plot(agtList(i).traj(:,1)/sc, agtList(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], ...
        'LineSmooth', 'on', 'LineWidth', 2.0);
end;
