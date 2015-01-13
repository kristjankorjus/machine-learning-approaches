function [ error_rate, pvalue ] = pipeline2( data, classes )
%PIPELINE2 Cross-validation + cross-testing
%   Result: hyper-parameters but no parameters
%   Uses functions cross_validation and classification

%% Parameters

% Propotion of the leave out
leave_out = 0.5;

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
best_hyper_parameters = cross_validation(data_train,...
    classes_train,k_fold1);

%% Cross-testing

% Random partitions for the cross-testing
partitions = crossvalind('Kfold', n - n_train, k_fold2);

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

%% Output
% Size of the test
n = n - n_train;

% Error rate
error_rate = (n - correct) / n;

% p-value
pvalue = binocdf(n - correct, n, 0.5);

end

