%%

clc
for i = 10.1: 0.1: 11.3
    fname = sprintf('data_%.1f.mat',i);
    load(fname);
%     fprintf('%.3f %.3f %.3f\n', backup.Gr.w, backup.iter(end).w,backup.iter(end-1).w);
%     fprintf('%.3f %.4f\n', backup.Gr.w, sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))));
    fprintf('%.4f %.4f\n', sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))), ...
                      sqrt(sum(sum((backup.Gr.trans - backup.hmmT).^2))));
end;

%%

clc
for i = 1 : 7
    fname = sprintf('data_21.%d.mat',i);
    load(fname);
%     fprintf('%.3f %.3f %.3f\n', backup.Gr.w, backup.iter(end).w,backup.iter(end-1).w);
%     fprintf('%.3f %.4f\n', backup.Gr.w, sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))));
    fprintf('%.4f %.4f\n', sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))), ...
                      sqrt(sum(sum((backup.Gr.trans - backup.hmmT).^2))));
end;

%%

clc
for i = 1 : 4
    fname = sprintf('data_30.%d.mat',i);
    load(fname);
%     fprintf('%.3f %.3f %.3f\n', backup.Gr.w, backup.iter(end).w,backup.iter(end-1).w);
    fprintf('%.3f %.4f %.4f %.4f\n', backup.Gr.w, ...
                    sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))), ...
                    sqrt(sum(sum((backup.Gr.trans - backup.iter(end).T).^2))), ...
                    sqrt(sum(sum((backup.Gr.T0 - backup.iter(end).T).^2))));
%     fprintf('%.4f %.4f\n', sqrt(sum(sum((backup.Gr.trans - backup.iter(end-1).T).^2))), ...
%                       sqrt(sum(sum((backup.Gr.trans - backup.hmmT).^2))));
end;