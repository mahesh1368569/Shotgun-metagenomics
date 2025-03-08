#!/bin/bash
#SBATCH -J metaphlan
#SBATCH -A 191400-328288
#SBATCH -N 1
#SBATCH -n 40
#SBATCH --array=0-28
#SBATCH -t 44:30:00
#SBATCH -o metaphlan.out
#SBATCH -e metaphlan.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=dc2484@msstate.edu

#!/bin/bash

# Load necessary modules if required
# module load metaphlan

# Define the input files directory
INPUT_FILES=/work/hpc/users/dc2484/New-Newton-Shotgun/concatenated/*.fastq.gz

# Define the database path
BOWTIE2_DB=/work/hpc/users/dc2484/New-Newton-Shotgun/dbmetaphlan/

# Define the index name
INDEX=mpa_vJun23_CHOCOPhlAnSGB_202307

# Define the output directory
OUTPUT_DIR=/work/hpc/users/dc2484/New-Newton-Shotgun/metaphlan_out

# Create the output directory if it does not exist
mkdir -p "$OUTPUT_DIR"

# Process each input file sequentially
for FILE in $INPUT_FILES; do
    # Extract the base name without the path and extension
    BASENAME=$(basename "$FILE" .fastq.gz)
    
    # Run MetaPhlan for the selected file
    metaphlan --input_type fastq \
        --index "$INDEX" \
        --bowtie2db "$BOWTIE2_DB" \
        --no_map \
        -o "$OUTPUT_DIR/${BASENAME}.mpa" \
        "$FILE"
done