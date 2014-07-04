%% display the heatmap
clear;
clc;
close all;

% load ../sim2/data_rvo_dcm_Campus.mat;
% load ../sim/data_rvo_dcm_tradeshowL.mat;
% load ../sim_div/data_rvo_dcm_tradeshow_new1.mat;
load ../sim_div/data_rvo_dcm_tradeshow_new.mat;
% load ../sim_div/data_rvo_dcm_tradeshow_new2.mat;

data = zeros(350, 350);
sampleRate = 1;
gridSize = .1;
minPadding = 10;

for i = 1 : numel(agtList)
    trk = agtList(i).traj(1:sampleRate:end,:);
    trk = int32(ceil(trk ./ gridSize)+minPadding);
    for j = 1 : size(trk,1)
        data(trk(j,2), trk(j,1)) = data(trk(j,2), trk(j,1)) + 1;
    end;
end;
data = flipud(data);
maxv = max(max(data));
data = (data ./ maxv) * 2 - 1; % normalize to [-1,1]


figure;
% HeatMap(data, 'Colormap', colormap(hot(128)));
HeatMap(data, 'Colormap', colormap(jet(128)));