clear
close all

load('data2.mat');
figure('units','normalized','position',[.1 .1 .4 .5])

plot(1:5, ...
        strong_read(1, (1:5)+offset), 'o-', 'lineWidth', 2, 'MarkerSize',7)

set(gca,'fontsize',14)
xlabel('percentage of write operations')
ylabel('average latency(ms)');
axis([1 5 0 inf]);
legend({'strongly consistent read', 'strongly consistent write', ...
        'eventually consistent read', 'eventually consistent write'}, 'fontsize', 12);
ax = gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'0%', '25%', '50%', '75%', '100%'};
title('0ms latency added');
