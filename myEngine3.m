%% noisy prior

clc;
close all;

fid = 30.1; 

for d = [0.01, 0.05, 0.1, 0.2, 0.3, 0.5]
% for d = [0.01, ]
    
    fprintf('----- %f: noise %f -------\n', fid, d)
    main3(5000, 5, 15, 2.5, 2.0, fid, d);
    
    fid = fid + 0.1;
end

%%

% d = 0.5;
% main3(5000, 5, 15, 2.5, 1.0, 1000, d);