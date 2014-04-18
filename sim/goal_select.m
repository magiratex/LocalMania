function gid = goal_select(G, agt)

gid = -1;

if strcmp(agt.state, 'gs')
    connected = find(G(agt.gid, :) == 1);
    
    while 1
        gid = randi(length(connected)); % naive model
        gid = connected(gid);
%         if gid == 1
%         end;
        if gid ~= agt.seq(end) && length(agt.seq)==1
            break;
        end;
        if length(agt.seq)>1 && gid ~= agt.seq(end-1) && gid ~= agt.seq(end)
            break;
        end;
    end;
end;