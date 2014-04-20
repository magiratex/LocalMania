function gid = goal_select(G, agt, varargin)

gid = -1;

if ~isempty(varargin)
    Gr = varargin{1};
end;

if strcmp(agt.state, 'gs')
    if length(agt.seq) > 1
        if any(Gr.portals == agt.seq(end))
            gid = 0;
            return;
        end;
    end;
    
%     connected = find(G(agt.gid, :) == 1);
    
%     % random
%     while 1
%         gid = randi(length(connected)); % naive model
%         gid = connected(gid);
%         if gid ~= agt.seq(end) && length(agt.seq)==1
%             break;
%         end;
%         if length(agt.seq)>1 && gid ~= agt.seq(end-1) && gid ~= agt.seq(end)
%             break;
%         end;
%     end;
    
    % dcm
    if length(agt.seq) <= 1
        goodstart = find(G(agt.seq, :));
        gid = goodstart(randi(length(goodstart)));
    else
        w = 2.5;
        %ind = varargin{2};
        hypG = Gr.G;
        ind = Gr.hypind;
        attr = Gr.attr;
        id = find(find_ind(agt.seq(end-1:end), ind) ~= 0);
        vind = find(hypG(id, :));
        prob = exp(w * attr(id, vind)) ./ sum(exp(w * attr(id, vind)));
        
        selectID = randsample(length(vind), 1, true, prob);
        gid = ind(vind(selectID), 2);
        if ind(vind(selectID), 1) ~= agt.seq(end)
            disp('something wrong!');
        end;
    end;
    
end;