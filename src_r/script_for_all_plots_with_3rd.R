source("load_data.r")
source("multiplot.r")
library("ggplot2")
library("reshape2")
library("ggthemes")
library("grid")
library("gridExtra")

folder_names = c('eeg', 'fmri', 'spikes', 'mnist', 'gen', 'random')
#folder_names = c('test_eeg', 'test_eeg', 'test_eeg', 'test_eeg', 'test_eeg', 'test_eeg')
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
    values <- results[,ii,,]
    
    # Make two different graphs
    if (ii==1){
      
      # Mean
      sig_values <- 1-t(apply(values,c(1,2),mean))
      
    } else {
      
      # Finding all the values below given p-value
      p_values <- values < p
      
      # Propotion of them
      sig_values <- t(apply(p_values,c(1,2),sum)/dim(results)[4])
      
    }
    
    # Saving stuff into data frame
    data_frame <- data.frame(sig_values,t(x))
    names(data_frame) <- c("Nested cross-validation", "Cross-testing", "Leaveout set", "size")
    
    # Melting the data into long format
    data_long <- melt(data_frame,id.vars = "size",variable.name = "Pipelines", value.name = "pipeline_value")
    
    # ggplot
    theme_set(theme_bw(base_size = 12))
    fig = ggplot(data=data_long, aes(x=size, y=pipeline_value, colour=Pipelines)) + 
      geom_path(alpha = 0.5, size = 1) + 
      geom_point(size=2) + 
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
    pdf("../figures/accuracy_with3.pdf")
  } else {
    pdf("../figures/sig_with3.pdf")
  }
  
  # Using function from there: http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/
  multiplot(plots[[1]], plots[[2]], plots[[3]], plots[[4]], plots[[5]], plots[[6]], cols=2)

  dev.off()
}

