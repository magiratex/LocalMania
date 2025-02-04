%% simulation of tradeshow

function lazy_sim

addpath('..\utils\');
clc; close all;

global goalSelectType;

%% configuration
% load graph info
% graphN = 5;
% G = zeros(graphN);
% G(1,2) = 1; G(2,1) = 1;
% G(2,3) = 1; G(3,2) = 1;
% G(3,4) = 1; G(4,3) = 1;
% G(3,5) = 1; G(5,3) = 1;
% G(4,5) = 1; G(5,4) = 1;
load graphInfo.mat;
graphN = size(Gr.origG, 1);
G = Gr.origG;
hypG = Gr.G;
ind = Gr.hypind;

load attr1.mat;
Gr.attr = attrPrior.attr;


% goal info; construct goal structures
% goalPos = [0    0;
%            6    0;
%            12   0;
%            9    5;
%            13   8];
load pixWayptrs.mat;
sc = 0.03;
goalPos = wayptrs * sc;
Gr.goalPos = goalPos;
for i = 1 : graphN
    goalList(i).pos = goalPos(i, :);
    goalList(i).afford = [0.03   0;
                          0     0.03];
    goalList(i).n = 0;
    goalList(i).nMax = 100;
end;

load portals.mat;
Gr.portals = portals;

% load other simulation info:
% - rvo parameters
% - emerging timings
agtN = 0;
dT = 0.04;
speed = 3.5;
param = [8.1340   3.9219   0.0392    1.0000    0.1175    2.5159    dT  1  0.93];
Gr.speed = speed;
displayMode = 'off';

%% simulation
T = 3000;
fig = imread('scene.png');

if strcmp(displayMode, 'on')
    figure;
end;
for t = 1 : T
    if mod(t, 100) == 0
        disp(t);
    end;
    %% new agent
    %if t == 1 || t == 50 || t == 100   % or any new-agent condition
    if mod(t, 10) == 1
        agtN = agtN + 1;
        initG = randi(length(portals));
        initG = portals(initG);
        agtList(agtN).seq = initG;  % initial goal
        agtList(agtN).pos = sample_goal(goalList(initG)); %mvnrnd(goalPos, goalList(initG).afford);
        agtList(agtN).vel = [0  0];
        agtList(agtN).state = [];
        agtList(agtN).goal = [];
        agtList(agtN).gid = initG;
        agtList(agtN).pref = [];
        agtList(agtN).traj = [];
        agtList(agtN).count = 0;
        
        if initG == 20
        end;
        
        agtList(agtN) = goal_select_stage(agtList(agtN), G, goalList, dT, Gr);
    end;
    
    %% rvo updates
    conf = [];
    for i = 1 : length(agtList)
        if ~strcmp(agtList(i).state, 'out')
            conf = [conf; t, i, agtList(i).pos, agtList(i).vel, agtList(i).pref, agtList(i).goal(1,:)];
        end;
    end;
    
    %% draw agents
    if strcmp(displayMode, 'on')
        imshow(fig);
        hold on;
        plot(goalPos(:, 1)/sc, goalPos(:, 2)/sc, 'Or');
        plot(conf(:, 3)/sc, conf(:, 4)/sc, 'ob');
    end;
    
    %% update agents
    simRes = rvo_sim(0, conf(:, 3:end-2), param);
    simRes = reshape(simRes, 4, [])';
    conf(:, 3:6) = simRes; % update position and velocity
    conf(:, 7:8) = speed * (conf(:, end-1:end) - conf(:, 3:4))/norm(conf(:, end-1:end) - conf(:, 3:4));
    conf(:, 3:8) = conf(:, 3:8) + mvnrnd(zeros(1,6), diag([0.0, 0.0, 0.001, 0.001, 0.002, 0.002]), size(conf,1));
    
    for i = 1 : size(conf, 1)
        aid = conf(i, 2);
        agtList(aid).pos = conf(i, 3:4);
        agtList(aid).vel = conf(i, 5:6);
        agtList(aid).pref = conf(i, 7:8);
        agtList(aid).traj = [agtList(aid).traj; agtList(aid).pos];
        if strcmp(displayMode, 'on')
            plot(agtList(aid).traj(:,1)/sc, agtList(aid).traj(:,2)/sc, '-b');
        end;
        
        % check if agents reaches goal
        if norm(agtList(aid).pos - agtList(aid).goal(1,:)) < 0.8 && size(agtList(aid).goal,1) > 1
            % intermediate goal reached
            agtList(aid).goal = agtList(aid).goal(2:end, :);
            agtList(aid).pref = speed * (agtList(aid).goal(1,:) - agtList(aid).pos)/...
                                norm(agtList(aid).goal(1,:) - agtList(aid).pos);
                            
        elseif norm(agtList(aid).pos - agtList(aid).goal(1,:)) < 0.5 && size(agtList(aid).goal,1) == 1
            agtList(aid).seq = [agtList(aid).seq, agtList(aid).gid];    
            if strcmp(displayMode, 'on')
                plot(goalPos(agtList(aid).gid, 1)/sc, goalPos(agtList(aid).gid, 2)/sc, 'LineWidth', 2.0,...
                    'Color', [1, 0, 0], 'LineStyle', 'o');
            end;
            
            % select another goal
            agtList(aid) = goal_select_stage(agtList(aid), G, goalList, dT, Gr);
            agtList(aid).count = agtList(aid).count + 1;
        end;
%         if norm(agtList(aid).pos - agtList(aid).goal) < 0.3
%             %disp('reached');
%             agtList(aid).seq = [agtList(aid).seq, agtList(aid).gid];
%             
%             plot(goalPos(agtList(aid).gid, 1)/sc, goalPos(agtList(aid).gid, 2)/sc, 'LineWidth', 2.0,...
%                 'Color', [1, 0, 0], 'LineStyle', 'o');
%             
%             % select another goal
%             agtList(aid) = goal_select_stage(agtList(aid), G, goalList, dT, Gr);
%         end;
    end;
    
    %%
    
    pause(dT);
    if strcmp(displayMode, 'on')
        hold off;
    end;
end;

save(['data_rvo_',goalSelectType,'_tradeshowL.mat'], 'agtList');
% save data agtList;

function agt = goal_select_stage(agt, G, goalList, dT, Gr)

agt.state = 'gs'; % goal selection stage
nextG = goal_select(G, agt, Gr);
if nextG == 0, 
    agt.state = 'out'; 
    return; 
end;
agt.goal = sample_goal(goalList(nextG), nextG, agt.seq(end), Gr.goalPos);
agt.gid = nextG;
agt.pref = Gr.speed * ((agt.goal(1,:) - agt.pos)/ norm(agt.goal(1,:) - agt.pos));
agt.state = 'mov'; % moving stage


