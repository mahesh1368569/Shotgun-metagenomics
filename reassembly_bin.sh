#!/bin/bash

# Set the following variables to match your environment and data
READS_DIR="/work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/UNZIP_CLEAN_READS/" # Directory containing all clean read files
BINS_DIR="/work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/metawrap_binning/BIN_REFINEMENT/metawrap_50_10_bins/" # Directory containing bins
OUTPUT_DIR="/work/dc2484/Newton_shotgun_2022/Trimmomatic/meta_wrap/metawrap_binning/Bin_reassembly/" # Directory to store reassembly output

THREADS=56  # Number of threads to use
MEM=800  # Max memory to use

# Load metaWRAP module if necessary
# module load metawrap-module

# Create output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

# Find all forward read files in READS_DIR
forward_reads=(${READS_DIR}/*_1.fastq)

# Loop through each set of reads and run reassembly
for f_read in "${forward_reads[@]}"; do
    # Determine the corresponding reverse read file
    r_read="${f_read/_1.fastq/_2.fastq}"
    
    # Extract the base name for naming the output
    base_name=$(basename $f_read _1.fastq)
    
    # Define specific output directory for this set of reads
    sample_output="${OUTPUT_DIR}/${base_name}"

    # Run reassembly for each set of reads
    echo "Reassembling bins for $base_name..."
    metawrap reassemble_bins -o $sample_output -1 $f_read -2 $r_read -t $THREADS -m $MEM -c 50 -x 10 -b $BINS_DIR

    echo "Reassembly for $base_name completed!"
done

echo "All reassemblies completed!"
