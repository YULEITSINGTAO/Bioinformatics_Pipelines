#!/bin/bash -l

#BATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=80G
#SBATCH --time=1-00:15:00     # 1 day and 15 minutes
#SBATCH --job-name="bam_to_count"
#SBATCH --output=./bam_to_count.log

### A robust Bash header
#This option prevents this, by terminating the script if any command exited with a nonzero exit status.
set -e
set -u
set -o pipefail
###

module load R

Rscript step_3_count_gene_expression_R.R


