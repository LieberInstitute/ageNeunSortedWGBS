#$ -cwd
#$ -o ../../processed-data/01-run_BiocMAP/01-make_manifest.log
#$ -e ../../processed-data/01-run_BiocMAP/01-make_manifest.log
#$ -l mf=5G,h_vmem=5G
#$ -N make_manifest

 module load conda_R/4.1.x
 Rscript 01-make_manifest.R
 