#!/bin/bash
#SBATCH -J diamond_blastx
#SBATCH -A 191400-328288
#SBATCH -p 200p48h
#SBATCH -q funded
#SBATCH -N 1
#SBATCH -n 20
#SBATCH --array=1-28
#SBATCH -t 44:30:00
#SBATCH -o diamond.out
#SBATCH -e diamond.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=dc2484@msstate.edu
PATH=/work/dc2484/MCPB_Mahesh/16S/:$PATH

# Load Diamond module if it's not in the PATH already, adjust if necessary
# module load diamond/2.0.4

# Define directories and files
SAMPLES_DIR=/work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/Diamond_results/merged_reads/
OUTPUT_DIR=/work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/Diamond_results/blastx_output/
DATABASE=/work/dc2484/Virtual_Environments/Diamond/database/nr.dmnd

# Create an array of filenames from the samples directory
FILES=(${SAMPLES_DIR}/*.fastq.gz)
# Determine file for the current array task
FILENAME=${FILES[$SLURM_ARRAY_TASK_ID-1]}
# Define output filename
OUTFILE=${OUTPUT_DIR}/$(basename $FILENAME).daa

# Run Diamond BLASTX
diamond blastx -f 100 -d ${DATABASE} -q ${FILENAME} -o ${OUTFILE}

echo "Diamond BLASTX finished for ${FILENAME}"