%% display the heatmap
clear;
clc;
close all;

% load ../sim2/data_rvo_dcm_Campus.mat;
% load ../sim/data_rvo_dcm_tradeshowL.mat;
% load ../sim_div/data_rvo_dcm_tradeshow_new1.mat;
% load ../sim_div/data_rvo_dcm_tradeshow_new.mat;
% load ../sim_div/data_rvo_dcm_tradeshow_new2.mat;
% load ../sim_div/data_rvo_dcm_tradeshow_new_s5slm.mat;
% load data_rvo_dcm_tradeshow_new_s5ssm.mat;
% load data_rvo_dcm_tradeshow_new_lssl.mat;
% load data_rvo_dcm_tradeshow_new_mslm.mat;
% load data_rvo_dcm_tradeshow_new_msls.mat;
% load data_rvo_dcm_tradeshow_new_msmm.mat;
% load data_rvo_dcm_tradeshow_new_msms.mat;
% load data_rvo_dcm_tradeshow_new_msmn.mat;% actually in simulation the initial entry is random...meaningless
% load data_rvo_dcm_tradeshow_new_msam.mat;
load data_rvo_dcm_tradeshow_new_msmm2.mat;

data = zeros(360, 360);
sampleRate = 1;
gridSize = .1;
minPadding = 20;

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