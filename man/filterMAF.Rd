% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/filterMAF.R
\name{filterMAF}
\alias{filterMAF}
\title{Function to filter the mutations}
\usage{
filterMAF(
  mafFilePath,
  flag_genes = "default",
  save_name = NULL,
  no_filter = FALSE,
  norm_alt_max = 1,
  t_alt_min = 1,
  t_depth_min = 20,
  tumor_freq_min = 0.05,
  norm_freq_max = 0.02,
  gnomAD_AF_max = 0.001,
  AF_max = 0.001,
  ExAC_AF_max = 0.001,
  n_callers = 2,
  variant_caller = NULL
)
}
\arguments{
\item{mafFilePath}{The path of the file containing the mutation
information in the MAF format}

\item{flag_genes}{The list of genes used as flag genes}

\item{save_name}{The name of the filtered MAF object}

\item{no_filter}{Flag to filter the MAF (Default no_filter=FALSE)}

\item{norm_alt_max}{Alt norm max (Default norm_alt_max=1)}

\item{t_alt_min}{Alt t min (Default t_alt_min=1)}

\item{t_depth_min}{Depth t min (Default t_depth_min=20)}

\item{tumor_freq_min}{Tumor Frequency Minimum (Default tumor_freq_min=0.05)}

\item{norm_freq_max}{norm_freq_max (Default norm_freq_max=0.02)}

\item{gnomAD_AF_max}{gnomAD_AF_max (Default gnomAD_AF_max=0.001)}

\item{AF_max}{AF_max (Default AF_max=0.001)}

\item{ExAC_AF_max}{ExAC_AF_max (Default ExAC_AF_max=0.01)}

\item{n_callers}{n_callers (Default n_callers=2)}

\item{variant_caller}{variant_caller}
}
\value{
The filtered MAF object
}
\description{
This function filter the mutations in the MAF format using thresholds on various features
}
\examples{
library(MAFDashRPackage)
#MAFfilePath <- system.file('extdata', 'test.maf', package = 'MAFDashRPackage')
#filteredMAF <- filterMAF(mafFilePath = MAFfilePath)
}
\author{
Mayank Tondon, Ashish Jain
}
