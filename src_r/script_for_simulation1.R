source("load_data.r")
source("multiplot.r")
library("ggplot2")
library("reshape2")
library("ggthemes")
library("grid")
library("gridExtra")
library("scales")

# Initial parameters
folder_name = 'gen'
p = 0.05

title = 'Simulated data'
x_axes = 'Size of the data set'
y_axes = c('Average accuracy', 'Propotion of significant results')

# Plots will be saved here
plots = list(NULL, NULL)

# Load data
out <- load_data(paste("../results/", folder_name, "/results_all.mat", sep = ""))
results <- out[[1]]
x <- out[[2]]

# Two graphs
for (ii in 1:2){
  
  # Data
  values <- results[,ii,,]
  
  # Accuracy graph
  if (ii==1){
    
    # Mean
    sig_values <- 1-t(apply(values,c(1,2),mean))
  
  # Propotion of significant results graph
  } else {
    
    # Finding all the values below given p-value
    p_values <- values <=  p
    
    # Propotion of them
    sig_values <- t(apply(p_values,c(1,2),sum)/dim(results)[4])
    
  }
  
  # Saving stuff into data frame
  data_frame <- data.frame(sig_values,t(x))
  names(data_frame) <- c("Nested cross-validation", "Cross-validation and cross-testing", "Cross-validation and testing", "size")
  
  # Melting the data into long format
  data_long <- melt(data_frame,id.vars = "size",variable.name = "Pipelines", value.name = "pipeline_value")
  
  # ggplot2, same for both graphs
  theme_set(theme_bw(base_size = 12))
  fig = ggplot(data=data_long, aes(x=size, y=pipeline_value, colour=Pipelines)) + 
    geom_path(alpha = 0.5, size = 1) + 
    geom_point(size=2) + 
    labs(y = y_axes[ii]) + 
    scale_x_continuous(breaks=x)
  
  # Different for two graphs
  if (ii==1) {
    
    # Title
    fig = fig + ggtitle(title) + theme(plot.title = element_text(size = 20))
    
    # No legend, no x-axes
    fig = fig + theme(legend.position="none") + theme(axis.title.x = element_blank())
    
    
  } else {
    
    # Legend
    fig = fig + theme(legend.justification=c(1,0), legend.position=c(1,0)) + 
      theme(legend.key = element_blank(), legend.text=element_text(size=8), legend.direction="vertical", legend.title=element_blank()) + theme(legend.key.height=unit(0.7,"line"))
    
    # X-axes
    fig = fig + labs(x = x_axes)
    
    # Y-axes
    fig = fig + scale_y_continuous(limits=c(0, 1))
  }
  
  # Save plot object to list
  plots[[ii]] = fig

}

# File name and save to pdf
pdf("../figures/simulated1.pdf",  width=6, height=5)

# Using function from there: http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/
multiplot(plots[[1]], plots[[2]], cols=1)

dev.off()
