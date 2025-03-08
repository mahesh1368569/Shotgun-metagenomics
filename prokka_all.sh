#!/bin/bash
#SBATCH -J prokka
#SBATCH -A 191400-328288
#SBATCH -p hercules
#SBATCH -q normal
#SBATCH -N 5
#SBATCH -n 200
#SBATCH -t 44:30:00
#SBATCH -o prokka_r1.out
#SBATCH -e prokka_r1.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=dc2484@msstate.edu

prokka /work/hpc/users/dc2484/Newton_shotgun_Shadow/Trimmomatic/meta_wrap/megahit_individual/megahit_all/R1.fa --outdir /work/hpc/users/dc2484/Newton_shotgun_Shadow/prokka_out_R1 --prefix --metagenome --cpus 200