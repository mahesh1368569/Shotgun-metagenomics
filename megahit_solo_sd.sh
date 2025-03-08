#!/bin/bash
#SBATCH -J megahit_solo
#SBATCH -A 191400-328288
#SBATCH -p 200p48h
#SBATCH -q funded
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 20
#SBATCH --array=0-27
#SBATCH --mem=500G
#SBATCH -t 44:30:00
#SBATCH -o megahit_solo.out
#SBATCH -e megahit_solo.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=dc2484@msstate.edu
PATH=/work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/:$PATH

# Define the list of sample names (without the _1 and _2 suffixes)
SAMPLES=("R1" "R2" "R3" "R4" "R5" "R6" "R7" "R8" "R9" "S1" "S2" "S3" "S4" "S5" "S6" "S7" "S8" "S9" "T1" "T2" "T3" "T4" "T5" "T6" "T7" "T8" "T9")

# Get the specific sample name for this array task
SAMPLE=${SAMPLES[$SLURM_ARRAY_TASK_ID]}

# Define the directory where the sequence files are located
SEQ_DIR="/work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/CLEAN_READS/"

# Define the directory where the output should be saved
OUTPUT_DIR="/work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/megahit_individual/"

# Run MEGAHIT
megahit -1 ${SEQ_DIR}/${SAMPLE}_1.fastq -2 ${SEQ_DIR}/${SAMPLE}_2.fastq -o ${OUTPUT_DIR}/${SAMPLE}_megahit_output