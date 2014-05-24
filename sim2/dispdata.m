clc;
clear;
close all;

load data_rvo_dcm_Campus.mat;

fig = imread('map4.png');
fig2 = imresize(fig, .95);
fig = fig2;

for t = 1 : 6000
    imshow(fig);
    hold on;
    N = t / 10;
    
    for i = 1 : N+1
        
        % check if the agent i is out
        
    end;
    
    hold off;
    pause;
end;