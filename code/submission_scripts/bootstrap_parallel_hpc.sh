#!/bin/bash
#BSUB -n 10
#BSUB -R "span[hosts=1]"
#BSUB -q priority
#BSUB -W 00:30
#BSUB -R "rusage[mem=2GB]"
#BSUB -J parallel_bootstrap_10000
#BSUB -o log/output.%J.log
#BSUB -e log/error.%J.log

BASE_DIR=/research/rgs01/home/clusterHome/zqu/workshop07252025/code/

cd $BASE_DIR

module load R/4.4.0
Rscript  R/bootstrap_parallel_hpc.R