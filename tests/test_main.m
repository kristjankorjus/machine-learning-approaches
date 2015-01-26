

experiment_name = 'test_main_random';
data_location = '../data/data_random.mat';
x_values = 20:20:100;
p_value = 0.01;

n = 2;

cd('src_matlab');

main(data_location, experiment_name, x_values, 0, n);

combine_results(n, experiment_name)

% R:
%source("main.r")
%main("test_main_random",0.01)