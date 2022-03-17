#!/bin/bash
#$ -l bluejay,mem_free=25G,h_vmem=25G,h_fsize=800G
#$ -o ../../processed-data/01-run_BiocMAP/03-run_second_half_jhpce.log
#$ -e ../../processed-data/01-run_BiocMAP/03-run_second_half_jhpce.log
#$ -cwd
#$ -N run_second_half

#  Get absolute path to 'ageNeunSortedWGBS' repo
base_dir=$(git rev-parse --show-toplevel)

#  Use annotation from a local directory
ann_dir=/dcl01/lieber/ajaffe/Nick/dev/BiocMAP/ref

module load nextflow/20.01.0
export _JAVA_OPTIONS="-Xms8g -Xmx10g"

nextflow $base_dir/code/01-run_BiocMAP/BiocMAP/second_half.nf \
    --annotation "${ann_dir}" \
    --input "${base_dir}/processed-data/01-run_BiocMAP/pipeline_output" \
    --output "${base_dir}/processed-data/01-run_BiocMAP/pipeline_output" \
    -w "${base_dir}/processed-data/01-run_BiocMAP/work" \
    --sample "paired" \
    --reference "hg38" \
    --with_lambda \
    -with-report "${base_dir}/processed-data/01-run_BiocMAP/03-run_second_half_report.html" \
    -profile second_half_jhpce
