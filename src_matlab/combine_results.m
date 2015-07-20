function combine_results( number_of_workers, name_of_the_experiment )
%combine_results combines the results of the main.m
%  

% Load one instance for size
load(['../results/',name_of_the_experiment,'/results',num2str(0),'.mat'])
results_all = zeros([size(results), number_of_workers]);

% Put all the results together
for ii = 0:number_of_workers-1
  load(['../results/',name_of_the_experiment,'/results',num2str(ii),'.mat'])
  results_all(:,:,:,ii+1) = results;
  delete(['../results/',name_of_the_experiment,'/results',num2str(ii),'.mat'])
end

% Save variables
if exist('leave_out', 'var') == 1
  save(['../results/',name_of_the_experiment,'/results_all.mat'],...
    'results_all','x','leave_out');
else
  save(['../results/',name_of_the_experiment,'/results_all.mat'],...
    'results_all','x');
end
end