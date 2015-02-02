main <- function(folder_name, p, data_title){

# Load data

source("load_data.r")
out <- load_data(paste("../results/", folder_name, "/results_all.mat", sep = ""))
results <- out[[1]]
x <- out[[2]]


# Figure 1

source("figures.r")
figures(x, results, p, paste("../figures/", folder_name, "/", sep = ""), folder_name, data_title)

}