%% noisy prior

clc;
close all;

exp = 'exp3_guess_attr_';
fid = 0;

% for d = [0.01, 0.05, 0.1, 0.2, 0.3, 0.5]
% % for d = [0.01, ]
%     
%     fprintf('----- %f: noise %f -------\n', fid, d)
%     fstr = [exp, num2str(fid)];
%     main4(3000, 5, 15, 2.5, 3.0, fstr, d);
%     
%     fid = fid + 1;
% end


fprintf('----- %f -------\n', fid)
fstr = [exp, num2str(fid)];
main4(3000, 5, 12, 2.5, rand(1)*4, fstr, 0.0);
fid = fid + 1;

fprintf('----- %f -------\n', fid)
fstr = [exp, num2str(fid)];
main4(3000, 7, 40, 2.5, rand(1)*4, fstr, 0.0);
fid = fid + 1;

fprintf('----- %f -------\n', fid)
fstr = [exp, num2str(fid)];
main4(3000, 8, 50, 2.5, rand(1)*4, fstr, 0.0);
fid = fid + 1;


fprintf('----- %f -------\n', fid)
fstr = [exp, num2str(fid)];
main4(3000, 9, 60, 2.5, rand(1)*4, fstr, 0.0);
fid = fid + 1;

fprintf('----- %f -------\n', fid)
fstr = [exp, num2str(fid)];
main4(3000, 10, 80, 2.5, rand(1)*4, fstr, 0.0);
fid = fid + 1;



%%

% d = 0.5;
% main3(5000, 5, 15, 2.5, 1.0, 1000, d);

% clc;
% % clear;
% exp = 'exp4_test';
% fid = 0;
% fstr = [exp, num2str(fid)];
% main4(3000, 5, 15, 2.5, 3.0, fstr, 0.0);
% disp('END');