#!/bin/bash
#SBATCH -J Tophit1
#SBATCH -A 191400-328288
#SBATCH -p 200p48h
#SBATCH -q funded
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 20
#SBATCH --array 1-54
#SBATCH --mem=500G
#SBATCH -t 44:30:00
#SBATCH -o tophit1.out
#SBATCH -e tophit1.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=dc2484@msstate.edu
PATH=/work/dc2484/Newton_shotgun_2022/Trimmomatic/output_1/:$PATH

SAMPLE=$1

echo "Sample "$SAMPLE

# Set the working directory
WORK_DIR="/work/dc2484/Newton_shotgun_2022/Trimmomatic/"

forw_1=$(find $WORK_DIR -name '*_1.fq.gz' | sed -n ${SLURM_ARRAY_TASK_ID}p)
rew_2=$(find $WORK_DIR -name '*_2.fq.gz' | sed -n ${SLURM_ARRAY_TASK_ID}p)

bowtie2 --threads 4 \
        -x /work/dc2484/Newton_shotgun_2022/Trimmomatic/output_1/Assembly/final.contigs \
        -1 $forw_1 \
        -2 $rew_2 \
        --no-unal \
        -S /work/dc2484/Newton_shotgun_2022/Trimmomatic/output_1/bam_files/$SAMPLE.sam

# convert the resulting SAM file to a BAM file:
samtools view -F 4 -bS /work/dc2484/Newton_shotgun_2022/Trimmomatic/output_1/bam_files/$SAMPLE.sam > /work/dc2484/Newton_shotgun_2022/Trimmomatic/output_1/bam_files/$SAMPLE-RAW.bam

# sort and index the BAM file:
samtools sort /work/dc2484/Newton_shotgun_2022/Trimmomatic/output_1/bam_files/$SAMPLE-RAW.bam -o /work/dc2484/Newton_shotgun_2022/Trimmomatic/output_1/bam_files/$SAMPLE.bam
samtools index /work/dc2484/Newton_shotgun_2022/Trimmomatic/output_1/bam_files/$SAMPLE.bam

# remove temporary files:
rm /work/dc2484/Newton_shotgun_2022/Trimmomatic/output_1/bam_files/$SAMPLE.sam /work/dc2484/Newton_shotgun_2022/Trimmomatic/output_1/bam_files/$SAMPLE-RAW.bam
