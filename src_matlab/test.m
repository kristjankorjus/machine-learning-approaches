% Settings
number_of_datapoints = 40;
number_of_features = 5;
number_of_runs = 500;
number_of_permutations = 200;

% Labels
labels = ones(number_of_datapoints,1);
labels(1:2:number_of_datapoints) = -1;

% Runs
error_rates = NaN(number_of_runs, 1);
pvalues = NaN(number_of_runs, 1);

for i_run = 1:number_of_runs
  
  % Data
  data = randn(number_of_datapoints , number_of_features);
  
  % Pipeline 3
  [ error_rates(i_run), pvalues(i_run) ] = ...
    pipeline3(data, labels, 0.5, number_of_permutations);
  
  % Percent of significant results
  sig_results = sum(pvalues < 0.05) / sum(~isnan(pvalues));
  disp(['Percent of significant results is ' num2str(sig_results) ' after ' num2str(i_run) ' runs.'])

end