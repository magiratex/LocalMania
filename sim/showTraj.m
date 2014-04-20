clear;
clc;
close all;

fig = imread('scene.png');
imshow(fig);
hold on;

load data2.mat;
cmap = 'cmgrby';
sc = 0.03;
for i = 1 : length(agtList)
    plot(agtList(i).traj(:,1)/sc, agtList(i).traj(:,2)/sc, ['-',cmap(mod(i,6)+1)], 'LineSmooth', 'on');
end;