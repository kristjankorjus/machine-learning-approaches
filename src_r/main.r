rm(list=ls())


# Load data

source("load_data.r")
out <- load_data("../results/test1_mnist/results_all.mat")
results <- out[[1]]
x <- out[[2]]
rm('out', 'load_data')


# Figure 1

source("figure_propotions.r")
figure_propotions(x, results, 0.001, "../figures/test1_mnist/")


# Figure 2 and 3