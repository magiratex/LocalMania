%% simulation of tradeshow

function lazy_sim

clc; close all;

%% configuration
% load graph info
graphN = 5;
G = zeros(graphN);
G(1,2) = 1; G(2,1) = 1;
G(2,3) = 1; G(3,2) = 1;
G(3,4) = 1; G(4,3) = 1;
G(3,5) = 1; G(5,3) = 1;
G(4,5) = 1; G(5,4) = 1;

% goal info; construct goal structures
goalPos = [0    0;
           6    0;
           12   0;
           9    5;
           13   8];
for i = 1 : graphN
    goalList(i).pos = goalPos(i, :);
    goalList(i).afford = [1 0;
                          0 1];
    goalList(i).n = 0;
    goalList(i).nMax = 100;
end;



% load other simulation info:
% - rvo parameters
% - emerging timings
agtN = 0;
dT = 0.04;
param = [8.1340   3.9219   0.0392    1.0000    0.1175    2.5159    dT  1  0.9];

%% simulation
T = 800;

figure;
for t = 1 : T
    
    %% new agent
    if t == 1 || t == 50 || t == 100   % or any new-agent condition
        agtN = agtN + 1;
        initG = 1;
        agtList(agtN).seq = initG;  % initial goal
        agtList(agtN).pos = sample_goal(goalList(initG)); %mvnrnd(goalPos, goalList(initG).afford);
        agtList(agtN).vel = [0  0];
        agtList(agtN).state = [];
        agtList(agtN).goal = [];
        agtList(agtN).gid = initG;
        agtList(agtN).pref = [];
        
        agtList(agtN) = goal_select_stage(agtList(agtN), G, goalList, dT);
    end;
    
    %% rvo updates
    conf = [];
    for i = 1 : length(agtList)
        if ~strcmp(agtList(i).state, 'out')
            conf = [conf; t, i, agtList(i).pos, agtList(i).vel, agtList(i).pref, agtList(i).goal];
        end;
    end;
    
    %% draw agents
    plot(goalPos(:, 1), goalPos(:, 2), 'Or');
    hold on;
    plot(conf(:, 3), conf(:, 4), 'ob');
    xlim([-2, 20]);
    ylim([-2, 20]);
    pause(dT);
    hold off;
    
    %% update agents
    simRes = rvo_sim(0, conf(:, 3:end-2), param);
    simRes = reshape(simRes, 4, [])';
    conf(:, 3:6) = simRes; % update position and velocity
    conf(:, 7:8) = (conf(:, end-1:end) - conf(:, 3:4))/dT;
    
    for i = 1 : size(conf, 1)
        aid = conf(i, 2);
        agtList(aid).pos = conf(i, 3:4);
        agtList(aid).vel = conf(i, 5:6);
        agtList(aid).pref = conf(i, 7:8);
        
        % check if agents reaches goal
        if norm(agtList(aid).pos - agtList(aid).goal) < 0.5
            disp('reached');
            agtList(aid).seq = [agtList(aid).seq, agtList(aid).gid];
            
            % select another goal
            agtList(aid) = goal_select_stage(agtList(aid), G, goalList, dT);
        end;
    end;
end;

function agt = goal_select_stage(agt, G, goalList, dT)

agt.state = 'gs'; % goal selection stage
nextG = goal_select(G, agt);
agt.goal = sample_goal(goalList(nextG));
agt.gid = nextG;
agt.pref = (agt.goal - agt.pos)/dT;
agt.state = 'mov'; % moving stage


