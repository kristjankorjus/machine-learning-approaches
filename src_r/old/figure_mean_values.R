figure_propotions <- function(x, results, p, save_path){
  
  # Finding all the values below given p-value
  errors <- results[,1,,]
  p_values <- results[,2,,]
  
  provideDimnames(errors, sep="", base = list(c("Pipeline 1", "Pipeline 2", "Pipeline 3"), x ,NULL))
  
  data_frame<-as.data.frame.table(errors)
  names(data_frame) <- c("Pipelines", "size", "run", "value")
  
  source("summarySE.r")
  data_summary <- summarySE(data_frama, measurevar="value", groupvars=c("Pipelines","size"))
  
  # Propotion of then
  mean_errors <- t(apply(errors,c(1,2),mean))
  mean_p_values <- t(apply(p_values,c(1,2),mean))
  
  # Saving stuff into data frame
  errors_frame <- data.frame(mean_errors,t(x))
  names(errors_frame) <- c("Pipeline 1", "Pipeline 2", "Pipeline 3", "size")
  
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