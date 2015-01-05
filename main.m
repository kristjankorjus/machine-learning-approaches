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
x = 20:5:60;

% Initialization for p-values
[results1, results2, results3] = deal(zeros(2,length(x))); 

% Main loop
for ii = 1:length(x)
  jj = x(ii);
  [results1(1,ii), results1(2,ii)] = pipeline1(data(1:jj,:), classes(1:jj));
  [results2(1,ii), results2(2,ii)] = pipeline2(data(1:jj,:), classes(1:jj));
  [results3(1,ii), results3(2,ii)] = pipeline3(data(1:jj,:), classes(1:jj));
end

%% Plotting the results
figure

subplot(2,1,1);
plot(x,results1(1,:),'-r.')
hold on
plot(x,results2(1,:),'-g.')
plot(x,results3(1,:),'-b.')
title('Error rate');

subplot(2,1,2);
plot(x,results1(2,:),'-r.')
hold on
plot(x,results2(2,:),'-g.')
plot(x,results3(2,:),'-b.')
title('P-values');