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
  
  % Clearing the data
  clear('data_train', 'data_test');
  
  % Performing PCA
  [~, score, eigen] = princomp(data, 'econ');

  % Calculating cumulative variance
  cum_eigen = cumsum(eigen) / sum(eigen);

  % Choosing the number of dimensions by cumulative variance
  max_id = find(cum_eigen > 0.7, 1);
  
  % Data after the PCA transformation
  data_train = score(1:num_train, 1:max_id);
  data_test = score(num_train+1:end, 1:max_id);
end

% Train model
if hyper_parameters(2) == 1
  
  % Train with the SVM classifier
  try
    model = svmtrain(data_train, classes_train);
  catch
    model = svmtrain(data_train, classes_train, 'kktviolationlevel', 0.2);
  end
  
  %model = ClassificationTree.fit(data_train, classes_train);
  
  % Predict with the model
  predictions = svmclassify(model, data_test);
  %predictions = model.predict(data_test);
  
elseif hyper_parameters(2) == 2
  
  % Train with the 1-NN classifier
  model = ClassificationKNN.fit(data_train, classes_train, ...
    'NumNeighbors',1);
  
  % Predict with the model
  predictions = model.predict(data_test);
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

