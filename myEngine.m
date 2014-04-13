%% large

fid = 1.0;
tic
main2(5000, 15, 150, 2.5, 1.0, fid);
toc

fid = fid + 0.1;
tic
main2(5000, 15, 150, 2.5, 0.1, fid);
toc

fid = fid + 0.1;
tic
main2(5000, 15, 150, 2.5, 3.5, fid);
toc

