function [ num_correct ] = classification( data_train, classes_train, ...
  data_test, classes_test, hyper_parameters )
%CLASSIFICATION outputs number of correctly classified instances
%   Given the hyper-parameters

% If PCA, do PCA
if hyper_parameters(1) == 2
  % Concatenate data
  data = [data_train; data_test];
  
  % Number of training samples
  num_train = size(data_train, 1);
  
  % Z-score
  data = zscore(data);
  
  % Data after the PCA transformation
  data_train = data(1:num_train, :);
  data_test = data(num_train+1:end, :);
end

% Train model
if hyper_parameters(2) == 1
  
  % Train model
  model = svmtrain(classes_train, data_train, ['-c ', num2str(0.01), ' -q']);

  % Predict with the model
  predictions = svmpredict(classes_test, data_test, model, ' -q');
  
elseif hyper_parameters(2) == 2
  
  % Train model
  model = svmtrain(classes_train, data_train, ['-c ', num2str(100), ' -q']);

  % Predict with the model
  predictions = svmpredict(classes_test, data_test, model, ' -q');
  
end
  
% Number of correct classifications

% Empty can happen if total dataset size is <20
if isempty(classes_test)
  num_correct = 0;
else
  cmat = confusionmat(classes_test, predictions);
  num_correct = trace(cmat);
end

end

