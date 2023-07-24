#!/bin/bash -l

#BATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=80G
#SBATCH --time=1-00:15:00     # 1 day and 15 minutes
#SBATCH --job-name="STAR_build_reference_index"
#SBATCH --output=./build_reference.log
#SBATCH -p intel # This is the default partition, you can use any of the following; intel, batch, highmem, gpu

### A robust Bash header
# This option prevents this, by terminating the script if any command exited with a nonzero exit status.
set -e
set -u
set -o pipefail
###

### STAR build the reference Index ###
## 

Genome_DIR="../reference/mm10_ref/"

STAR --runThreadN 1 \
	--runMode genomeGenerate \
	--genomeDir $GENOMEDIR/genome_index \
	--genomeFastaFiles $GENOMEDIR/GRCm38.p6.genome.fa \
	--sjdbGTFfile $GENOMEDIR/gencode.vM19.chr_patch_hapl_scaff.annotation.gtf
