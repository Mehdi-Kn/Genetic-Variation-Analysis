# Load necessary libraries
# These libraries are essential for handling genomic data, performing statistical analysis, and creating plots.
library(VariantAnnotation)  # For handling VCF files, which store variant data
library(GenomicRanges)      # For working with genomic ranges (regions of the genome)
library(ggplot2)            # For visualization (creating plots)
library(dplyr)              # For data manipulation (filtering and transforming data)

# Step 1: Load the VCF file
# The VCF (Variant Call Format) file contains genetic variants (like SNPs) for multiple samples.
vcf_file <- "example_data.vcf"  # Replace with your actual VCF file path
vcf <- readVcf(vcf_file, "hg19") # Load the VCF file, assuming the genome build is hg19

# Step 2: Extract genotype information and convert to a matrix
# Genotype information (e.g., 0/0, 0/1, 1/1) indicates the genetic variation in each sample.
geno <- geno(vcf)$GT  # Extract genotype data from the VCF file
geno_matrix <- as.matrix(geno)  # Convert the genotype data to a matrix for easy manipulation

# Convert genotype calls to numeric format for statistical analysis
# 0 = homozygous reference (e.g., 0/0)
# 1 = heterozygous (e.g., 0/1)
# 2 = homozygous alternative (e.g., 1/1)
geno_numeric <- apply(geno_matrix, 2, function(gt) {
  as.numeric(factor(gt, levels = c("0/0", "0/1", "1/1"), labels = c(0, 1, 2)))
})

# Step 3: Load the phenotype data
# The phenotype data should be in a CSV file with at least two columns: sample IDs and phenotype values.
# The sample IDs should match those in the VCF file.
pheno_data <- read.csv("phenotype_data.csv")  # Replace with your actual phenotype file path
pheno <- pheno_data$phenotype  # Extract the phenotype column (e.g., disease status: 0 or 1)

# Step 4: Perform a basic association test
# We use a Chi-squared test to determine if there is a significant association between the SNP genotypes and the phenotype.
# This test is applied to each SNP across all samples.
p_values <- apply(geno_numeric, 1, function(genotype) {
  tbl <- table(genotype, pheno)  # Create a contingency table of genotype vs phenotype
  chisq.test(tbl)$p.value  # Perform Chi-squared test and return the p-value
})

# Step 5: Adjust p-values for multiple testing
# Since multiple SNPs are tested, we apply a Bonferroni correction to control the family-wise error rate.
p_adjusted <- p.adjust(p_values, method = "bonferroni")

# Step 6: Create a data frame for plotting
# This step prepares the data for visualization, including the SNP IDs and their associated p-values.
plot_data <- data.frame(
  SNP = rownames(geno_numeric),  # SNP IDs from the genotype matrix
  p_value = p_values,            # Original p-values from the Chi-squared tests
  p_adjusted = p_adjusted        # Adjusted p-values after Bonferroni correction
)

# Step 7: Plot the significant SNPs
# We filter the SNPs to include only those with a significant association after adjustment (p_adjusted < 0.05).
significant_snps <- plot_data %>% filter(p_adjusted < 0.05)

# Create a scatter plot of the significant SNPs
# The plot shows SNPs on the x-axis and the -log10(p-value) on the y-axis, making it easy to spot significant associations.
ggplot(significant_snps, aes(x = SNP, y = -log10(p_value))) +
  geom_point() +  # Add points to the plot
  theme_minimal() +  # Use a clean, minimalistic theme
  labs(title = "Significant SNPs", x = "SNP", y = "-log10(p-value)")  # Add titles and labels

# Optional: Save the plot as a PNG file
ggsave("significant_snps_plot.png")  # Save the plot to the working directory
