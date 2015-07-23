function [ error_rate, pvalue ] = pipeline2( data, classes, leave_out )
%PIPELINE2 Cross-validation + cross-testing
%   Result: hyper-parameters but no parameters
%   Uses functions cross_validation and classification

%% Parameters

% Cross-validation parameter
k_fold1 = 10;

% Cross-testing
k_fold2 = 10;

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
[best_hyper_parameters, first_partitioning] = ...
  cross_validation(data_train, classes_train,k_fold1);

%% Cross-testing

% Random partitions for the cross-testing
partitions = crossvalind('Kfold', classes_test, k_fold2);

% Counting correct classifications
correct = 0;

% Cross-testing
for ii = 1:k_fold2
  
  % Indeces for test and train
  test_id = (partitions == ii);
  train_id = ~test_id;
  
  % Combining the data and classes
  data_train_combined = [data_train; data_test(train_id,:)];
  classes_train_combined = [classes_train; classes_test(train_id,:)];
  
  % Combining the classes
  data_test_temp = data_test(test_id,:);
  classes_test_temp = classes_test(test_id, :);
  
  % Classifying the data
  correct = correct + classification(data_train_combined, ...
    classes_train_combined, data_test_temp, classes_test_temp, ...
    best_hyper_parameters);
end

% Output
% Size of the test
n = n - n_train;

% Error rate
error_rate = (n - correct) / n;

%% p-value

% Permutations
number_of_permutations = 1000;

% Counting correct classifications
correct = zeros(number_of_permutations, 1);

for i_perm = 1:number_of_permutations
  i_perm
  % Cross-validation and shuffling inside of it
  best_hyper_parameters = cross_validation(data_train,...
      classes_train, k_fold1, first_partitioning);

  %% Cross-testing
  
  % Cross-testing
  for ii = 1:k_fold2

    % Indeces for test and train
    test_id = (partitions == ii);
    train_id = ~test_id;
    
    % Combining the data and classes
    data_train_combined = [data_train; data_test(train_id,:)];
    classes_train_combined = [classes_train; classes_test(train_id,:)];

    % Combining the classes
    data_test_temp = data_test(test_id,:);
    classes_test_temp = classes_test(test_id, :);
    
    % Shuffle classes
    classes_train_combined_shuffled = ...
      classes_train_combined(randperm(length(classes_train_combined)));
    classes_test_temp_shuffled = ...
      classes_test_temp(randperm(length(classes_test_temp)));

    % Classifying the data
    correct(i_perm) = correct(i_perm) + classification(data_train_combined, ...
      classes_train_combined_shuffled, data_test_temp, ...
      classes_test_temp_shuffled, best_hyper_parameters);
  end
end

error_rate_perm = (n-correct) / n;

pvalue = sum(error_rate_perm < error_rate) / number_of_permutations;

end

