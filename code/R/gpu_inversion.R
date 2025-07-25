setwd("/research/rgs01/home/clusterHome/zqu/workshop07252025/code/")
library(gpuR)

n <- 2000
x <- matrix(rnorm(n^2), nrow = n)
mat_gpu <- gpuMatrix(x, type = "float")

# Time the inversion and store the result
gpu_time <- system.time({
  inv_gpu <- solve(mat_gpu)
})

cat(sprintf("?? GPU Inversion Time: %.2f seconds\n", gpu_time["elapsed"]))

# Write a preview to CSV
write.csv(as.matrix(inv_gpu[1:5, 1:5]), "../output/gpu_inv_head.csv", row.names = FALSE)