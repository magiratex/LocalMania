function id = find_min_id(x,y,wayptrs)

disvec = bsxfun(@minus, wayptrs, [x,y]);
dist = sum(disvec .* disvec, 2);
[~, id] = min(dist);