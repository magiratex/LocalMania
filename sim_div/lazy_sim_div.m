%% simulation of tradeshow

function lazy_sim_div

addpath('..\utils\');
clc; close all;

global goalSelectType;
goalSelectType = 'dcm';

%% configuration
% load graph info
% graphN = 5;
% G = zeros(graphN);
% G(1,2) = 1; G(2,1) = 1;
% G(2,3) = 1; G(3,2) = 1;
% G(3,4) = 1; G(4,3) = 1;
% G(3,5) = 1; G(5,3) = 1;
% G(4,5) = 1; G(5,4) = 1;
% load graphInfo_Campus1+2.mat;
load graphInfo_tradeshow.mat;
graphN = size(Gr.origG, 1);
G = Gr.origG;
hypG = Gr.G;
ind = Gr.hypind;

% load attr_Campus1+2.mat;
% Gr.attr = attr;
% trans = []; % FIXME: require precomputed transition 
% load trans_tradeshow_new_test.mat;
% load trans_tradeshow_new.mat;
% load trans_tradeshow_new_short5.mat;
% load trans_tradeshow_new_moveupd.mat;
% load trans_tradeshow_new_s5slm.mat;
% load trans_tradeshow_new_lssl.mat;
% load trans_tradeshow_new_mslm.mat;
% load trans_tradeshow_new_msls.mat;
% load trans_tradeshow_new_msms.mat;
% load trans_tradeshow_new_msam.mat;
load trans_tradeshow_new_msmm.mat;
Gr.T = trans; % transition probability


% load pixWayptrs_Campus.mat;
load pixwayptrs_tradeshow_new.mat;
% sc = 0.1; % FIXME: scale
sc = 0.0359;
goalPos = wayptrs * sc;
Gr.goalPos = goalPos;
for i = 1 : graphN
    goalList(i).pos = goalPos(i, :);
    goalList(i).afford = [0.2   0;
                          0     0.2];
    goalList(i).n = 0;
    goalList(i).nMax = 10;
end;

% load edges_Campus1+2.mat;
load edges_tradeshow_new.mat;
Gr.edges = edges;
Gr.edges(:,3:4) = sc * Gr.edges(:,3:4);

% load portals_Campus1+2.mat;
load portals_tradeshow_new.mat;
Gr.portals = portals;
% portals(portals == 25) = []; % <---------- hard-code
initprob = [0.2, 0.03, 0.03, 0.03, 0.03, 0.3];
initprob = initprob ./ sum(initprob);

% load virtualgoals_Campus.mat;
load virtgoals_tradeshow.mat;

% load other simulation info:
% - rvo parameters
% - emerging timings
agtN = 0;
dT = 0.04;
speed = 3.5;
% param = [8.1340   3.9219   0.0392    1.0000    0.1175    2.5159    dT  1  0.93];
param = [5.1340   3.9219   0.1392    1.0000    0.1175    5.5159    dT  1  0.93];
Gr.speed = speed;
displayMode = 'off';
statGoals = [];
statFPS = [];

%% simulation
T = 6000;

global Ngs;
global TT;
global TimeRecord;
Ngs = zeros(T,1);
TimeRecord = [];

%%
fig = imread('map4.png');

if strcmp(displayMode, 'on')
    figure;
end;
for t = 1 : T
    TT = t;
    checkTime = cputime;
    if mod(t, 100) == 0
        disp(t);
    end;
    %% new agent
%     fprintf('new agent born!\n');
%     if t == 1 || t == 50 || t == 100   % or any new-agent condition
    if mod(t, 10) == 1
        agtN = agtN + 1;
        initG = randsample(numel(portals), 1, true, initprob);
        %initG = randi(length(portals));
        initG = portals(1,initG);
        agtList(agtN).seq = initG;  % initial goal
        agtList(agtN).pos = sample_goal(goalList(initG)); %mvnrnd(goalPos, goalList(initG).afford);
        agtList(agtN).vel = [0  0];
        agtList(agtN).state = [];
        agtList(agtN).goal = [];
        agtList(agtN).gid = initG;
        agtList(agtN).pref = [];
        agtList(agtN).traj = [];
        agtList(agtN).stay = 0;
        agtList(agtN).count = 0;
        
        agtList(agtN) = goal_select_stage(agtList(agtN), G, goalList, dT, Gr);
    end;
    
    %% rvo updates
%     fprintf('rvo state sets up!\n');
    conf = [];
    stayList = [];
    for i = 1 : length(agtList)
        if ~strcmp(agtList(i).state, 'out') && ~strcmp(agtList(i).state, 'stay')
            conf = [conf; t, i, agtList(i).pos, agtList(i).vel, agtList(i).pref, agtList(i).goal(1,:)];
        end;
        
        if strcmp(agtList(i).state, 'stay') % not put into the goal
            stayList = [stayList; agtList(i).pos];
            agtList(i).stay = agtList(i).stay - 1;
            if agtList(i).stay <= 0
                goalList(agtList(i).gid).n = goalList(agtList(i).gid).n - 1;
                if goalList(agtList(i).gid).n < 0
                    disp('SOMETHING WRONG!');
                end;
                % select another goal
                agtList(i) = goal_select_stage(agtList(i), G, goalList, dT, Gr);
            end;
        end;
    end;
    
    %% draw agents
    if strcmp(displayMode, 'on')
        imshow(fig);
        hold on;
        plot(goalPos(:, 1)/sc, goalPos(:, 2)/sc, 'Or');
        if ~isempty(conf)
            plot(conf(:, 3)/sc, conf(:, 4)/sc, 'ob');
        end;
        if ~isempty(stayList)
            plot(stayList(:, 1)/sc, stayList(:,2)/sc, 'oc');
        end;
    end;
    
    %% update agents
%     fprintf('rvo updating!\n');
    if ~isempty(conf)
        simRes = rvo_sim(0, conf(:, 3:end-2), param);
        simRes = reshape(simRes, 4, [])';
        conf(:, 3:6) = simRes; % update position and velocity
        conf(:, 7:8) = speed * (conf(:, end-1:end) - conf(:, 3:4))/norm(conf(:, end-1:end) - conf(:, 3:4));
        conf(:, 3:8) = conf(:, 3:8) + mvnrnd(zeros(1,6), diag([0.0, 0.0, 0.001, 0.001, 0.002, 0.002]), size(conf,1));
    end;
    
    %% check agent state
%     fprintf('check agent state!\n');
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
            % reach booth
            agtList(aid).seq = [agtList(aid).seq, agtList(aid).gid];    
            if strcmp(displayMode, 'on')
                plot(goalPos(agtList(aid).gid, 1)/sc, goalPos(agtList(aid).gid, 2)/sc, 'LineWidth', 2.0,...
                    'Color', [1, 0, 0], 'LineStyle', 'o');
            end;
            

            if strcmp(agtList(aid).state, 'out')
                continue;
            end;
            
            % otherwise
            if ~max(virtgoals == agtList(aid).gid)
                agtList(aid).state = 'stay';
                %agtList(aid).stay = int32(rand(1) * 300);
                agtList(aid).stay = int32(rand(1) * 10);
                goalList(agtList(aid).gid).n = goalList(agtList(aid).gid).n + 1;
            else
                agtList(aid) = goal_select_stage(agtList(aid), G, goalList, dT, Gr);
            end;
            agtList(aid).count = agtList(aid).count + 1;
        end;
    end;
    
    %%
    statGoals = [statGoals; [goalList(:).n]];
    
    %%
    if strcmp(displayMode, 'on')
        pause(dT);
        hold off;
        statFPS = [statFPS; size(conf,1), (cputime - checkTime)];
    else
        statFPS = [statFPS; size(conf,1), (cputime - checkTime)];
        %fprintf('The number of agents: %d; %.3f\n',size(conf,1), (cputime - checkTime))
    end;
    
    frameInfo(t).moving = conf;
    frameInfo(t).staying = stayList;
end;

% save(['data_rvo_',goalSelectType,'_Campus.mat'], 'agtList');
% save data_norep_Campus agtList;
% save stat statGoals;
% save statFPS statFPS;
% save('frameInfo_rvo_dcm_Campus.mat', 'frameInfo');
% save num_goal_select Ngs;
% save record_time TimeRecord;
save(['data_rvo_',goalSelectType,'_tradeshow_new_msmm2.mat'], 'agtList');
% save data_norep_Campus agtList;
% save stat statGoals;
% save statFPS statFPS;
% save('frameInfo_rvo_dcm_CampusK.mat', 'frameInfo');

function agt = goal_select_stage(agt, G, goalList, dT, Gr)

chtime = cputime;
% fprintf('goal selecting!\n');
agt.state = 'gs'; % goal selection stage
% nextG = goal_select(G, agt, Gr, goalList);
nextG = goal_select(G, agt, Gr);
if nextG == 0, 
    agt.state = 'out'; 
    return; 
end;
agt.goal = sample_goal(goalList(nextG), nextG, agt.seq(end), Gr.goalPos, Gr.edges);
agt.gid = nextG;
agt.pref = Gr.speed * ((agt.goal(1,:) - agt.pos)/ norm(agt.goal(1,:) - agt.pos));
agt.state = 'mov'; % moving stage

global Ngs;
global TT;
global TimeRecord;
Ngs(TT,1) = Ngs(TT,1) + 1;
TimeRecord = [TimeRecord; cputime - chtime];

