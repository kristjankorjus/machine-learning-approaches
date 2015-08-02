% Settings
number_of_datapoints = 40;
number_of_features = 2;
number_of_runs = 20;
number_of_permutations = 100;

% Labels
labels = ones(number_of_datapoints,1);
labels(1:2:number_of_datapoints) = -1;

% Runs
error_rates = NaN(number_of_runs, 1);
pvalues = NaN(number_of_runs, 1);

for i_run = 1:number_of_runs
  
  % Data
  data = randn(number_of_datapoints , number_of_features);
  
    % Pipeline 1
  [ error_rates(i_run), pvalues(i_run) ] = ...
    pipeline1(data, labels, number_of_permutations, 5, 5);

  
%   % Pipeline 2
%   [ error_rates(i_run), pvalues(i_run) ] = ...
%     pipeline2(data, labels, 0.5, number_of_permutations, 5, 5);
  
  % Percent of significant results
  sig_results = sum(pvalues < 0.1) / sum(~isnan(pvalues));
  disp(['Percent of significant results is ' num2str(sig_results) ' after ' num2str(i_run) ' runs.'])

end