%% noisy prior

clc;
close all;
fid = 11.1; 
for d = [0.01, 0.05, 0.1, 0.5]
    
    fprintf('----- %d -------\n', fid)
    main2(5000, 5, 15, w, 1.0, fid, d);
    
    fid = fid + 0.1;
end