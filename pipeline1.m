function [ error_rate, pvalue ] = pipeline1( data, classes )
%PIPELINE1 Nested-crossvalidation
%   Result: no hyper-parameters, no-parameters
%   Uses functions cross_validation and classification

% Cross-validation parameter
k_fold1 = 10;

% Nested cross-validation
k_fold2 = 10;

% Size of the data
n = size(data,1);

% Random partitions for the first cross-validation
partitions = crossvalind('Kfold', n, k_fold1);

% Counting correct classifications
correct = 0;

% First cross-validation
for ii = 1:k_fold1
  
  % Indeces for test and train
  test_id = (partitions == ii);
  train_id = ~test_id;
  
  % Choose the best model with CV (nested)
  best_hyper_parameters = cross_validation(data(train_id,:),...
    classes(train_id),k_fold2);

  % Classify the rest of the data
  correct = correct + classification(data(train_id,:), ...
    classes(train_id), data(test_id,:), classes(test_id), ...
    best_hyper_parameters);
end

% Accuracy
error_rate = (n-correct) / n;

% p-value
pvalue = binocdf(n-correct,n,0.5);

end

