clc

%% large

% fid = 1.0;
% tic
% main2(5000, 10, 80, 2.5, 1.0, fid);
% toc
% 
% fid = fid + 0.1;
% tic
% main2(5000, 10, 80, 2.5, 0.1, fid);
% toc
% 
% fid = fid + 0.1;
% tic
% main2(5000, 10, 80, 2.5, 3.5, fid);
% toc


%%

% fid = 2.0;
% tic
% main2(5000, 12, 90, 2.5, 1.0, fid);
% toc
% 
% fid = fid + 0.1;
% tic
% main2(5000, 12, 90, 2.5, 0.1, fid);
% toc
% 
% fid = fid + 0.1;
% tic
% main2(5000, 12, 90, 2.5, 3.5, fid);
% toc


%%
clc
exp = 'exp2_';
fid = 0;
fstr = [exp, num2str(fid)];
tic
main2(2000, 5, 15, 2.5, 1.0, fstr);
toc

fid = fid + 1;
fstr = [exp, num2str(fid)];
tic
main2(2000, 5, 15, 2.5, 0.1, fstr);
toc

fid = fid + 1;
fstr = [exp, num2str(fid)];
tic
main2(2000, 5, 15, 2.5, 3, fstr);
toc

fid = fid + 1;
fstr = [exp, num2str(fid)];
tic
main2(2000, 5, 15, 2.5, 3.5, fstr);
toc

%%

exp = 'exp2_';
% fid = 1;
fstr = [exp, num2str(fid)];
tic
main2(2000, 7, 40, 2.5, 1.0, fstr);
toc

fid = fid + 1;
fstr = [exp, num2str(fid)];
tic
main2(2000, 7, 40, 2.5, 0.1, fstr);
toc

fid = fid + 1;
fstr = [exp, num2str(fid)];
tic
main2(2000, 7, 40, 2.5, 3, fstr);
toc

fid = fid + 1;
fstr = [exp, num2str(fid)];
tic
main2(2000, 7, 40, 2.5, 3.5, fstr);
toc

%%

exp = 'exp2_';
% fid = 2;
fstr = [exp, num2str(fid)];
tic
main2(2000, 8, 50, 2.5, 1.0, fstr);
toc

fid = fid + 1;
fstr = [exp, num2str(fid)];
tic
main2(2000, 8, 50, 2.5, 0.1, fstr);
toc

fid = fid + 1;
fstr = [exp, num2str(fid)];
tic
main2(2000, 8, 50, 2.5, 3, fstr);
toc

fid = fid + 1;
fstr = [exp, num2str(fid)];
tic
main2(2000, 8, 50, 2.5, 3.5, fstr);
toc

%%

exp = 'exp2_';
% fid = 3;
fstr = [exp, num2str(fid)];
tic
main2(2000, 9, 60, 2.5, 1.0, fstr);
toc

fid = fid + 1;
fstr = [exp, num2str(fid)];
tic
main2(2000, 9, 60, 2.5, 0.1, fstr);
toc

fid = fid + 1;
fstr = [exp, num2str(fid)];
tic
main2(2000, 9, 60, 2.5, 3, fstr);
toc

fid = fid + 1;
fstr = [exp, num2str(fid)];
tic
main2(2000, 9, 60, 2.5, 3.5, fstr);
toc

%%

exp = 'exp2_';
% fid = 3;
fstr = [exp, num2str(fid)];
tic
main2(2000, 10, 80, 2.5, 1.0, fstr);
toc

fid = fid + 1;
fstr = [exp, num2str(fid)];
tic
main2(2000, 10, 80, 2.5, 0.1, fstr);
toc

fid = fid + 1;
fstr = [exp, num2str(fid)];
tic
main2(2000, 10, 80, 2.5, 3, fstr);
toc

fid = fid + 1;
fstr = [exp, num2str(fid)];
tic
main2(2000, 10, 80, 2.5, 3.5, fstr);
toc
