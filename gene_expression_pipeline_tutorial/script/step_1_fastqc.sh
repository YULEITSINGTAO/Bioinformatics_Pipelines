#!/bin/bash -l

#BATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=80G
#SBATCH --time=1-00:15:00     # 1 day and 15 minutes
#SBATCH --job-name="fastqc_mice"
#SBATCH --output=./fastqc.log
#SBATCH -p intel # This is the default partition, you can use any of the following; intel, batch, highmem, gpu

### A robust Bash header
# This option prevents this, by terminating the script if any command exited with a nonzero exit status.
set -e
set -u
set -o pipefail
###

### QC Report ###

raw_fastq_DIR="../dataset/raw_fastq/"
QC_report_DIR="../dataset/QC_report/"

module load fastqc

fastqc -t 13 ${raw_fastq_DIR}*.fq.gz -o ${QC_report_DIR}


