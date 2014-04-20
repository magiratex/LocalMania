clear;
clc;
close all;

fig = imread('scene.png');
% fig = imread('scene-label.png');


load data3.mat;
cmap = 'cmgrby';
sc = 0.03;
% for i = 1 : length(agtList)
%     plot(agtList(i).traj(:,1)/sc, agtList(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], 'LineSmooth', 'on');
% end;

for i = 1 : length(agtList)
    imshow(fig);
    hold on;
    plot(agtList(i).traj(:,1)/sc, agtList(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], 'LineSmooth', 'on');
    hold off;
    disp(i);
    pause;
end;

%%

clear;
clc;
close all;

fig = imread('scene.png');
% fig = imread('scene-label.png');

imshow(fig);
hold on;
load data3.mat;
cmap = 'cgmrby';
sc = 0.03;
for i = [33,52,61]
    plot(agtList(i).traj(1,1)/sc, agtList(i).traj(1,2)/sc, ['o',cmap(mod(i,6)+1)], ...
        'LineSmooth', 'on', 'LineWidth', 2.0);
    plot(agtList(i).traj(:,1)/sc, agtList(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], ...
        'LineSmooth', 'on', 'LineWidth', 2.0);
end;
