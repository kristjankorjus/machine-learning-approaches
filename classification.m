function [ num_correct ] = classification( data_train, classes_train, ...
  data_test, classes_test, parameters )
%CLASSIFICATION Summary of this function goes here
%   Detailed explanation goes here

% this will be given hyper-parameters and it will classify
% outputs number of correct classifications

% If PCA, do PCA
if parameters(1) == 2
  
end

% Model
if parameters(2) == 1
  % Linear SVM
  
elseif parameters(2) == 2
  % Decision t
end

% Number of correct

end

