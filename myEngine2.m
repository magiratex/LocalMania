clc;
close all;
fid = 10.1;
for w = 1:0.4:5
    
    fprintf('----- %d -------\n', fid)
    main2(5000, 5, 15, w, 1.0, fid);
    
    fid = fid + 0.1;
end