function [ best_hyper_parameters ] = cross_validation( data,...
  classes, k_fold)
%CROSS_VALIDATION Summary of this function goes here
%   Detailed explanation goes here

% this will output the best hyperparameters
% and it will use classification

% Random Partitions for the first cross-validation
partitions = crossvalind('Kfold', size(data,1), k_fold1);

% Hyper-parameters
preprocessing = 1:2;
model = 1:2;

% Correctly classified results
correct = zeros(length(preprocessing), length(model));

for ii = 1:k_fold
  % Indeces for test and train
  test_id = (partitions == ii);
  train_id = ~test_id;
  
  for i_preprocessing = preprocessing
    for i_model = model
      correct(i_preprocessing, i_model) = ...
        correct(i_preprocessing, i_model) + ...
        classification(data(train_id), classes(train_id),...
        data(test_id), classes(test_id), [i_preprocessing, i_model]);
    end
  end
   
end

% choose the best
[best_preprocessing, best_model] = find(max(max(correct))==correct, 1);

best_hyper_parameters = [best_preprocessing, best_model];
end

