%% noisy prior

clc;
close all;

exp = 'exp4_';
fid = 0;

for d = [0.01, 0.05, 0.1, 0.2, 0.3, 0.5]
% for d = [0.01, ]
    
    fprintf('----- %f: noise %f -------\n', fid, d)
    fstr = [exp, num2str(fid)];
    main4(3000, 5, 15, 2.5, 1.0, fstr, d);
    
    fid = fid + 1;
end

%%

% d = 0.5;
% main3(5000, 5, 15, 2.5, 1.0, 1000, d);