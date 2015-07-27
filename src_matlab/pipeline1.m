function [ error_rate, pvalue ] = pipeline1( data, classes, number_of_permutations )
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
partitions = crossvalind('Kfold', classes, k_fold1);

% Counting correct classifications
correct = 0;

% Save inner partitioning
inner_partitions = {};

% First cross-validation
for ii = 1:k_fold1
  
  % Indeces for test and train
  test_id = (partitions == ii);
  train_id = ~test_id;
  
  % Choose the best model with CV (nested)
  [best_hyper_parameters, inner_partitions{ii}] = ...
    cross_validation(data(train_id,:), classes(train_id),k_fold2);

  % Classify the rest of the data using the best hyper-parameters
  correct = correct + classification(data(train_id,:), ...
    classes(train_id), data(test_id,:), classes(test_id), ...
    best_hyper_parameters);
end

% Accuracy
error_rate = (n-correct) / n;

%% p-value

% Counting correct classifications
correct = zeros(number_of_permutations, 1);

for i_perm = 1:number_of_permutations
  
  % First cross-validation
  for ii = 1:k_fold1

    % Indeces for test and train
    test_id = (partitions == ii);
    train_id = ~test_id;
    
    % Shuffle classes for inner CV loop will be done inside of CV
    % Choose the best model with CV (nested)
    best_hyper_parameters = cross_validation(data(train_id,:),...
      classes(train_id), k_fold2, inner_partitions{ii});
    
    % Shuffle classes for outer CV loop
    temp_classes = classes(test_id);
    shuffled_classes_test = temp_classes(randperm(length(temp_classes)));
    
    temp_classes = classes(train_id);
    shuffled_classes_train = temp_classes(randperm(length(temp_classes)));

    % Classify the rest of the data using the best hyper-parameters
    correct(i_perm) = correct(i_perm) + classification(data(train_id,:), ...
      shuffled_classes_train, data(test_id,:), shuffled_classes_test, ...
      best_hyper_parameters);
  end
end

error_rate_perm = (n-correct) / n;

pvalue = sum(error_rate_perm < error_rate) / number_of_permutations;

end

