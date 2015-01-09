function main( x, worker_id, name_of_the_experiment )
%MAIN running the main structure in parallel
%  Range x = 20:4:140

%% Load data
load('../data/data_both.mat');

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

% Initialization for p-values
results = zeros(3,2,length(x)); 

% Main loop
for ii = 1:length(x)
  jj = x(ii);
  [results(1, 1, ii), results(1, 2, ii)] = pipeline1(data(1:jj,:), classes(1:jj));
  [results(2, 1, ii), results(2, 2, ii)] = pipeline2(data(1:jj,:), classes(1:jj));
  [results(3, 1, ii), results(3, 2, ii)] = pipeline3(data(1:jj,:), classes(1:jj));
  fprintf('Finished %d loop out of %d (ID: %d)\n',ii, length(x), worker_id);
end

%% Plot it
%plot_single_run(x, results);

%% Saving the results
if ~exist(['../results/',name_of_the_experiment],'dir')
  mkdir(['../results/',name_of_the_experiment])
end

save(['../results/', name_of_the_experiment, '/results', num2str(worker_id), '.mat'], 'results', 'x');