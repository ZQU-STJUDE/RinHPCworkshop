#!/bin/bash
#BSUB -n 1
#BSUB -q priority
#BSUB -W 00:10
#BSUB -R "rusage[mem=2048]"
#BSUB -J small_job
#BSUB -o log/output.%J.log
#BSUB -e log/error.%J.log

BASE_DIR=/research/rgs01/home/clusterHome/zqu/workshop07252025/code/

cd $BASE_DIR

module load R/4.4.0
Rscript  R/survival_analysis.R