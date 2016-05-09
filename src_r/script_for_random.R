source("load_data.r")
source("multiplot.r")
library("ggplot2")
library("reshape2")
library("ggthemes")
library("grid")
library("gridExtra")
library("scales")

# Plots will be saved here
plots = list(NULL, NULL, NULL, NULL)
count = 1

# Initial parameters
folder_name = 'random'
p = 0.05

title = 'Random data'
x_axes = 'Size of the data set'
y_axes = c('Average accuracy', 'Propotion of significant results')
x_tick_names = c('10%', '30%', '50%', '70%', '90%')

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
    geom_path(alpha = 0.25, size = 1) + 
    geom_point(size=2) + 
    labs(y = y_axes[ii]) + 
    scale_x_continuous(breaks=x)
  
  fig = fig + theme(legend.background = element_rect(fill=alpha('white', 0.4)))
  
  # Different for two graphs
  if (ii==1) {
    
    # Title
    fig = fig + ggtitle(title) + theme(plot.title = element_text(size = 20))
    
    # No legend, no x-axes
    fig = fig + theme(legend.position="none") + theme(axis.title.x = element_blank())
    
    # Y-axes
    fig = fig + scale_y_continuous(limits=c(0.4, 0.6), breaks=c(0.4, 0.5, 0.6))
    
  } else {
    
    # Legend
    fig = fig + theme(legend.justification=c(1,0), legend.position=c(1,0)) + 
      theme(legend.key = element_blank(), legend.text=element_text(size=8), legend.direction="vertical", legend.title=element_blank()) + theme(legend.key.height=unit(0.7,"line"))
    
    # X-axes
    fig = fig + labs(x = x_axes)
    
    # Y-axes
    fig = fig + scale_y_continuous(limits=c(0, 0.1), breaks=c(0, 0.05, 0.1))
  }
  
  # Save plot object to list
  plots[[count]] = fig
  count = count + 1

}

# Initial parameters
folder_name = 'random_fix'
p = 0.05

title = 'Random data'
x_axes = 'Size of the test set'
y_axes = c('Average accuracy', 'Propotion of significant results')

# Load data
out <- load_data(paste("../results/", folder_name, "/results_all.mat", sep = ""))
results <- out[[1]]
x <- out[[2]]
leave_out <- out[[3]]

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
  data_frame <- data.frame(sig_values,t(leave_out))
  names(data_frame) <- c("Cross-validation and cross-testing", "Cross-validation and testing", "size")
  
  # Melting the data into long format
  data_long <- melt(data_frame,id.vars = "size",variable.name = "Pipelines", value.name = "pipeline_value")
  
  # ggplot2, same for both graphs
  theme_set(theme_bw(base_size = 12))
  fig = ggplot(data=data_long, aes(x=size, y=pipeline_value, colour=Pipelines)) + 
    geom_path(alpha = 0.25, size = 1) + 
    geom_point(size=2)+
    scale_colour_manual(values=c("#00BA38", "#619CFF")) +
    labs(y = y_axes[ii]) +
    scale_x_continuous(breaks=leave_out, labels=x_tick_names)
  
  fig = fig + theme(legend.background = element_rect(fill=alpha('white', 0.4)))
  
  # Different for two graphs
  if (ii==1) {
    
    # Title
    fig = fig + ggtitle(title) + theme(plot.title = element_text(size = 20))
    
    # No legend, no x-axes
    fig = fig + theme(legend.position="none") + theme(axis.title.x = element_blank())
    
    # Y-axes
    fig = fig + scale_y_continuous(limits=c(0.4, 0.6), breaks=c(0.4, 0.5, 0.6))
    
  } else {
    
    # Legend
    fig = fig + theme(legend.justification=c(0.5,0), legend.position=c(0.5,0)) + 
      theme(legend.key = element_blank(), legend.text=element_text(size=8), legend.direction="vertical", legend.title=element_blank()) + theme(legend.key.height=unit(0.7,"line"))
    
    # X-axes
    fig = fig + labs(x = x_axes)
    
    # Y-axes
    fig = fig + scale_y_continuous(limits=c(0, 0.1), breaks=c(0, 0.05, 0.1))
  }
  
  # Save plot object to list
  plots[[count]] = fig
  count = count + 1
  
}

# File name and save to tiff
tiff("../figures/Fig8.tiff",  width=10, height=5, units="in", res = 300, compression = "lzw", type = "cairo")

# Using function from there: http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/
multiplot(plots[[1]], plots[[2]], plots[[3]], plots[[4]], cols=2)

dev.off()
