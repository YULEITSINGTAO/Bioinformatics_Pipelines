#!/bin/bash -l

#BATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=80G
#SBATCH --time=1-00:15:00     # 1 day and 15 minutes
#SBATCH --job-name="STAR_alignment"
#SBATCH --output=./STAR_alignment.log


### A robust Bash header
#This option prevents this, by terminating the script if any command exited with a nonzero exit status.
set -e
set -u
set -o pipefail
###

### Import needed DIRECTORY and FILE
fastq_DIR="../dataset/raw_fastq/"
bam_output_DIR="../dataset/bam_file/"
genome_index="../reference/mm10_ref/genome_index/"
gtf="../reference/mm10_ref/gencode.vM19.chr_patch_hapl_scaff.annotation.gtf"


## Load the modules
module load star
## STAR 2 PASS Alignemnt

for f1 in ${fastq_DIR}*_1.fq.gz
do
	f2=${f1%%_1.fq.gz}"_2.fq.gz"
        sample_name="$(basename -- "$f1")"
        sample_name=${sample_name%%_1.fq.gz}

	echo "STAR Alignment on: ${sample_name}"
	STAR \
        --runThreadN 12 \
        --genomeDir ${genome_index} \
	--sjdbGTFfile ${gtf} \
        --readFilesIn ${f1} ${f2} \
        --quantMode GeneCounts \
        --sjdbOverhang 149 \
        --sjdbScore 2 \
        --alignIntronMax 500000 \
        --alignIntronMin 20 \
        --alignSJoverhangMin 8 \
        --alignSoftClipAtReferenceEnds Yes \
        --chimJunctionOverhangMin 15 \
        --chimMainSegmentMultNmax 1\
        --chimSegmentMin 15 \
        --alignMatesGapMax 1000000 \
        --alignSJDBoverhangMin 1 \
        --genomeLoad NoSharedMemory \
        --readFilesCommand zcat \
        --outSAMtype BAM SortedByCoordinate \
        --outSAMstrandField intronMotif \
        --outSAMattributes NH HI NM MD AS XS \
        --outSAMunmapped None \
        --outSAMmultNmax 1 \
        --outFileNamePrefix ${bam_output_DIR}/${sample_name} \
        --outFilterMultimapScoreRange 1 \
        --outFilterMultimapNmax 20 \
        --outFilterMismatchNoverLmax 0.1 \
        --outFilterMismatchNmax 10 \
        --outFilterScoreMinOverLread 0.33 \
        --outFilterMatchNminOverLread 0.33 \
        --outFilterType BySJout \
        --limitBAMsortRAM 70000000000 \
        --limitSjdbInsertNsj 2000000 \
        --twopassMode Basic

done
