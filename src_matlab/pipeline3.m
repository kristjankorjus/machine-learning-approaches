function [ error_rate, pvalue ] = pipeline3( data, classes, leave_out, number_of_permutations )
%PIPELINE3 Cross-validation + test
%   Result: hyper-parameters and parameters
%   Uses functions cross_validation and classification

%% Parameters

% Cross-validation parameter
k_fold = 10;

%% Pipeline

% Size of the data
n = size(data,1);

% Size of the train set
n_train = n - floor(n*leave_out);

% Splitting the data
data_train = data(1:n_train, :);
data_test = data(n_train+1:end, :);

% Splitting the classes
classes_train = classes(1:n_train);
classes_test = classes(n_train+1:end, :);

% Cross-validation
[best_hyper_parameters, partitioning] = cross_validation(data_train,...
    classes_train, k_fold);

% Classify the rest of the data
correct = classification(data_train, ...
  classes_train, data_test, classes_test, ...
	best_hyper_parameters);

% Output
% Size of the test
n_test = n - n_train;

% Error rate
error_rate = (n_test - correct) / n_test;

%% p-value

% Counting correct classifications
correct = zeros(number_of_permutations, 1);

for i_perm = 1:number_of_permutations

  % Shuffle classes within partition
  classes_train_shuffled = shuffle_within_partition(classes_train, partitioning);
  
  % Cross-validation (shuffling inside)
  best_hyper_parameters = cross_validation(data_train,...
      classes_train_shuffled, k_fold, partitioning);
    
  % Shuffle classes
  classes_test_shuffled = classes_test(randperm(length(classes_test)));

  % Classify the rest of the data
  correct(i_perm) = classification(data_train, ...
    classes_train_shuffled, data_test, classes_test_shuffled, ...
    best_hyper_parameters);

end

% Error rate
error_rate_perm = (n_test - correct) / n_test;
error_rate_perm = error_rate_perm + 0.000001 * randn(size(error_rate_perm));

pvalue = sum(error_rate_perm < error_rate) / number_of_permutations;

end

