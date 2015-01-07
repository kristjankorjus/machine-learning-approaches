% Run experiment once
x = 20:4:26;
main(x, 0);

% Plot a single run
load('results0.mat');
plot_single_run(x, results);

% Run another experiment
main(x, 1);

% Combine the results
combine_results(2);

% Plot all runs
load('results_all.mat');
plot_all_runs(x, results_all);
