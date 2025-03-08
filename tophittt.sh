#!/bin/bash
#SBATCH -J Mmsearch1
#SBATCH -A 191400-328288
#SBATCH -p 400p48h
#SBATCH -q funded
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 40
#SBATCH --array 1-27
#SBATCH -t 44:30:00
#SBATCH -o mmsearch1.out
#SBATCH -e mmsearch1.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=dc2484@msstate.edu
PATH=/work/hpc/users/dc2484/Newton_Shotgun_2022/extracted/Concatenated/mmseqs_m8_files:$PATH

# Set the working directory
WORK_DIR="/work/hpc/users/dc2484/Newton_Shotgun_2022/extracted/Concatenated/mmseqs_m8_files"

file=$(find $WORK_DIR -name '*.m8' | sed -n ${SLURM_ARRAY_TASK_ID}p)
python mod_uniref_pick23.py --unirefm8File $file --output_path /work/hpc/users/dc2484/Newton_Shotgun_2022/extracted/Concatenated/mmseqs_m8_files/mmseqs_U90_out_tophit 