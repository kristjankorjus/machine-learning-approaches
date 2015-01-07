function [ error_rate, pvalue ] = pipeline3( data, classes )
%PIPELINE3 Cross-validation + final test
%   Result: hyper-parameters and parameters
%   Uses functions cross_validation and classification

%% Parameters

% Propotion of the leave out
leave_out = 0.5;

% Cross-validation parameter
k_fold = 10;

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
    classes_train,k_fold);

% Classify the rest of the data
correct = classification(data_train, ...
  classes_train, data_test, classes_test, ...
	best_hyper_parameters);

%% Output
% Size of the test
n = n - n_train;

% Accuracy
error_rate = (n - correct) / n;

% p-value
pvalue = binocdf(n-correct,n,0.5);

end

