load_data <- function(location_of_results){

library("R.matlab")

# Location of the data
path <- getwd()
pathname <- file.path(path, location_of_results)

# Read in the results
data <- readMat(pathname)
results <- data[[1]]
x <- data[[2]]
if(length(data)==3){
  leave_out <- data[[3]]
  return(list(results,x,leave_out))
} else {
  return(list(results,x))
}

}

