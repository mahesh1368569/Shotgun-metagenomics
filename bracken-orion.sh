#!/bin/bash
#SBATCH -J kraken2
#SBATCH -A 191400-328288
#SBATCH -N 1
#SBATCH -n 40
#SBATCH --array=0-28
#SBATCH -t 44:30:00
#SBATCH -o bracken.out
#SBATCH -e bracken.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=dc2484@msstate.edu


KREPORT_FILES=(/work/hpc/users/dc2484/New-Newton-Shotgun/kraken_report/*.kreport)

# This will select the file based on SLURM_ARRAY_TASK_ID
KREPORT_FILE=${KREPORT_FILES[$SLURM_ARRAY_TASK_ID]}

# Extract the base name without the path and extension
BASENAME=$(basename "$KREPORT_FILE" .kreport)

# Run Bracken
bracken -d /work/hpc/users/dc2484/kraken_db/krakendatabase/ \
   -i "$KREPORT_FILE" \
   -o /work/hpc/users/dc2484/New-Newton-Shotgun/bracken_out/${BASENAME}.species.bracken \
   -r 100 \
   -l S \
   -t 40




