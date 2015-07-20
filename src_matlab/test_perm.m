number_of_runs = 1;
total_number_of_runs = 2;


leave_out = [10, 50]/100;

experiment_name = 'eeg';
data_location = '../data/data_eeg.mat';
x_values = [20, 50];

% main(data_location, experiment_name, x_values, 0, number_of_runs)
% main(data_location, experiment_name, x_values, 1, number_of_runs)
% combine_results(total_number_of_runs, experiment_name)
% 
% main(data_location, experiment_name, x_values, 0, number_of_runs, true)
% main(data_location, experiment_name, x_values, 1, number_of_runs, true)
% combine_results(total_number_of_runs, experiment_name, true)

% experiment_name = 'eeg_fix';
% fix_x = 50;

% main2_fix_x(data_location, experiment_name, fix_x, leave_out, 0, number_of_runs)
% main2_fix_x(data_location, experiment_name, fix_x, leave_out, 1, number_of_runs)
% combine_results(total_number_of_runs,experiment_name)

% main2_fix_x(data_location, experiment_name, fix_x, leave_out, 0, number_of_runs, true)
% main2_fix_x(data_location, experiment_name, fix_x, leave_out, 1, number_of_runs, true)
% combine_results(total_number_of_runs, experiment_name, true)

update_pvalues(experiment_name)