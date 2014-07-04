function pos = sample_goal(goal, varargin)

if isempty(varargin)

    pos = mvnrnd(goal.pos, goal.afford);
else
    nextg = varargin{1};
    currg = varargin{2};
    goalpos = varargin{3};
    edges = varargin{4};
    pos = [];
    
    I = arrayfun(@(I) (edges(I,1)==currg && edges(I,2)==nextg) || ...
                      (edges(I,2)==currg && edges(I,1)==nextg), 1:size(edges,1));
    pos = edges(I, 3:4);
    pos = [pos; mvnrnd(goal.pos, goal.afford)];
end;

% function pos = sample_in_between(apos, bpos, orient)
% 
% xmin = min(apos(1), bpos(1));
% xmax = max(apos(1), bpos(1));
% ymin = min(apos(2), bpos(2));
% ymax = max(apos(2), bpos(2));
% 
% if strcmp(orient, 'lb') % left bottom
%     p = [xmin, ymax];
% elseif strcmp(orient, 'rb') % right bottom
%     p = [xmax, ymax];
% elseif strcmp(orient, 'lt') % left top
%     p = [xmin, ymin];
% elseif strcmp(orient, 'rt') % right top
%     p = [xmax, ymin];
% end;
% 
% % pos = mvnrnd(p, diag([0.1, 0.1]));
% pos = p;
