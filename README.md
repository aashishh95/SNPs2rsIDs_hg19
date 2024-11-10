**README for SNP Conversion to rsIDs using GRCh38/hg19**

**Overview**
This script performs SNP (Single Nucleotide Polymorphism) conversion to rsIDs using the GRCh38/hg19 genome reference. Designed to be efficient, it processes one dataset at a time, though similar code can be extended to process multiple datasets. 
This conversion can take a few hours for large datasets due to the complexity of mapping genomic coordinates to dbSNP rsIDs.

Requirements
The script requires the following R packages:

BSgenome: For genome sequence data.
SNPlocs.Hsapiens.dbSNP144.GRCh37: Provides SNP locations for dbSNP build 144 on the GRCh37 genome reference.
GenomicRanges: For representing genomic locations.
dplyr: For data manipulation.
writexl: To export results to Excel.

**Installation**
Use BiocManager to install the required packages:
BiocManager::install("BSgenome")
BiocManager::install("SNPlocs.Hsapiens.dbSNP144.GRCh37")
install.packages("dplyr")
install.packages("writexl")

**Cross-Check and Annotation**
Manual Verification (Optional): You may cross-check the converted rsIDs using Kaviar.
Annotation: For further functional annotation, you can submit the rsIDs to SNPNexus or VEP. 

The findOverlaps function identifies matching SNPs, and this process can take a few hours depending on dataset size.
The code is set to handle autosomes (chromosomes 1-22). Adjust if sex chromosomes (X, Y) are needed.
