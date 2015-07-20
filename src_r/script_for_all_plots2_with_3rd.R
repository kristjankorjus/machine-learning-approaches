source("load_data.r")
source("multiplot.r")
library("ggplot2")
library("reshape2")
library("ggthemes")
library("grid")
library("gridExtra")
library("scales")

folder_names = c('eeg_fix', 'gen_fix', 'spikes_fix', 'random_fix')
ps = c(0.01, 0.01, 0.01, 0.01)
data_titles = c('EEG', 'Generated', 'Spikes', 'Random')

# Load data
for (ii in 1:2){
  
  # Plots will be saved here
  plots = list(NULL, NULL, NULL, NULL)
  
  # All data sets
  for (i in 1:4) {
    
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
      sig_values <- 1-t(apply(values,c(1,2),mean))
      
    } else {
      
      # Finding all the values below given p-value
      p_values <- values < p
      
      # Propotion of them
      sig_values <- t(apply(p_values,c(1,2),sum)/dim(results)[4])
      
    }
    
    # Saving stuff into data frame
    data_frame <- data.frame(sig_values,t(leave_out))
    names(data_frame) <- c("Cross-validation and cross-testing", "Cross-validation and testing", "size")
    
    # Melting the data into long format
    data_long <- melt(data_frame,id.vars = "size",variable.name = "Pipelines", value.name = "pipeline_value")
    
    # ggplot
    theme_set(theme_bw(base_size = 12))
    fig = ggplot(data=data_long, aes(x=size, y=pipeline_value, colour=Pipelines)) + 
      # http://stackoverflow.com/questions/8197559/emulate-ggplot2-default-color-palette
      scale_colour_manual(values=c("#00BA38", "#619CFF")) +
      geom_path(alpha = 0.5, size = 1) + 
      geom_point(size=2) + 
      theme(legend.position="none")
    
    # Legend for the last image
    if (i == 4){
      fig = fig + theme(legend.position="bottom") + 
        theme(legend.key = element_blank(), legend.text=element_text(size=8), legend.direction="vertical", legend.title=element_text(size=8))
      fig = fig + scale_y_continuous(breaks=pretty_breaks(n=2)) + theme(legend.key.height=unit(0.7,"line"))
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
    pdf("../figures/accuracy2_with3.pdf",  width=7, height=5)
  } else {
    pdf("../figures/sig2_with3.pdf",  width=7, height=5)
  }
  
  # Using function from there: http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/
  multiplot(plots[[1]], plots[[2]], plots[[3]], plots[[4]], cols=2)

  dev.off()
}

