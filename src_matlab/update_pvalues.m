function update_pvalues( name_of_the_experiment)
%UPDATE_PVALUES Summary of this function goes here

% Load null-distribution
load(['../results/perm/', name_of_the_experiment,'/results_all.mat'])
null_distribution = results_all;

% Load the experimental results
load(['../results/', name_of_the_experiment,'/results_all.mat'])

% Change p-values (results = pipeline * {acc, p-value} * x_value * runs )
for i_pipeline = 1:size(results_all, 1)
  for i_x = 1:size(results_all, 3)
    
    % Take a particular null-distribution
    i_null = squeeze(null_distribution(i_pipeline, 1, i_x, :));

    % Add tiny noise to make "<" operator better
    i_null = i_null + ( randn(size(i_null)) * 0.00001 );

    for i_runs = 1:size(results_all, 4)
     
      % Count more extreme values
      new_p_value = sum(results_all(i_pipeline, 1, i_x, i_runs) > i_null) / length(i_null);
      
      % Update the p-value
      results_all(i_pipeline, 2, i_x, i_runs) = new_p_value;
    end
  end
end

% Save updated results back to the same place
if exist('leave_out', 'var') == 1
  save(['../results/', name_of_the_experiment, '/results_all.mat'],...
    'results_all','x','leave_out');
else
  save(['../results/', name_of_the_experiment, '/results_all.mat'],...
    'results_all','x');
end
end

