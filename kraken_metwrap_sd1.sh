#!/bin/bash
#SBATCH -J kraken_metwrap1
#SBATCH -A 191400-328288
#SBATCH -p 200p48h
#SBATCH -q funded
#SBATCH -N 8
#SBATCH -n 160
#SBATCH --mem=500G
#SBATCH -t 44:30:00
#SBATCH -o kraken_metwrap1.out
#SBATCH -e kraken_metwrap1.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=dc2484@msstate.edu
PATH=/work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/:$PATH


metawrap kraken2 -o KRAKEN1 -t 155 -s 1000000 /work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/CLEAN_READS/*.fastq