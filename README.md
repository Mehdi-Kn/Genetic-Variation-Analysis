# Genetic Variation Analysis Using VCF and FASTA

## Project Overview

This project aims to analyze single nucleotide polymorphisms (SNPs) from a VCF (Variant Call Format) file to identify associations with specific traits or diseases. The analysis involves reading the VCF file, performing a basic association test using a phenotype file, and visualizing significant SNPs. This project is essential for understanding the genetic basis of diseases and can contribute to personalized medicine approaches.

## Features

- **VCF File Handling:** Efficiently loads and processes genetic data from VCF files.
- **Genotype to Phenotype Association:** Performs association tests between SNP genotypes and phenotypes (e.g., disease presence).
- **Multiple Testing Correction:** Applies Bonferroni correction to control for false positives.
- **Data Visualization:** Generates plots to visualize significant SNPs.

## Requirements

- **R Version:** 4.0 or higher
- **R Packages:**
  - `VariantAnnotation` (for reading and handling VCF files)
  - `GenomicRanges` (for working with genomic data)
  - `ggplot2` (for plotting)
  - `dplyr` (for data manipulation)

## Installation

To set up this project locally, follow these steps:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Mehdi-Kn/genetic-variation-analysis.git
   ```

2. **Navigate to the project directory:**

   ```bash
   cd genetic-variation-analysis
   ```

3. **Install the required R packages:**

   You can install the required packages by running the following R commands:

   ```r
   install.packages(c("VariantAnnotation", "GenomicRanges", "ggplot2", "dplyr"))
   ```

## Data Preparation

1. **VCF File:**
   - Place your VCF file containing SNP data in the `data/` directory.
   - Example filename: `example_data.vcf`

2. **Phenotype Data:**
   - Prepare a CSV file containing phenotype data. Ensure that the sample IDs in the phenotype file match those in the VCF file.
   - Place this file in the `data/` directory.
   - Example filename: `phenotype_data.csv`
   - The CSV should have at least two columns: `sample_id` and `phenotype`.

## Usage

1. **Run the analysis:**

   Open the R script `src/main.R` and execute it. This script will:

   - Load the VCF file and phenotype data.
   - Perform a Chi-squared test to find associations between SNPs and phenotypes.
   - Apply a Bonferroni correction to p-values.
   - Plot significant SNPs.

2. **View results:**
   - The significant SNPs will be plotted and saved in the `results/` directory.
   - Example output: `results/significant_snps_plot.png`

## Example Files

- **Example VCF File:** A small example VCF file is included in the `data/` directory for testing purposes.
- **Example Phenotype File:** A corresponding example phenotype CSV file is also included.

## Results

- The results will include a plot of the significant SNPs after correction, highlighting the genetic variants most strongly associated with the phenotype.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request or open an Issue if you have any suggestions or find any bugs.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- This project utilizes the `VariantAnnotation` package for VCF handling, which is part of the Bioconductor project.
- Special thanks to the R and bioinformatics communities for their ongoing support and development of essential tools.
