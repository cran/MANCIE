\name{summarize_mat}
\alias{summarize_mat}
\title{ Summarize information in the supplementary matrix }
\description{
  Summarize information in the supplementary matrix according to physical location into a new matrix with the same dimensions as the main matrix
}
\usage{summarize_mat(mat_main,ann_main,mat_supp,ann_supp,n_limit=50,extend=100000,method="pca")
}
\arguments{
  \item{mat_main}{
    The main matrix or data frame. Rows are features (genes/peaks/etc) and cols are samples (conditions/replicates)
  }
  \item{ann_main}{
    \code{ann_main} is a data frame that contains the genomic locations of features in \code{mat_main}. It must have the same number of rows as \code{mat_main}, and must have columns named as "chr", "start" and "end".
  }
  \item{mat_supp}{
    The supplementary matrix or data frame. Rows are features (genes/peaks/etc) and cols are samples (conditions/replicates)
  }
  \item{ann_supp}{
    \code{ann_supp} os a data frame that contains the genomic locations of features in \code{mat_supp}. It must have the same number of rows as \code{mat_supp}, and must have columns named as "chr", "start" and "end".
  }
  \item{n_limit}{
    The most number of closet features in the supplemenatry matrix that can be used for summarization for each feature in the main matrix
  } 
  \item{extend}{
    The genomic features in the supplemenatry matrix that are no farther away than \code{extend} bp from the feature in question in the main matrix will be used for summarization
  }
  \item{method}{
    Which method to summarize the information in the supplementary matrix when there are >1 neighboring row vectors associated with the row vector in the main matrix. "pca" (default) or "max". In the "max" method, the row vector of these neighboring vectors with the highest correlation with the row vector in the main matrix is used. In the "pca" method, PCA is caculated for these row vectors and the first principal component is used.
  } 
}
\details{
  The main matrix and supplementary matrix must have the same columns corresponding to conditions or replicates. They have different features on rows that can be linked by physical location on genomes. The basic assumption is that one feature's variation in the main matrix is correlated with nearby feature(s)' principal variation in the supplementary matrix.
}
\value{
  A modified matrix with the same dimensions as the main matrix
}
\seealso{
  \code{\link{mancie}}
}
\examples{
  data(mancie_example,package="MANCIE")
  sum_DNase=summarize_mat(exp,ann_exp,DNase,ann_DNase) 
  lev_exp=mancie(exp,sum_DNase) 
}
