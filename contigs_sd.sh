#!/bin/bash
#SBATCH -J contigs
#SBATCH -A 191400-328288
#SBATCH -p 200p48h
#SBATCH -q funded
#SBATCH -N 2
#SBATCH -n 40
#SBATCH --mem=500G
#SBATCH -t 44:30:00
#SBATCH -o contig.out
#SBATCH -e contig.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=dc2484@msstate.edu
PATH=/work/dc2484/Newton_shotgun_2022/Trimmomatic/output_1/:$PATH

bowtie2-build Assembly/final.contigs.fa Assembly/final.contigs