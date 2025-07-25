#!/bin/bash
#BSUB -J gpu_inv_array[1-10]          # Job array: 10 parallel jobs
#BSUB -q gpu_priority                   # Use appropriate GPU queue
#BSUB -gpu "num=1"                   # Request 1 GPU per job
#BSUB -n 1                           # 1 CPU core is enough
#BSUB -R "rusage[mem=1GB]"           # Memory per job
#BSUB -W 0:15                        # Walltime
#BSUB -o log/gpu_job_%J_%I.out      # Stdout per array task
#BSUB -e log/gpu_job_%J_%I.err      # Stderr per array task

BASE_DIR=/research/rgs01/home/clusterHome/zqu/workshop07252025/code/

cd $BASE_DIR
# Load R module (adjust version as needed)
module load R/4.1.2

# Run R script
Rscript R/gpu_inverse_job.R
