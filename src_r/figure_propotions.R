figure_propotions <- function(x, results, p, save_path){
  
  # Finding all the values below given p-value
  p_values <- results[,2,,] < p
  
  # Propotion of then
  sig_values <- t(apply(p_values,c(1,2),sum)/dim(results)[4])
  
  # Saving stuff into data frame
  sig_frame <- data.frame(sig_values,t(x))
  names(sig_frame) <- c("Pipeline 1", "Pipeline 2", "Pipeline 3", "size")
  
  # Melting the data into long format
  data_long <- melt(sig_frame,id.vars = "size",variable.name = "Pipelines", value.name = "pipeline_value")
  
  # ggplot
  ggplot(data=data_long, aes(x=size, y=pipeline_value, colour=Pipelines)) + 
    geom_path(alpha = 0.5, size = 1) + 
    geom_point(size=2) + 
    xlab("Size of the data set") +
    ylab("Propoption of  significant results") +
    ggtitle(paste("Propotion of runs which gave significant results (p < ", p, ")", sep=""))
  
  # Save pdf
  ggsave(paste(save_path, "figure_propoption_of_results.pdf", sep=""))
}