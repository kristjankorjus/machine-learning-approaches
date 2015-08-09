function main( data_location, experiment_name, x, worker_id, n_runs )
%MAIN running the main structure in parallel

% Settings
number_of_permutations = 1000;
k_fold1 = 5;
k_fold2 = 5;

% Correct folder
result_folder = '../results/';

% Just a output
fprintf(['\n\nStart experiment: ', experiment_name, '\n\n']);

% Load data
load(data_location);

% Maximum number of samples
n = size(data_class0, 1);
f = size(data_class0, 2);

% Do many runs
for i_run = 0:n_runs-1
  
  % Randomize and construct data

  % Random permutation for the data
  rng(randi(1000,1)+worker_id);
  r = randperm(n);
  data_class0 = data_class0(r,:);
  data_class1 = data_class1(r,:);

  % Generating the data set
  data = zeros(n, f);
  data(1:2:n,:) = data_class0(1:2:n,:);
  data(2:2:n,:) = data_class1(2:2:n,:);
  classes = zeros(n,1);
  classes(2:2:n) = 1;

  % Initialization for p-values
  results = zeros(3,2,length(x)); 

  % Main loop
  for ii = 1:length(x)
    jj = x(ii);
%     [results(1, 1, ii), results(1, 2, ii)] = pipeline1(data(1:jj,:),...
%       classes(1:jj), number_of_permutations, k_fold1, k_fold2);
    results(1, 1, ii) = 1;
    results(1, 1, ii) = 1;
    [results(2, 1, ii), results(2, 2, ii)] = pipeline2(data(1:jj,:), ...
      classes(1:jj), 0.5, number_of_permutations, k_fold1, k_fold2);
    [results(3, 1, ii), results(3, 2, ii)] = pipeline3(data(1:jj,:), ...
      classes(1:jj), 0.5, number_of_permutations, k_fold1);
  end
  
  fprintf('Finished %d run out of %d (ID: %d)\n',i_run+1, n_runs, ...
      worker_id);

  % Results folder
  if ~exist([result_folder, experiment_name], 'dir')
    mkdir([result_folder, experiment_name]);
  end
  
  % Save results to the folder
  save([result_folder, experiment_name, '/results', ...
    num2str(worker_id*n_runs + i_run), '.mat'], 'results', 'x');
end