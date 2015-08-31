function [ error_rate, pvalue1, pvalue2, pvalue3, pvalue4 ] = ...
  pipeline3( data, labels, ...
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
acc = correct / n_test;

%
% Permutation test
%

% Number of correct classifications of all the permutations
correct = zeros(number_of_permutations, 1);

for i_perm = 1:number_of_permutations

  % Re-shuffle the data: train and test separately
  data_train = data_train(randperm(n_train), :);
  data_test = data_test(randperm(n_test), :);
  
  % Cross-validation
  best_hyper_parameters = cross_validation(data_train,...
      labels_train, k_fold, partitioning);

  % Classify the rest of the data
  correct(i_perm) = classification(data_train, ...
    labels_train, data_test, labels_test, ...
    best_hyper_parameters);

end

% Because permutation test is discrete, we sometimes 
% adjust accuracy if its on the boarder
acc_perm = correct / n_test;
acc_perm = acc_perm';

pvalue1 = get_significance('random', acc, acc_perm, 0.05);
pvalue2 = get_significance('mid', acc, acc_perm, 0.05);
pvalue3 = get_significance('prctile2', acc, acc_perm, 0.05);
pvalue4 = get_significance('classical', acc, acc_perm, 0.05);

end

