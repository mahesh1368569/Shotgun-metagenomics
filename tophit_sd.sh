#!/bin/bash
#SBATCH -J Tophit
#SBATCH -A 191400-328288
#SBATCH -p 200p48h
#SBATCH -q funded
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 20
#SBATCH --mem=500G
#SBATCH -t 44:30:00
#SBATCH -o tophit.out
#SBATCH -e tophit.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=dc2484@msstate.edu
PATH=/work/dc2484/Newton_shotgun_2022/Trimmomatic/output_1/tophit/:$PATH

# Set the working directory
WORK_DIR="/work/dc2484/Newton_shotgun_2022/Trimmomatic/output_1/tophit/"

file=$(find $WORK_DIR -name '*.m8' | sed -n ${SLURM_ARRAY_TASK_ID}p)
python mod_uniref_pick23.py --unirefm8File R2_paired_DB_result.m8 --output_path /work/dc2484/Newton_shotgun_2022/Trimmomatic/output_1/tophit/Results/ 