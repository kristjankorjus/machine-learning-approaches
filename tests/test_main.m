

experiment_name = 'test_eeg';
data_location = '../data/data_eeg.mat';
x_values = [20, 200];
p_value = 0.01;

cd('src_matlab');

main(data_location, experiment_name, x_values, 0, 1);
main(data_location, experiment_name, x_values, 1, 1);

combine_results(2, experiment_name)

% R:
%source("main.r")
%main("test_main_random",0.01)