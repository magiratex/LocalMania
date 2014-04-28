%% noisy prior

clc;
close all;

exp = 'exp3_';
% exp = 'exp4_';
fid = 0;

for d = [0.01, 0.05, 0.1, 0.2, 0.3, 0.5]
% for d = [0.01, ]
    
    fprintf('----- %f: noise %f -------\n', fid, d)
    fstr = [exp, num2str(fid)];
    main3(3000, 5, 15, 2.5, rand(1)*4, fstr, d);
    
    fid = fid + 1;
end

%%

% clc;
% close all;
% 
% exp = 'exp3_est_prior';
% fstr = exp;
% main3(3000, 5, 15, 2.5, 4.0, fstr, 0.6);
% disp('END');