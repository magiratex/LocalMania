clear;
close all;

f = @(x) exp(.8 * x) - exp(10) * exp(-9.2*sqrt(1./x));

d1 = @(x) exp(.8 * x);
d2 = @(x) - exp(10) * exp(-9.2*sqrt(1./x));

x = 0:0.01:1.1;
y = -3:0.01:3;

figure;
hold on;

plot(x, zeros(size(x)), '-.k', 'LineWidth', 1.5, 'LineSmooth', 'on');
plot(ones(size(y)), y, '-.k', 'LineWidth', 1.5, 'LineSmooth', 'on');

l1 = plot(x, d1(x), '-.b', 'LineWidth', 2, 'LineSmooth', 'on');
l2 = plot(x, d2(x), '-.g', 'LineWidth', 2, 'LineSmooth', 'on');
l3 = plot(x, f(x), '-r', 'LineWidth', 2.5, 'LineSmooth', 'on');

xlim([0, 1.1]);
ylim([-3, 3]);

legend([l1,l2,l3], 'Positive feedback', 'Negative feedback', 'Composite feedback');


