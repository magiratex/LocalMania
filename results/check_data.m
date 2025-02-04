%% exp 2

clc
% for i = 10.1: 0.1: 11.3
%     fname = sprintf('data_%.1f.mat',i);
%     load(fname);
% %     fprintf('%.3f %.3f %.3f\n', backup.Gr.w, backup.iter(end).w,backup.iter(end-1).w);
% %     fprintf('%.3f %.4f\n', backup.Gr.w, sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))));
%     fprintf('%.4f %.4f\n', sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))), ...
%                       sqrt(sum(sum((backup.Gr.trans - backup.hmmT).^2))));
% end;

for i = 0 : 15
    fname = sprintf('data_exp2_%d.mat',i);
    load(fname);
    fprintf('%f %.3f %.3f %.3f ', backup.initw, backup.Gr.w, backup.iter(end).w,backup.iter(end-1).w);
    fprintf('%.4f ', sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))));
    fprintf('%.4f %.4f\n', sqrt(sum(sum((backup.Gr.trans - backup.iter(end).T).^2))), ...
                      sqrt(sum(sum((backup.Gr.trans - backup.hmmT).^2))));
end;


%% exp 2 - ex

clc
% for i = 1 : 7
%     fname = sprintf('data_21.%d.mat',i);
%     load(fname);
% %     fprintf('%.3f %.3f %.3f\n', backup.Gr.w, backup.iter(end).w,backup.iter(end-1).w);
% %     fprintf('%.3f %.4f\n', backup.Gr.w, sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))));
%     fprintf('%.4f %.4f\n', sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))), ...
%                       sqrt(sum(sum((backup.Gr.trans - backup.hmmT).^2))));
% end;
for i = 0 : 12
    fname = sprintf('data_exp2ex_%d.mat',i);
    load(fname);
    fprintf('%f %.3f %.3f %.3f ', backup.initw, backup.Gr.w, backup.iter(end).w,backup.iter(end-1).w);
    fprintf('%.4f ', sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))));
    fprintf('%.4f %.4f\n', sqrt(sum(sum((backup.Gr.trans - backup.iter(end).T).^2))), ...
                      sqrt(sum(sum((backup.Gr.trans - backup.hmmT).^2))));
end;

%% exp 3

clc
% for i = 1 : 6
%     fname = sprintf('data_25.%d.mat',i);
%     load(fname);
%     fprintf('%.3f %.3f %.3f %.3f %.4f ', backup.Gr.w, backup.iter(end).w,backup.iter(end-1).w, ...
%         backup.Gr.w, sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))));
%     fprintf('%.4f %.4f\n', sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))), ...
%                       sqrt(sum(sum((backup.Gr.trans - backup.hmmT).^2))));
% end;
for i = 0 : 5
    fname = sprintf('data_exp3_%d.mat',i);
    load(fname);
    fprintf('%f %.3f %.3f %.3f ', backup.initw, backup.Gr.w, backup.iter(end).w,backup.iter(end-1).w);
    fprintf('%.4f ', sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))));
    fprintf('%.4f %.4f\n', sqrt(sum(sum((backup.Gr.trans - backup.iter(end).T).^2))), ...
                      sqrt(sum(sum((backup.Gr.trans - backup.hmmT).^2))));
end;

%% exp 3

clc
% for i = 1 : 6
%     fname = sprintf('data_28.%d.mat',i);
%     load(fname);
%     fprintf('%.3f %.3f %.3f %.3f %.4f ', backup.Gr.w, backup.iter(end).w,backup.iter(end-1).w, ...
%         backup.Gr.w, sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))));
%     fprintf('%.4f %.4f\n', sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))), ...
%                       sqrt(sum(sum((backup.Gr.trans - backup.hmmT).^2))));
% end;
for i = 0 : 4
    fname = sprintf('data_exp3_guess_attr_%d.mat',i);
    load(fname);
    fprintf('%f %.3f %.3f %.3f ', backup.initw, backup.Gr.w, backup.iter(end).w,backup.iter(end-1).w);
    fprintf('%.4f ', sqrt(sum(sum((backup.Gr.attr - backup.xPrior).^2))));
    fprintf('%.4f ', sqrt(sum(sum((backup.Gr.attr - backup.iter(end).x).^2))));
    fprintf('%.4f ', sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))));
    fprintf('%.4f %.4f\n', sqrt(sum(sum((backup.Gr.trans - backup.iter(end).T).^2))), ...
                      sqrt(sum(sum((backup.Gr.trans - backup.hmmT).^2))));
end;

%% exp 4

clc
for i = 1 : 6
    fname = sprintf('data_30.%d.mat',i);
    load(fname);
%     fprintf('%.3f %.3f %.3f\n', backup.Gr.w, backup.iter(end).w,backup.iter(end-1).w);
    fprintf('%.3f %.3f %.3f %.4f %.4f %.4f %.4f\n', backup.Gr.w, backup.iter(end-1).w, ...
                    backup.iter(end).w, ...
                    sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))), ...
                    sqrt(sum(sum((backup.Gr.trans - backup.iter(end).T).^2))), ...
                    sqrt(sum(sum((backup.Gr.T0 - backup.Gr.trans).^2))), ...
                    sqrt(sum(sum((backup.hmmT - backup.Gr.trans).^2))));
%     fprintf('%.4f %.4f\n', sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))), ...
%                       sqrt(sum(sum((backup.Gr.trans - backup.hmmT).^2))));
end;