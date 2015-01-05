%% Load data

% Initialization
clear
clc

load('data.mat');

% % random
% data = rand(1000,5);
% classes = zeros(1000,1);
% classes(1:2:1000) = 1;

%% Main structure

% Maximum number of samples
n = size(data,1);

% Range
x = 20:50:289;

% Initialization for p-values
[pvalue1, pvalue2, pvalue3] = deal(zeros(2,length(x))); 

% Main loop
for ii = 1:length(x)
  jj = x(ii);
  [pvalue1(1,ii), pvalue1(2,ii)] = pipeline1(data(1:jj,:), classes(1:jj));
  %pvalue2(ii) = pipeline2(data(perm(1:ii),:));
  %pvalue3(ii) = pipeline3(data(perm(1:ii),:));
end

% Plotting the results
figure

subplot(2,1,1);
plot(x,pvalue1(1,:))
title('Accuracy');

subplot(2,1,2);
plot(x,pvalue1(2,:))
title('P-values');