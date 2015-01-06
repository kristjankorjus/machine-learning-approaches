function plot_single_run( x, results )
%PLOT_SINGLE_RUN Plotting the results
%   

% Checking if the x is correct
assert(length(x) == size(results,3),'Lengths do not match!')

% Figure 1
figure

subplot(2,1,1);
plot(x,squeeze(results(1, 1, :)),'-r.')
hold on
plot(x,squeeze(results(2, 1, :)),'-g.')
plot(x,squeeze(results(3, 1, :)),'-b.')
title('Error rate');

subplot(2,1,2);
plot(x,squeeze(results(1, 2, :)),'-r.')
hold on
plot(x,squeeze(results(2, 2, :)),'-g.')
plot(x,squeeze(results(3, 2, :)),'-b.')
title('P-values');

% Figure 2
figure
p = 0.05;
y = ones(size(x));
sig1 = squeeze(results(1, 2, :)) < p;
sig2 = squeeze(results(2, 2, :)) < p;
sig3 = squeeze(results(3, 2, :)) < p;

hold on
scatter(x(sig1),y(sig1),'filled','MarkerFaceColor','r','Marker','s')
scatter(x(sig2),y(sig2)*2,'filled','MarkerFaceColor','g','Marker','s')
scatter(x(sig3),y(sig3)*3,'filled','MarkerFaceColor','b','Marker','s')

ylim([0.5, 3.5]);
set(gca,'YTick',1:3);
set(gca,'YDir','reverse');
title('Which pipelines gave significant results (p < 0.05) ?')


end

