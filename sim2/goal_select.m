function gid = goal_select(G, agt, varargin)

gid = -1;

if ~isempty(varargin)
    Gr = varargin{1};
end;

if strcmp(agt.state, 'gs')
%     if length(agt.seq) > 1
%         if any(Gr.portals == agt.seq(end))
%             gid = 0;
%             return;
%         end;
%     end;
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
        w = 4.5;
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
        if DYNAMIC % dynamically changing attraction
            dw = compute_dynamic_factor(vind, goalList, Gr.hypind);
            attrList = dw .* attr(id, vind);
            isPortal = find(Gr.portals(1,:) == agt.seq(end));
            if ~isempty(isPortal)
                attrList = [attrList, Gr.portals(2,isPortal)];
            end;
            prob = exp(w * attrList) ./ sum(exp(w * attrList));
        else % static attraction
            attrList = attr(id, vind);
            isPortal = find(Gr.portals(1,:) == agt.seq(end));
            if ~isempty(isPortal)
                attrList = [attrList, Gr.portals(2,isPortal)];
            end;
            prob = exp(w * attrList) ./ sum(exp(w * attrList));
        end;
        
        
        selectID = randsample(length(prob), 1, true, prob);
        if ~isempty(isPortal) && selectID == length(prob) % choose to leave
            gid = 0;
            return;
        end;
        gid = ind(vind(selectID), 2);
        if ind(vind(selectID), 1) ~= agt.seq(end)
            disp('something wrong!');
        end;
    end;
    
end;