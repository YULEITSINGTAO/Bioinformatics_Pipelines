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
cleaned_fastq_DIR="../dataset/cleaned_fastq/"

module load fastp

pushd ${raw_fastq_DIR} 

for f1 in *_1.fq.gz
do
	f2=${f1%%_1.fq.gz}"_2.fq.gz"
	fastp -i $f1 -I $f2 -o "trimmed_$f1" -O "trimmed_$f2"
done

popd

mv ${raw_fastq_DIR}trimmed_* ${cleaned_fastq_DIR}

