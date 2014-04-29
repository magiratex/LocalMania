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
    

    %% random-0 rep
%     connected = find(G(agt.gid, :) == 1);
%     gid = randi(length(connected)); % naive model
%     gid = connected(gid);
    
    
    %% random-1 no-repi
%     connected = find(G(agt.gid, :) == 1);
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
    
    %% dcm
    if length(agt.seq) <= 1
        goodstart = find(G(agt.seq, :));
        gid = goodstart(randi(length(goodstart)));
    else
        w = 3.5;
        if length(varargin)==2
            goalList = varargin{2};
            DYNAMIC = 1;
        else
            DYNAMIC = 0;
        end;
        hypG = Gr.G;
        ind = Gr.hypind;
        attr = Gr.attr;
        id = find(find_ind(agt.seq(end-1:end), ind) ~= 0);
        vind = find(hypG(id, :));
        if DYNAMIC
            dw = compute_dynamic_factor(vind, goalList, Gr.hypind);
            attrList = dw .* attr(id, vind);
            prob = exp(w * attrList) ./ sum(exp(w * attrList));
        else
            prob = exp(w * attr(id, vind)) ./ sum(exp(w * attr(id, vind)));
        end;
        
        
        
        selectID = randsample(length(vind), 1, true, prob);
        gid = ind(vind(selectID), 2);
        if ind(vind(selectID), 1) ~= agt.seq(end)
            disp('something wrong!');
        end;
    end;
    
end;