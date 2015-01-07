function plot_all_runs( x, results_all )
%PLOT_ALL_RUNS Summary of this function goes here
%   Detailed explanation goes here

% Checking if the x is correct
assert(length(x) == size(results_all,3),'Input lengths do not match!')

% Figure 1 and 2
titles = {'Mean error rate', 'Mean p-value'};
options = {'-r.','-g.','-b.'};

for ii = 1:2
  figure
  hold on
  for i_pipeline = 1:3
    values = squeeze(results_all(i_pipeline,ii,:,:));
    y = mean(values,2);
    e = std(values,1,2);
    errorbar(x, y,e,options{i_pipeline})
  end
  title(titles{ii});
  xlabel('Size of the data set');
  ylabel('Average value + std error bars');
end

% Figure 3: Propotion of significant results

figure
p = 0.05;
options = {'-r.','-g.','-b.'};
hold on

for ii = 1:3
  sig = squeeze(results_all(ii, 2, :, :)) < p;
  plot(x,sum(sig,2)/size(sig,2),options{ii});
end

title(['Propotion of runs which gave significant results (p < ', ...
  num2str(p),')'])

% Axes labels
xlabel('Size of the data set');
ylabel('Propotion of significant results');

end

