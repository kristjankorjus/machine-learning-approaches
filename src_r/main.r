main <- function(folder_name){

# Load data

source("load_data.r")
out <- load_data(paste("../results/", folder_name, "/results_all.mat", sep = ""))
results <- out[[1]]
x <- out[[2]]


# Figure 1

source("figure_propotions.r")
figure_propotions(x, results, 0.001, paste("../figures/", folder_name, "/", sep = ""))

}