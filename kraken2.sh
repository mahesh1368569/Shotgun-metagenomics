#!/bin/bash
#SBATCH -J kraken2
#SBATCH -A 191400-328288
#SBATCH -N 1
#SBATCH -n 40
#SBATCH --array=0-28
#SBATCH -t 44:30:00
#SBATCH -o kraken.out
#SBATCH -e Kraken.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=dc2484@msstate.edu

# Assuming SLURM_ARRAY_TASK_ID starts from 0. If it starts from 1, adjust accordingly.

FILES=(/work/hpc/users/dc2484/New-Newton-Shotgun/concatenated/*.fastq.gz)

# This will select the file based on SLURM_ARRAY_TASK_ID
F=${FILES[$SLURM_ARRAY_TASK_ID]}

# Extract the base name without the path and extension
BASENAME=$(basename "$F" .fastq.gz)

# Make sure to define CONFIDENCE somewhere in your script or pass it as an argument/environment variable
CONFIDENCE=0.1  # Example value, adjust as needed

# Using $F instead of ${FASTQ} since you've stored the file path in $F
kraken2 --db /work/hpc/users/dc2484/kraken_db/krakendatabase \
  --output /work/hpc/users/dc2484/New-Newton-Shotgun/kraken_output/${BASENAME}.kraken \
  --report /work/hpc/users/dc2484/New-Newton-Shotgun/kraken_report/${BASENAME}.kreport \
  --threads 40 \
  --use-names ${F} \
  --confidence ${CONFIDENCE}

