setwd("/research/rgs01/home/clusterHome/zqu/workshop07252025/code/")

# bootstrap_parallel_hpc.R

library(doParallel)
library(foreach)

# Get number of cores from LSF environment
ncores <- as.numeric(Sys.getenv("LSB_DJOB_NUMPROC", unset = 4))
cat("Running on", ncores, "cores\n")

cl <- makeCluster(ncores)
registerDoParallel(cl)

# Expensive task: matrix inversion
expensive_task <- function() {
  mat <- matrix(rnorm(1000^2), nrow = 1000)
  inv <- solve(mat)
  return(inv)
}

# Parallel block
start_parallel <- Sys.time()
results_parallel <- foreach(i = 1:10000, .combine = 'c') %dopar% {
  max(expensive_task())  # Replace with mean(), max(), sd() if needed
}
end_parallel <- Sys.time()
parallel_time <- end_parallel - start_parallel
time_value <- as.numeric(parallel_time)
time_unit <- attr(parallel_time, "units")
cat(sprintf("?? Time taken (parallel): %.2f %s\n", time_value, time_unit))

stopCluster(cl)

# Save summary results
write.csv(data.frame(index = 1:10000, max = results_parallel),
          "../output/parallel_summary.csv", row.names = FALSE)
