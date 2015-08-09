function [ error_rate, pvalue ] = pipeline1( data, labels, number_of_permutations, k_fold_outer, k_fold_inner)
%PIPELINE1 Nested-crossvalidation
%   Result: no hyper-parameters, no-parameters
%   Uses functions cross_validation and classification

% Size of the data
n = size(data,1);

% Random partitions for the first cross-validation
partitions = crossvalind('Kfold', labels, k_fold_outer);

% Counting correct classifications
correct = 0;

% Save inner partitioning
inner_partitions = cell(k_fold_outer, 1);

% First cross-validation
for ii = 1:k_fold_outer
  
  % Indeces for test and train
  test_id = (partitions == ii);
  train_id = ~test_id;
  
  % Choose the best model with CV (nested)
  [best_hyper_parameters, inner_partitions{ii}] = ...
    cross_validation(data(train_id,:), labels(train_id), k_fold_inner);

  % Classify the rest of the data using the best hyper-parameters
  correct = correct + classification(data(train_id,:), ...
    labels(train_id), data(test_id,:), labels(test_id), ...
    best_hyper_parameters);
end

% Accuracy
error_rate = (n-correct) / n;

%% p-value

% Counting correct classifications
correct = zeros(number_of_permutations, 1);

for i_perm = 1:number_of_permutations
  
  % Re-shuffle the data
  data = data(randperm(n), :);
  
  % First cross-validation
  for ii = 1:k_fold_outer

    % Indeces for test and train
    test_id = (partitions == ii);
    train_id = ~test_id;

    % Choose the best model with CV (nested)
    best_hyper_parameters = cross_validation(data(train_id,:), ...
      labels(train_id), k_fold_inner, inner_partitions{ii});

    % Classify the rest of the data using the best hyper-parameters
    correct(i_perm) = correct(i_perm) + classification(data(train_id,:), ...
      labels(train_id), data(test_id,:), labels(test_id), ...
      best_hyper_parameters);
    
  end
end

% Error rate + adding noise for "<" sign
error_rate_perm = (n - correct) / n;
%error_rate_perm = error_rate_perm + 0.000001 * randn(size(error_rate_perm));

pvalue = sum(error_rate_perm <= error_rate) / number_of_permutations;

end

