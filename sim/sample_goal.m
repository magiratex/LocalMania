function pos = sample_goal(goal, varargin)

if isempty(varargin)

    pos = mvnrnd(goal.pos, goal.afford);
else
    nextg = varargin{1};
    currg = varargin{2};
    goalpos = varargin{3};
    pos = [];
    
    % FIXME: hard-coded
    if (nextg == 12 && currg == 8) || ...
       (nextg == 8 && currg == 12)
        pos = sample_in_between(goalpos(8,:), goalpos(12,:),'rb');
    end;
    
    if (nextg == 13 && currg == 8) || ...
       (nextg == 8 && currg == 13)
        pos = sample_in_between(goalpos(8,:), goalpos(13,:),'rt');
    end;
    
    if (nextg == 13 && currg == 16) || ...
       (nextg == 16 && currg == 13)
        pos = sample_in_between(goalpos(16,:), goalpos(13,:),'lt');
    end;
    
    if (nextg == 14 && currg == 16) || ...
       (nextg == 16 && currg == 14)
        pos = sample_in_between(goalpos(16,:), goalpos(14,:),'rb');
    end;
    
    if (nextg == 15 && currg == 16) || ...
       (nextg == 16 && currg == 15)
        pos = sample_in_between(goalpos(16,:), goalpos(15,:),'rt');
    end;
    
    if (nextg == 21 && currg == 14) || ...
       (nextg == 14 && currg == 21)
        pos = sample_in_between(goalpos(14,:), goalpos(21,:),'lt');
    end;
    
    if (nextg == 20 && currg == 14) || ...
       (nextg == 14 && currg == 20)
        pos = sample_in_between(goalpos(14,:), goalpos(20,:),'lb');
    end;
    
    if (nextg == 20 && currg == 15) || ...
       (nextg == 15 && currg == 20)
        pos = sample_in_between(goalpos(15,:), goalpos(20,:),'lt');
    end;
    
    if (nextg == 4 && currg == 5) || ...
       (nextg == 5 && currg == 4)
        pos = sample_in_between(goalpos(4,:), goalpos(5,:),'rt');
    end;
    
    if (nextg == 4 && currg == 1) || ...
       (nextg == 1 && currg == 4)
        pos = sample_in_between(goalpos(4,:), goalpos(1,:),'rb');
    end;
    
    if (nextg == 11 && currg == 12) || ...
       (nextg == 12 && currg == 11)
        pos = sample_in_between(goalpos(11,:), goalpos(12,:),'lt');
    end;
    
    pos = [pos; mvnrnd(goal.pos, goal.afford)];
end;

function pos = sample_in_between(apos, bpos, orient)

xmin = min(apos(1), bpos(1));
xmax = max(apos(1), bpos(1));
ymin = min(apos(2), bpos(2));
ymax = max(apos(2), bpos(2));

if strcmp(orient, 'lb') % left bottom
    p = [xmin, ymax];
elseif strcmp(orient, 'rb') % right bottom
    p = [xmax, ymax];
elseif strcmp(orient, 'lt') % left top
    p = [xmin, ymin];
elseif strcmp(orient, 'rt') % right top
    p = [xmax, ymin];
end;

% pos = mvnrnd(p, diag([0.1, 0.1]));
pos = p;
