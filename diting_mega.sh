#!/bin/bash
#SBATCH -J diting_megahit
#SBATCH -A 191400-328288
#SBATCH -p 200p48h
#SBATCH -q funded
#SBATCH -N 1
#SBATCH -n 20
#SBATCH --array=0-81
#SBATCH --mem=500G
#SBATCH -t 44:30:00
#SBATCH -o diting_meg.out
#SBATCH -e diting_meg.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=dc2484@msstate.edu
PATH=/work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/:$PATH


# Define the directory where the sequence files are located
SEQ_DIR_ass="/work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/megahit_individual/megahit_all/"

S=${SEQ_DIR_ass[$SLURM_ARRAY_TASK_ID]}


clean="/work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/CLEAN_READS/"

C=${clean[$SLURM_ARRAY_TASK_ID]}

# Define the directory where the output should be saved
OUTPUT_DIR="/work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/Diting_mega/"

# Run diting
/work/dc2484/Virtual_Environments/DiTing/diting.py -r $C -a$S -o $OUTPUT_DIR -n 20