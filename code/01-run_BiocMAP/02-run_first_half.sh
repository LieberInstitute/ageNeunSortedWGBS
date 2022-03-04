#!/bin/bash
#$ -l bluejay,mem_free=25G,h_vmem=25G,h_fsize=800G
#$ -o ../../processed-data/01-run_BiocMAP/02-run_first_half_jhpce.log
#$ -e ../../processed-data/01-run_BiocMAP/02-run_first_half_jhpce.log
#$ -cwd
#$ -N run_first_half

#  Get absolute path to 'flowRNA_WGBS' repo
base_dir=$(git rev-parse --show-toplevel)

#  Use annotation from a local directory
ann_dir=/dcl01/lieber/ajaffe/Nick/dev/BiocMAP/ref

mkdir -p ${base_dir}/processed-data/01-run_BiocMAP/pipeline_output

module load nextflow/20.01.0
export _JAVA_OPTIONS="-Xms8g -Xmx10g"

nextflow $base_dir/code/01-run_BiocMAP/BiocMAP/first_half.nf \
    --annotation "${ann_dir}" \
    -input "${base_dir}/processed-data/01-run_BiocMAP" \
    --output "${base_dir}/processed-data/01-run_BiocMAP/pipeline_output" \
    -w "${base_dir}/processed-data/01-run_BiocMAP/work" \
    --sample "paired" \
    --reference "hg38" \
    --trim_mode "force" \
    --with_lambda \
    -with-report "${base_dir}/processed-data/01-run_BiocMAP/02-run_first_half_report.html" \
    -profile first_half_jhpce
