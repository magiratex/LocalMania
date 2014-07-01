clc;
clear;
close all;

% load data_rvo_dcm_Campus.mat;

fig = imread('map4.png');
fig2 = imresize(fig, .95);
fig = fig2;

sc = 0.1;
load frameInfo_rvo_dcm_CampusK3.mat;
wid = 1.5;

for t = 2700 : 10 : length(frameInfo)
    t
    imshow(fig);
    hold on;
    
    conf = frameInfo(t).moving / sc;
    
    plot(conf(:,3), conf(:,4), 'ob', 'LineSmooth', 'on', ...
        'LineWidth', wid);
    vel = sc * bsxfun(@times, conf(:,5:6), 1./sqrt(sum(conf(:,5:6).^2,2)));
    
    quiver(conf(:,3), conf(:,4), vel(:,1), vel(:,2), 0.15, 'Color', 'b', ...
        'LineWidth', wid);
    
    stay = frameInfo(t).staying / sc;
    plot(stay(:,1), stay(:,2), 'or', 'LineSmooth', 'on', ...
        'LineWidth', wid);
    
    
    
    hold off;
    %pause(0.04);
    pause;
end;