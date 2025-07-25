# gpu_inverse_job.R
setwd("/research/rgs01/home/clusterHome/zqu/workshop07252025/code/")
library(gpuR)

# Use job index as a random seed for reproducibility
job_index <- as.integer(Sys.getenv("LSB_JOBINDEX", unset = 1))
set.seed(1000 + job_index)

# Matrix size
n <- 2000

# Generate matrix and move to GPU
x <- matrix(rnorm(n^2), nrow = n)
mat_gpu <- gpuMatrix(x, type = "float")

# Time the inversion and store the result
gpu_time <- system.time({
  inv_gpu <- solve(mat_gpu)
})

cat(sprintf("Job %d ?? GPU Inversion Time: %.2f seconds\n", job_index, gpu_time["elapsed"]))

# Create output directory if not exists
dir.create("../output", showWarnings = FALSE)

# Write the 5x5 preview of inverse matrix
outfile <- sprintf("../output/gpu_inv_head_job%02d.csv", job_index)
write.csv(as.matrix(inv_gpu[1:5, 1:5]), file = outfile, row.names = FALSE)
