main2_fix_x <- function(folder_name, p){

# Load data

source("load_data.r")
out <- load_data(paste("../results/", folder_name, "/results_all.mat", sep = ""))
results <- out[[1]]
x <- out[[2]]
leave_out <- out[[3]]


# Figure 1

source("figures_fix_x.r")
figures_fix_x(leave_out, x, results, p, paste("../figures/", folder_name, "/", sep = ""), folder_name)

}