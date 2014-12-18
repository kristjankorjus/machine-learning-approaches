function [ pvalue ] = pipeline1( data )
%PIPELINE1 Summary of this function goes here
%   Detailed explanation goes here

% Cross-validation parameter
k_fold1 = 10;

% Nested cross-validation
k_fold2 = 10;

% Random Partitions for the first cross-validation
partitions = crossvalind('Kfold', size(data,1), k_fold1);


% First cross-validation
for i_data = 1:k_fold1
  
  % Indeces for test and train
  test_id = (partitions == ii);
  train_id = ~test_id;
  
  % Choose the best model with CV (nested)
  best_hyper_parameters = cross_validation(data(train_id,:),...
    classes(train_id),k_fold2);

  % Classify the rest of the data
  correct = correct + classification(data(train_id,:), ...
    classes(data(train_id,:)), data(test_id),best_hyper_parameters);
end

end

