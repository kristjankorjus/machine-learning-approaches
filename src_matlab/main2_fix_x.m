function main2_fix_x( data_location, experiment_name, x, leave_out, ...
  worker_id, n_runs, perm )
%MAIN running the main structure in parallel

% If not said otherwise assume that its not a permutation test
if nargin < 7
  perm = false;
end

% Correct folder: analysis or permutation test?
if perm
  result_folder = '../results/perm/';
else
  result_folder = '../results/';
end

fprintf(['\n\nStart experiment: ', experiment_name, '\n\n']);

%% Load data
load(data_location);

% Maximum number of samples
n = size(data_class0, 1);
f = size(data_class0, 2);

% Do many runs
for i_run = 0:n_runs-1
  
  %% Randomize and construct data

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
  
  % If permutation test then resuffle the class labels in pair-wise manner
  if perm
    permutation = 1:n;
    for i = 1:2:n-1
      if rand(1,1) < 0.5
        temp = permutation(i+1);
        permutation(i+1) = permutation(i);
        permutation(i) = temp;
      end
    end
    classes = classes(permutation);
  end

  %% Main structure

  % Initialization for p-values
  results = zeros(2,2,length(leave_out)); 

  % Main loop
  for ii = 1:length(leave_out)
    jj = leave_out(ii);
    [results(1, 1, ii), results(1, 2, ii)] = pipeline2(data(1:x,:), ...
      classes(1:x), jj);
    [results(2, 1, ii), results(2, 2, ii)] = pipeline3(data(1:x,:), ...
      classes(1:x), jj);
  end
  
  fprintf('Finished %d run out of %d (ID: %d)\n',i_run+1, n_runs, ...
      worker_id);

  %% Saving the results
  if ~exist([result_folder, experiment_name],'dir')
    mkdir([result_folder, experiment_name]);
  end

  save([result_folder, experiment_name, '/results', ...
    num2str(worker_id*n_runs + i_run), '.mat'], 'results', 'x', 'leave_out');
end