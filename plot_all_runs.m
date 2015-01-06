function plot_all_runs( results_all )
%PLOT_ALL_RUNS Summary of this function goes here
%   Detailed explanation goes here

figure
hold on
options = {'-r.','-g.','-b.'};
for i_pipeline = 1:3
  accuracy = squeeze(results_all(i_pipeline,1,:,:));
  y = mean(accuracy,2);
  e = std(accuracy,1,2);
  errorbar(y,e,options{i_pipeline})
end
title('Mean accuracy'); 

figure
hold on
options = {'-r.','-g.','-b.'};
for i_pipeline = 1:3
  accuracy = squeeze(results_all(i_pipeline,2,:,:));
  y = mean(accuracy,2);
  e = std(accuracy,1,2);
  errorbar(y,e,options{i_pipeline})
end
title('Mean p-value');

end

