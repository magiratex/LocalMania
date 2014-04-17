clc;
close all;

exp = 'exp2ex_';
fid = 0;
% fid = 10.1;
for w = 0.1:0.4:5
    
    fprintf('\n\n\n----- %f: %f -------\n', fid, w)
    fstr = [exp, num2str(fid)];
    main2(3000, 5, 20, w, 1.0, fstr);
    
    fid = fid + 1;
end