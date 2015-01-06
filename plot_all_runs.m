function plot_all_runs( ~ )
%PLOT_ALL_RUNS Summary of this function goes here
%   Detailed explanation goes here

load count.dat;
y = mean(count,2);
e = std(count,1,2);

figure
errorbar(y,e,'-r.')
hold on
errorbar(y,e,'-g.')
errorbar(y,e,'-b.')
title('Mean accuracy');

figure
errorbar(y,e,'-r.')
hold on
errorbar(y,e,'-g.')
errorbar(y,e,'-b.')
title('Proportion of significant results (p < 0.05)');

end

