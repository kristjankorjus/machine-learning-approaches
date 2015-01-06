function combine_results( number_of_workers )
%combine_results combines the results of the main.m
%  

% Load one instance for size
load(['results',num2str(0),'.mat'])
results_all = zeros([size(results), number_of_workers]);

% Put all the results together
for ii = 0:number_of_workers-1
  load(['results',num2str(ii),'.mat'])
  results_all(:,:,:,ii+1) = results;
end

save('results_all.mat','results_all');

end