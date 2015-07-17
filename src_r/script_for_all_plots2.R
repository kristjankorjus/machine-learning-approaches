source("load_data.r")
source("multiplot.r")
library("ggplot2")
library("reshape2")
library("ggthemes")
library("grid")
library("gridExtra")

folder_names = c('eeg_fix', 'fmri_fix', 'spikes_fix', 'mnist_fix', 'gen_fix', 'random_fix')
ps = c(0.01, 0.001, 0.01, 0.001, 0.01, 0.05)
data_titles = c('EEG', 'fMRI', 'Spikes', 'MNIST', 'Generated', 'Random')

# Load data
for (ii in 1:2){
  
  # Plots will be saved here
  plots = list(NULL, NULL, NULL, NULL, NULL, NULL)
  
  # All data sets
  for (i in 1:6) {
    
    # Info for one sub-graph
    folder_name = folder_names[i]
    p = ps[i]
    title = data_titles[i]

    # Load data
    out <- load_data(paste("../results/", folder_name, "/results_all.mat", sep = ""))
    results <- out[[1]]
    x <- out[[2]]
    leave_out <- out[[3]]
    
    values <- results[,ii,,]
    
    if (ii==1){
      
      # Mean
      sig_values <- 1-t(rowMeans(values))
      
    } else {
      
      # Finding all the values below given p-value
      p_values <- values < p
      
      # Propotion of them
      sig_values <- t(rowSums(p_values))/dim(values)[2]
      
    }
    
    # Saving stuff into data frame
    sig_values = as.vector(sig_values)
    leave_out = as.vector(leave_out)
    data_frame = data.frame(sig_values, leave_out)
    
    # ggplot
    
    theme_set(theme_bw(base_size = 12))
    fig = ggplot(data_frame, aes(x = leave_out, y = sig_values)) + 
      geom_path(alpha = 0.5, size = 1, colour = "#619CFF") + 
      geom_point(size=2, colour = "#619CFF") +
      theme(legend.position="none")
    
    if (i == 6){
      fig = fig + theme(legend.justification=c(1,0), legend.position=c(1,0)) + 
        theme(legend.key = element_blank())
    }
    
    # Remove axes labels
    fig = fig + theme(axis.title.x = element_blank()) + theme(axis.title.y = element_blank())
    # Add title
    fig = fig + ggtitle(title)
    
    # Save it to list
    plots[[i]] = fig

  }
  
  # File name and save to pdf
  
  if (ii == 1) {
    pdf("../figures/accuracy2.pdf")
  } else {
    pdf("../figures/sig2.pdf")
  }
  
  # Using function from there: http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/
  multiplot(plots[[1]], plots[[2]], plots[[3]], plots[[4]], plots[[5]], plots[[6]], cols=2)

  dev.off()
}

