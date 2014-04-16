clc;
close all;
fid = 10.1;
for w = 0.1:0.4:5
    
    fprintf('----- %f: %f -------\n', fid, w)
    main2(3000, 5, 15, w, 1.0, fid);
    
    fid = fid + 0.1;
end