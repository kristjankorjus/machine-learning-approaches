function [ error_rate, pvalue ] = pipeline3( data, labels, ...
  leave_out, number_of_permutations, k_fold )
%PIPELINE3 "Cross-validation + test"
%   Result: hyper-parameters and parameters
%   Uses functions cross_validation,  classification and 
%   shuffle_within_partition

%
% Pipeline 
%

% Sizes
n = size(data,1);
n_train = n - floor(n * leave_out);
n_test = n - n_train;

% Splitting the data and labels
data_train = data(1:n_train, :);
data_test = data(n_train+1:end, :);
labels_train = labels(1:n_train);
labels_test = labels(n_train+1:end, :);

% Cross-validation for choosing the best hyper-paramaters
[best_hyper_parameters, partitioning] = cross_validation(data_train,...
    labels_train, k_fold);

% Classify the rest of the data
correct = classification(data_train, ...
  labels_train, data_test, labels_test, ...
	best_hyper_parameters);

% Error rate (First output of the function)
error_rate = (n_test - correct) / n_test;

%
% Permutation test
%

% Number of correct classifications of all the permutations
correct = zeros(number_of_permutations, 1);

for i_perm = 1:number_of_permutations

  % Shuffle labels within each partition
  labels_train_shuffled = shuffle_within_partition(labels_train, partitioning);
  
  % Cross-validation
  best_hyper_parameters = cross_validation(data_train,...
      labels_train_shuffled, k_fold, partitioning);
    
  % Shuffle test labels
  labels_test_shuffled = labels_test(randperm(length(labels_test)));

  % Classify the rest of the data
  correct(i_perm) = classification(data_train, ...
    labels_train_shuffled, data_test, labels_test_shuffled, ...
    best_hyper_parameters);

end

% Error rate + adding noise for "<" sign
error_rate_perm = (n_test - correct) / n_test;
error_rate_perm = error_rate_perm + 0.000001 * randn(size(error_rate_perm));

pvalue = sum(error_rate_perm < error_rate) / number_of_permutations;

end

