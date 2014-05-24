clc;
clear;
close all;

% load data_rvo_dcm_Campus.mat;

fig = imread('map4.png');
fig2 = imresize(fig, .95);
fig = fig2;

sc = 0.1;
load frameInfo_rvo_dcm_CampusK.mat;

for t = 3000 : length(frameInfo)
    imshow(fig);
    hold on;
    
    conf = frameInfo(t).moving / sc;
    for i = 1 : size(conf, 1)
        plot(conf(:,3), conf(:,4), 'o');
    end;
    stay = frameInfo(t).staying / sc;
    for i = 1 : size(stay, 1)
        plot(stay(:,1), stay(:,2), 'or');
    end;
    
    
    hold off;
    pause(0.04);
end;