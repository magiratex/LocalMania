%% Social force implementation
% param = [social_scale, radius, reaction_time, repulse_const, coeff_friction]

%%
function res = helbPredict(id, input, dT, groupParam, indvParam)

T = input(id, :);
Others = input([1:id-1,id+1:end],:);

[p, v] = compHelbing(T, Others, dT, groupParam, indvParam);
res = [p, v];

end

%%
function [p, v] = compHelbing(T, Others, dT, groupParam, indvParam)

reactTime = indvParam(3);
groupRadi = groupParam(2);
indvRadi = indvParam(2);
socialScale = indvParam(1);
repulseConst = indvParam(4);
coeffFric = indvParam(5);

mass = 80;
force = (T(5:6) - T(3:4)) * mass / reactTime;
radi = groupRadi + indvRadi;

norm_ij = bsxfun(@plus, -Others(:, 1:2), T(1:2));
tan_ij = [norm_ij(:,2), -norm_ij(:,1)];
dist_ij = sqrt(sum(norm_ij .^ 2, 2));

scale_ij = socialScale * exp((radi - dist_ij) / .08);
f_social = bsxfun(@times, norm_ij, scale_ij);

for k = 1 : size(Others, 1)
    f_push = [0, 0];
    f_fric = [0, 0];
    if dist_ij(k) < radi
        if tan_ij(k, :) * T(3:4)' < 0, 
            tan_ij(k) = tan_ij(k) * -1;
        end;
        f_push = norm_ij(k) * repulseConst * (radi - dist_ij(k));
        f_fric = tan_ij(k) * (coeffFric * (radi - dist_ij(k))) * ...
                             (Others(k, 3:4) - T(3:4) * tan_ij(k)' / dist_ij(k));
    end;
    force = force + f_social(k, :) + f_push + f_fric;
end;

acc = force / mass;
v = T(3:4) + acc * dT;
p = T(1:2) + v * dT;

end