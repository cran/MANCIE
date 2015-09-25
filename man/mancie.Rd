\name{mancie}
\alias{mancie}
\title{ Matrix Analysis and Normalization by Concordant Information Enhancement }
\description{
  This function removes noise in the main matrix by utilizing information available from the supplementary matrix or summarized supplementary matrix. 
}
\usage{mancie(mat_main,mat_supp,cutoff1=0.5,cutoff2=0)
}
\arguments{
  \item{mat_main}{
    The main matrix or data frame. Rows are features (genes/peaks/etc) and cols are samples (conditions/replicates)
  }
  \item{mat_supp}{
    The supplementary matrix or data frame. \code{mat_supp} must have the same dimensions as \code{mat_main}
  }
  \item{cutoff1}{
    The higher cutoff. See below for explanation.
  }
  \item{cutoff2}{
    The lower cutoff. See below for explanation.
  } 
}
\details{
  If the supplementary dataset have the same genomic features on rows and samples on columns as \code{mat_main}, it can be directly fed to \code{mancie}. An example is RNA-Seq data of the same cell lines from two labs. If the supplementary dataset has different rows from \code{mat_main}. It need to be first summarized using \code{summarize_mat} to be compatible with \code{mat_main}. An example is RNA-Seq data and DNase-seq data of the same tissue types.
  
  The underlying rationale for using MANCIE is that the variation of genomic features in \code{mat_supp} are concordant with and can be used to remove noise in the variation of genomic features in \code{mat_main}.
    
  (a) If the correlation between row i of \code{mat_main} and row i of \code{mat_supp} is larger than \code{cutoff1}, the new row vector will be the first PC of the matrix formed by these two row vectors.
  (b) If the correlation is between \code{cutoff1} and \code{cutoff2}, the new row vector will be the weighted average of these two rows. The weight for row i of \code{mat_main} is 1 and the weight for row i of \code{mat_supp} is the correlation between these two row vectors.
  (c)If the correlation is smaller than \code{cutoff2}, the new row vector is the original row i of \code{mat_main}
  
  There should be a reasonable portion of rows that fall into the first and second category. If not, the user should check if the data they would like to try MANCIE on really fits the aforementioned rationale. The user may also vary the default values of \code{cutoff1} and \code{cutoff2} if they see fit. The \code{mancie} function will report percentage of rows falling into each category.
}
\value{
  A modified matrix with the same dimensions as the main matrix
}
\seealso{
  \code{\link{summarize_mat}}
}
\examples{
  data(mancie_example,package="MANCIE")
  sum_DNase=summarize_mat(exp,ann_exp,DNase,ann_DNase) 
  lev_exp=mancie(exp,sum_DNase) 
}