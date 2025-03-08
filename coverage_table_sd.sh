#!/bin/bash
#SBATCH -J concot
#SBATCH -A 191400-328288
#SBATCH -p 200p48h
#SBATCH -q funded
#SBATCH -N 2
#SBATCH -n 40
#SBATCH --mem=500G
#SBATCH -t 44:30:00
#SBATCH -o concot.out
#SBATCH -e concot.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=dc2484@msstate.edu
PATH=/work/dc2484/Newton_shotgun_2022/Trimmomatic/output_1/:$PATH

python concoct_coverage_table.py contigs_10K.bed bam_files/*.bam > coverage_table.tsv