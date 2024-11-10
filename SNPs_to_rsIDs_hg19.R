##################### CONVERTING SNPs to rsIDS (GChr38/hg19) ###################################
# This process can take time, but it is optimized for a single dataset here.

# Required packages
BiocManager::install("BSgenome")
BiocManager::install("SNPlocs.Hsapiens.dbSNP155.GRCh38")

#load libraries
library(BSgenome)
library(SNPlocs.Hsapiens.dbSNP155.GRCh38)
library(GenomicRanges)
library(readxl)
library(dplyr)
library(writexl)

# Check available SNPs and genomes (optional)
available.SNPs()
available.genomes()

# Define a sample dataset
sample <- read.delim("sample_dataset.txt")  # Replace "sample_dataset" with your own dataset that you want to have rsIDs for. 

# Define chromosome range
chromosomeVec <- as.character(seq(1, 22, by = 1))

# Convert sample dataset to GRanges object
rsIDs_data <- makeGRangesFromDataFrame(
  sample,
  seqnames.field = "CHR",
  start.field = "BP",
  end.field = "BP",
  keep.extra.columns = TRUE
)

# Initialize an empty data frame to store results for the sample dataset
all_overlaps <- data.frame()

# Loop through each chromosome
for (chrom in chromosomeVec) {
  
  # Get SNPs for the current chromosome
  snps_chr <- snpsBySeqname(SNPlocs.Hsapiens.dbSNP144.GRCh37, chrom)
  
  # Filter rsIDs_data for the current chromosome only
  rsIDs_data_chr <- rsIDs_data[seqnames(rsIDs_data) == chrom]
  
  # Find overlaps between rsIDs_data_chr and snps_chr
  overlaps <- findOverlaps(query = rsIDs_data_chr, subject = snps_chr, type = "within")
  qHits <- queryHits(overlaps)
  subHits <- subjectHits(overlaps)
  
  # Extract overlapping SNPs information and store them
  overlaps_chr <- data.frame(rsIDs_data_chr[qHits,], snps_chr[subHits,])
  
  # Append results for the current chromosome to the dataset's result data frame
  all_overlaps <- rbind(all_overlaps, overlaps_chr)
}

# View results for the sample dataset
head(all_overlaps)

# Write the results to an Excel file
write_xlsx(all_overlaps, "rsIDs_sample_dataset.xlsx")

# Optional: Cross-check manually the converted rsIDS using Kaviar: https://db.systemsbiology.net/kaviar/cgi-pub/Kaviar.pl
