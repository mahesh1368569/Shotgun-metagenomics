#!/bin/bash
#SBATCH -J mega
#SBATCH -A 191400-328288
#SBATCH -p 400p48h
#SBATCH -q funded
#SBATCH -N 10
#SBATCH -n 400
#SBATCH -t 40:30:00
#SBATCH -o trim.out
#SBATCH -e trim.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=dc2484@msstate.edu
PATH=//work/hpc/users/dc2484/Newton_Shotgun_2022/extracted:$PATH

# Set the input directory
INPUT_DIR="/work/hpc/users/dc2484/Newton_Shotgun_2022/extracted/Trimmomatic"

# Set the output directory
OUTPUT_DIR="/work/hpc/users/dc2484/Newton_Shotgun_2022/extracted/Trimmomatic/output_1"

# Loop over the sample names
for sample_name in T{1..9} R{1..9} S{1..9}; do
    # Set the input and output file paths
    input_forward="${INPUT_DIR}/${sample_name}_1.fq.gz"
    input_reverse="${INPUT_DIR}/${sample_name}_2.fq.gz"
    output_forward_paired="${OUTPUT_DIR}/${sample_name}_1_paired.fq.gz"
    output_reverse_paired="${OUTPUT_DIR}/${sample_name}_2_paired.fq.gz"

    # Run Trimmomatic for quality trimming
    trimmomatic PE -phred33 "${input_forward}" "${input_reverse}" \
        "${output_forward_paired}" "${OUTPUT_DIR}/${sample_name}_forward_unpaired.fq.gz" \
        "${output_reverse_paired}" "${OUTPUT_DIR}/${sample_name}_reverse_unpaired.fq.gz" \
        LEADING:3 TRAILING:3 MINLEN:36 -threads 30
done
