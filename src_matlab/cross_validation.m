function [ best_hyper_parameters, partitions ] = cross_validation( data,...
  classes, k_fold, partitions)
%CROSS_VALIDATION outputs the best hyper-parameters
%   It also uses a function classification.m

% If no given partitioning then make your own.
if nargin < 4
  % Random Partitions for the first cross-validation
  partitions = crossvalind('Kfold', classes, k_fold);
end

% Hyper-parameters
preprocessing = 1:2;
model = 1:2;

% Correctly classified results
correct = zeros(length(preprocessing), length(model));

for ii = 1:k_fold
  % Indeces for test and train
  test_id = (partitions == ii);
  train_id = ~test_id;
  
  classes_train = classes(train_id);
  classes_test = classes(test_id);
  
  % For-loop for all the hyper-parameters
  for i_preprocessing = preprocessing
    for i_model = model
      correct(i_preprocessing, i_model) = ...
        correct(i_preprocessing, i_model) + ...
        classification(data(train_id,:), classes_train,...
          data(test_id,:), classes_test, ...
          [i_preprocessing, i_model]);
    end
  end
   
end

% choose the best
[best_preprocessing, best_model] = find(max(max(correct))==correct, 1);

best_hyper_parameters = [best_preprocessing, best_model];
end

