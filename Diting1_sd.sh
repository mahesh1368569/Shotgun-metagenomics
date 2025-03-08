#!/bin/bash
#SBATCH -J diting1
#SBATCH -A 191400-328288
#SBATCH -p 200p48h
#SBATCH -q funded
#SBATCH -N 1
#SBATCH -n 1
#SBATCH --array=0-54
#SBATCH --mem=500G
#SBATCH -t 44:30:00
#SBATCH -o diting1.out
#SBATCH -e diting1.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=dc2484@msstate.edu
PATH=/work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/:$PATH

FILES=(/work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/Diting_fq_reads/*_fq)

F=${FILES[$SLURM_ARRAY_TASK_ID]}

diting.py -r $F -o /work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/DiTing_output1/ -n 20