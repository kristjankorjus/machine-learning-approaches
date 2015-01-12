load_data <- function(location_of_results){

library("R.matlab")

# Location of the data
path <- getwd()
pathname <- file.path(path, location_of_results)

# Read in the results
data <- readMat(pathname)
results <- data[[1]]
x <- data[[2]]

# Clear variables
rm('data','pathname','path')

# Return results and x
return(list(results,x))
}

