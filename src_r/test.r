install.packages("R.matlab")

setwd("C:/Users/Kristjan/Google Drive/Kristjan's two articles/machine-learning-pipelines/src_r")

path <- system.file("mat-files", package="R.matlab")
pathname <- file.path(path, "ABC.mat")
data <- readMat(pathname)
print(data)