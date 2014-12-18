function [ pvalue ] = pipeline1( data )
%PIPELINE1 Summary of this function goes here
%   Detailed explanation goes here

% Nested Cross-Validation

preprocessing = 1:2;
model = 1:2;
results = zeros(length(preprocessing), length(model));

for i_preprocessing = preprocessing
  for i_model = model
    results(i_preprocessing, i_model) = ml(data, i_preprocessing, i_model);
  end
end

% Cross-Validation

end

