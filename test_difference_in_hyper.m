%% "Is there any difference in hyper-parameters?"

%% Load data
load('data_both.mat');

%% Randomize and construct data

% Maximum number of samples
n = size(data_open,1);

% Train sample size
x = 20:2:100;

% Number of runs
m = 100;

% Results
test1_results = zeros(4,length(x),m);
params = [1,1;1,2;2,1;2,2];

% All the runs
for jj = 1:m
  % Random permutation for the data
  % rng(randi(1000,1)+worker_id);
  rng(1+jj);
  r = randperm(n);
  data_open = data_open(r,:);
  data_close = data_close(r,:);

  % Generating the data set
  data = zeros(size(data_open));
  data(1:2:n,:) = data_open(1:2:n,:);
  data(2:2:n,:) = data_close(2:2:n,:);
  classes = zeros(289,1);
  classes(2:2:289) = 1;

  % Main test with different train data sizes
  for ii = 1:length(x)
    % Different hyper_parameters
    for i_params = 1:4
      test1_results(i_params,ii,jj) = classification(data(1:x(ii),:),...
        classes(1:x(ii)),data(150:250,:), classes(150:250),params(i_params,:));
    end
  end
end

save('test1_results.mat','test1_results');

%% Plotting
% load('test1_results.mat');
% t = mean(test1_results,3);
% figure
% hold all
% for ii = 1:4
%   plot(t(ii,:))
% end