clear
close all

load('data2.mat');
figure('units','normalized','position',[.1 .1 .4 .5])

plot(1:5, ...
        mix_read(1, (1:5)), 'o-', 'lineWidth', 2, 'MarkerSize',7)
hold on
plot(1:5, ...
        mix_write(1, (1:5)), 'o-', 'lineWidth', 2, 'MarkerSize',7)
    
set(gca,'fontsize',14)
xlabel('percentage of eventually consistent operations operations')
ylabel('average latency(ms)');
axis([1 5 0 inf]);
legend({'read', 'write'}, 'fontsize', 12);
ax = gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'0%', '25%', '50%', '75%', '100%'};
title('Effect of mixing different consistency models');
