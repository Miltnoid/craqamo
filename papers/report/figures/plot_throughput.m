clear
close all

load('throughput.mat');
figure('units','normalized','position',[.1 .1 .4 .5])

plot(1:5, ...
        throughput(1, (1:5)), 'o-', 'lineWidth', 2, 'MarkerSize',7)

    
set(gca,'fontsize',14)
xlabel('percentage of eventually consistent operations operations')
ylabel('# writes per second');
axis([1 5 200 inf]);
legend({'write'}, 'fontsize', 12);
ax = gca;
ax.XTick = [1 2 3 4 5];
ax.XTickLabel = {'0%', '25%', '50%', '75%', '100%'};
title('Effect of mixing different consistency models on the write throughput');
