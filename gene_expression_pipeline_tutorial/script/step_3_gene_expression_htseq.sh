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

### Import needed DIRECTORY and FILE

bam_output_DIR="../dataset/bam_file/"
gtf="../reference/mm10_ref/gencode.vM19.chr_patch_hapl_scaff.annotation.gtf"


## htseq-count count the gene expression 

for bam_file in ${bam_output_DIR}*Aligned.sortedByCoord.out.bam
do
	sample_name="$(basename -- "$bam_file")"
	sample_name=${sample_name%%Aligned.sortedByCoord.out.bam}

	echo "Count sample: ${sample_name}"

	htseq-count -f bam ${sample_name}Aligned.sortedByCoord.out.bam ${gtf}>${Gene_expression_DIR}/${sample_ID}.HTSeq 

done

