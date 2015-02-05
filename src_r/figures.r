figures <- function(x, results, p, save_path, folder_name, title){
  
  library("ggplot2")
  library("reshape2")
  library("ggthemes")
  
  for (ii in 1:2){
    
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
    data_frame <- data.frame(sig_values,t(x))
    names(data_frame) <- c("Pipeline 3 (None)", "Pipeline 2 (HP)", "Pipeline 1 (HP + P)", "size")
    
    # Melting the data into long format
    data_long <- melt(data_frame,id.vars = "size",variable.name = "Pipelines", value.name = "pipeline_value")
    
    # ggplot
    theme_set(theme_bw(base_size = 14))
    fig = ggplot(data=data_long, aes(x=size, y=pipeline_value, colour=Pipelines)) + 
      scale_colour_manual(values=c("#F8766D", "#00BA38", "#619CFF")) +
      geom_path(alpha = 0.5, size = 1) + 
      geom_point(size=2) + 
      theme(legend.justification=c(1,0), legend.position=c(1,0)) + 
      theme(legend.key = element_blank()) +
      xlab("\nSize of the data set")
    
    # Create dir
    dir.create(file.path(save_path))
    
    # Final titles and save results
    if (ii == 1){
      
      fig = fig + 
        ylab("Mean accuracy\n") +
        ggtitle(paste("Mean accuracy of runs (dataset = ", title, ")\n", sep=""))
      ggsave(paste(save_path, "fig_", folder_name, "_accuracy.pdf", sep=""),fig, width=11, height=7)
      
    } else {
      fig = fig +
        ylab("Propoption of  significant results\n") +
        ggtitle(paste("Propotion of runs which gave significant results (p < ", p, ", dataset = ", title, ")\n", sep=""))
      ggsave(paste(save_path, "fig_", folder_name, "_sig_", p,".pdf", sep=""),fig, width=11, height=7)
    }
  }
}