function dw = compute_dynamic_factor(vind, goalList, ind)

f = @(x) exp(.8 * x) - exp(10) * exp(-9.2*sqrt(1./x));

xlist = zeros(1, length(goalList));
fval = zeros(1, length(goalList));

for i = 1 : length(goalList)
    xlist(i) = goalList(i).n / goalList(i).nMax;
    fval(i) = f(xlist(i));
end;

dw = zeros(1, length(vind));
for i = 1 : length(vind)
    dw(i) = fval(ind(vind(i), 2));
end;