%%
% close all;
% 
% % fig = imread('scene.png');
% fig = imread('map.png');
% 
% figure;
% imshow(fig);
% 
% wayptrs = [];
% 
% while 1
%     [x,y] = ginput(1)
%     hold on;
%     plot(x, y, 'xb');
%     wayptrs = [wayptrs; x y];
%     
%     str = input('finish? (y)', 's');
%     if str == 'y'
%         break;
%     end;
% end;
% 
% save pixWayptrs_Campus wayptrs;

%% create edges
clc;
close all;
clear;

fig = imread('map.png');

figure;
imshow(fig);
hold on;

load pixWayptrs_Campus.mat;
for i = 1 : size(wayptrs, 1)
    plot(wayptrs(i,1), wayptrs(i,2), 'ob');
    text(wayptrs(i,1)+0.8, wayptrs(i,2), num2str(i));
end;

edges = [];


while 1
    
    % input the end point of edges
    [x,y] = ginput(2);
    i = find_min_id(x(1),y(1),wayptrs);
    if length(x) == 2
        j = find_min_id(x(2),y(2),wayptrs);
    elseif length(x) == 1
        fprintf('Only one point is inputed; please input another point.\n');
        [x,y] = ginput(1);
        j = find_min_id(x,y,wayptrs);
    end;

    
    % input the gate point of edges
    fprintf('Input the gate point!\n');
    [x,y] = ginput(1);
    edges = [edges; i, j, x, y];
    plot(x, y, 's');
    plot([x, wayptrs(i,1)], ...
         [y, wayptrs(i,2)], '-b');
    plot([x, wayptrs(j,1)], ...
         [y, wayptrs(j,2)], '-b');
        
    str = input('finish? (y)', 's');
    if str == 'y'
        break;
    end;
    
    
end;

save edges_Campus2 edges;

%% show edges
clc;
close all;
clear;

fig = imread('map2.png');

figure;
imshow(fig);
hold on;

load pixWayptrs_Campus.mat;
for i = 1 : size(wayptrs, 1)
    plot(wayptrs(i,1), wayptrs(i,2), 'ob');
    text(wayptrs(i,1)+0.8, wayptrs(i,2), num2str(i));
end;

load edges_Campus1+2.mat;
for i = 1 : size(edges, 1)
    I = edges(i,1);
    J = edges(i,2);
    plot([wayptrs(I,1), wayptrs(J,1)], ...
         [wayptrs(I,2), wayptrs(J,2)], '-b');
end;

%% indicate the portals
portals = [];
while 1
    [x,y] = ginput(1);
    i = find_min_id(x(1),y(1),wayptrs)
    portals = [portals, i];
    str = input('finish? (y)', 's');
    if str == 'y'
        break;
    end;
end;
