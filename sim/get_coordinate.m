%%
% close all;
% 
% fig = imread('scene.png');
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
% save pixWayptrs wayptrs;

%%

close all;
clear;

fig = imread('scene.png');

figure;
imshow(fig);
hold on;

load pixWayptrs.mat;
for i = 1 : size(wayptrs, 1)
    plot(wayptrs(i,1), wayptrs(i,2), 'ob');
    text(wayptrs(i,1)+0.8, wayptrs(i,2), num2str(i));
end;

load edges.mat;
for i = 1 : size(edges, 1)
    d = edges(i,1);
    k = edges(i,2);
    plot(wayptrs([d,k],1), wayptrs([d,k],2), '-b');
end;
