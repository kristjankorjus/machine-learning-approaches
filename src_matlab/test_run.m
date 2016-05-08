data = '../data/data_gen.mat';
experiment_name = 'simulated_data_test';
x = 20:80:100;
worker_id = 0;
n_runs = 2;

% Experiment 1: changing the size of the data set
% Warning, calculation takes about 10 minutes
main(data, experiment_name, x, worker_id, n_runs );

%
% Combine results. Usually done with function combine_results
%

% Load one instance for size
result_folder = '../results/';
load([result_folder, experiment_name,'/results', num2str(0), '.mat'])
results_all = zeros([size(results), n_runs]);

% Put all the results together
for ii = 0:n_runs-1
  load([result_folder, experiment_name, '/results', num2str(ii), '.mat'])
  results_all(:,:,:,ii+1) = results;
  % delete([result_folder, experiment_name, '/results', num2str(ii), '.mat'])
end

%
% resuls_all dimensions: (pipelines, different p-values, dataset size, runs)
% Beautiful figures were done with R. Here is an example figure.
%

% Take only p-value method 'random' that was used in the paper
results_all = squeeze(results_all(:, 2, :, :));
results_all = results_all <= 0.05;
results_all = sum(results_all,3);
results_all = results_all / n_runs;

hold off
hold all
for ii = 1:3
  plot(x, results_all(ii,:));
end

legend('Nested cross-validation', ...
  'Cross-validation and cross-testing', ...
  'Cross-validation and testing');

xlabel('Size of the data');
ylabel('Proportion of significant results');
title('Test comparison of three machine learning approaches');


