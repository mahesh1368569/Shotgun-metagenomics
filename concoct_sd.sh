#!/bin/bash
#SBATCH -J concot
#SBATCH -A 191400-328288
#SBATCH -p 200p48h
#SBATCH -q funded
#SBATCH -N 8
#SBATCH -n 160
#SBATCH --mem=500G
#SBATCH -t 44:30:00
#SBATCH -o concoct.out
#SBATCH -e concoct.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=dc2484@msstate.edu
PATH=/work/dc2484/Newton_shotgun_2022/Trimmomatic/output_1/:$PATH

concoct --composition_file contigs_10K.fa --coverage_file coverage_table.tsv -b concoct_output/ --threads 160