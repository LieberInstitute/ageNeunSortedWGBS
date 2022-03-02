library("SummarizedExperiment")
library("here")
library("sessioninfo")

pd_object_path = "/dcl01/lieber/ajaffe/lab/brain-epigenomics/misc/rdas/rse_mean_meth.Rdata"
fastq_dir = here('raw-data', 'FASTQ')
out_dir = here('processed-data', '01-run_BiocMAP')

dir.create(fastq_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

load(pd_object_path, verbose = TRUE)
pd = colData(rse_mean_meth[[1]])

#   Verify file existence of all FASTQs
stopifnot(all(file.exists(pd$FASTQ_R1)))
stopifnot(all(file.exists(pd$FASTQ_R2)))

#   Symbolically link FASTQs into raw-data
new_r1 = file.path(fastq_dir, basename(pd$FASTQ_R1))
new_r2 = file.path(fastq_dir, basename(pd$FASTQ_R2))
all(file.symlink(pd$FASTQ_R1, new_r1))
all(file.symlink(pd$FASTQ_R2, new_r2))

#   Construct and write manifest
man = paste(new_r1, 0, new_r2, 0, pd$Data.ID, sep = '\t')
writeLines(man, con = file.path(out_dir, 'samples.manifest'))

session_info()
