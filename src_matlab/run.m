% Run experiment once
x = 20:4:26;
name_of_the_experiment = 'test2';
main(x, 0, name_of_the_experiment);

% Plot a single run
load(['../results/',name_of_the_experiment,'/results0.mat']);
plot_single_run(x, results, 0.01);

% Run another experiment
main(x, 1, name_of_the_experiment);

% Combine the results
combine_results(2, name_of_the_experiment);

% Plot all runs
load(['../results/',name_of_the_experiment,'/results_all.mat']);
plot_all_runs(x, results_all, 0.01);
