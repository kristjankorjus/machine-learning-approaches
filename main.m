%% Load data

% Initialization

load('data.mat');


%% Main structure

% Maximum number of samples
n = size(data,1);

% Random permutation
perm = randperm(n);

% Initialization for p-values
[pvalue1, pvalue2, pvalue3] = deal(zeros(1,n)); 

% Main loop
for ii = 1:n
  pvalue1(ii) = pipeline1(data(perm(1:ii),:));
  pvalue2(ii) = pipeline2(data(perm(1:ii),:));
  pvalue3(ii) = pipeline3(data(perm(1:ii),:));
end
