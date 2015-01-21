figure_fix_x <- function(leave_out, x, results, p, save_path){
  
  library("ggplot2")
  library("reshape2")
  library("ggthemes")
  
  # Finding all the values below given p-value
  p_values <- results[,2,,] < p
  
  
  # Propotion of then
  sig_values <- t(apply(p_values,c(1,2),sum)/dim(results)[4])
  
  # Saving stuff into data frame
  sig_frame <- data.frame(sig_values,t(leave_out))
  names(sig_frame) <- c("Pipeline 2 (HP)", "Pipeline 3 (HP + P)", "size")
  
  # Melting the data into long format
  data_long <- melt(sig_frame,id.vars = "size",variable.name = "Pipelines", value.name = "pipeline_value")
  
  # ggplot
  theme_set(theme_bw(base_size = 14))
  fig = ggplot(data=data_long, aes(x=size, y=pipeline_value, colour=Pipelines)) + 
    geom_path(alpha = 0.5, size = 1) + 
    geom_point(size=2) + 
    xlab("\nSize of the leave out set") +
    ylab("Propoption of  significant results\n") +
    ggtitle(paste("Propotion of runs which gave significant results (p < ", p, ")\n", sep="")) +
    theme(legend.justification=c(1,0), legend.position=c(1,0)) + 
    theme(legend.key = element_blank())
  
  # Save pdf
  dir.create(file.path(save_path))
  ggsave(paste(save_path, "figure_propoption_of_results_leave_out.pdf", sep=""),fig, width=11, height=7)
}