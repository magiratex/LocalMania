function estAttr = est_prior(estAttr, Gr)

gtr = Gr.attr;
% for i = 1 : size(gtr, 1)
% %     [mval, ind] = max(gtr(i,:));
% %     if mval == 0, continue; end;
% %     k = mval / estAttr(i, ind);
% %     disp('>>>>>>>>>>>>>>>>>>>');
% %     estAttr(i, estAttr(i,:)~=0)
% %     estAttr(i, :) = estAttr(i, :) * k;
% %     estAttr(i, estAttr(i,:)~=0)
% %     gtr(i, gtr(i,:)~=0)
% 
%     [mval, ind] = max(abs(gtr(i,:) - estAttr(i,:)));
%     if mval == 0, continue; end;
%     dif = gtr(i,ind) - estAttr(i,ind);
%     nonzeroind = estAttr(i,:)~=0;
% %     estAttr(i, nonzeroind)
%     
%     estAttr(i, nonzeroind) = estAttr(i, nonzeroind) + dif;
% %     estAttr(i, nonzeroind)
% %     gtr(i, nonzeroind)
% end

x = [];
y = [];
for i = 1 : size(gtr, 1)
    if max(gtr(i,:)) ==0, continue; end;
    nonzeroind = gtr(i,:)~=0;
    x = [x; max(gtr(i, nonzeroind)) - min(gtr(i, nonzeroind))];
    y = [y; max(log(estAttr(i,nonzeroind))) - min(log(estAttr(i,nonzeroind)))];
end
[w, fval] = glmfit(x, y);
w = w(end);
for i = 1 : size(gtr, 1)
    if max(gtr(i,:)) ==0, continue; end;
    nonzeroind = gtr(i,:)~=0;
    Z = w * min(gtr(i, nonzeroind)) - min(log(estAttr(i,nonzeroind)));
%     estAttr(i, nonzeroind)
    estAttr(i,nonzeroind) = (log(estAttr(i,nonzeroind)) + Z) ./ w;
%     estAttr(i, nonzeroind)
%     gtr(i, nonzeroind)
end

end
