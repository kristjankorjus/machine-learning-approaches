function main( worker_id )
%MAIN running the main structure in parallel
%   

%% Load data
load('data_both.mat');

%% Randomize and construct data

% Maximum number of samples
n = size(data_open,1);

% Random permutation for the data
% rng(randi(1000,1)+worker_id);
rng(1+worker_id);
r = randperm(n);
data_open = data_open(r,:);
data_close = data_close(r,:);

% Generating the data set

data = zeros(size(data_open));
data(1:2:n,:) = data_open(1:2:n,:);
data(2:2:n,:) = data_close(2:2:n,:);
classes = zeros(289,1);
classes(2:2:289) = 1;

%% Main structure

% Range
x = 20:2:100;

% Initialization for p-values
results = zeros(3,2,length(x)); 

% Main loop
for ii = 1:length(x)
  jj = x(ii);
  [results(1, 1, ii), results(1, 2, ii)] = pipeline1(data(1:jj,:), classes(1:jj));
  [results(2, 1, ii), results(2, 2, ii)] = pipeline2(data(1:jj,:), classes(1:jj));
  [results(3, 1, ii), results(3, 2, ii)] = pipeline3(data(1:jj,:), classes(1:jj));
end

%% Plot it
%plot_single_run(x, results);

%% Saving the results
save(['results', num2str(worker_id), '.mat'], 'results');