% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as_survey_design.r
\name{as_survey_design}
\alias{as_survey_design}
\alias{as_survey_design.data.frame}
\alias{as_survey_design.tbl_sql}
\alias{as_survey_design.survey.design2}
\alias{as_survey_design_}
\title{Create a tbl_svy survey object using sampling design}
\usage{
as_survey_design(.data, ...)

\method{as_survey_design}{data.frame}(.data, ids = NULL, probs = NULL,
  strata = NULL, variables = NULL, fpc = NULL, nest = FALSE,
  check_strata = !nest, weights = NULL, pps = FALSE, variance = c("HT",
  "YG"), uid = NULL, ...)

\method{as_survey_design}{tbl_sql}(.data, ids = NULL, probs = NULL,
  strata = NULL, variables = NULL, fpc = NULL, nest = FALSE,
  check_strata = !nest, weights = NULL, pps = FALSE, variance = c("HT",
  "YG"), uid = NULL, ...)

\method{as_survey_design}{survey.design2}(.data, ...)

as_survey_design_(.data, ids = NULL, probs = NULL, strata = NULL,
  variables = NULL, fpc = NULL, nest = FALSE, check_strata = !nest,
  weights = NULL, pps = FALSE, variance = c("HT", "YG"), uid = NULL)
}
\arguments{
\item{.data}{A data frame (which contains the variables specified below)}

\item{...}{ignored}

\item{ids}{Variables specifying cluster ids from largest level to smallest level
(leaving the argument empty, NULL, 1, or 0 indicate no clusters).}

\item{probs}{Variables specifying cluster sampling probabilities.}

\item{strata}{Variables specifying strata.}

\item{variables}{Variables specifying variables to be included in survey.
Defaults to all variables in .data}

\item{fpc}{Variables specifying a finite population correct, see
\code{\link[survey]{svydesign}} for more details.}

\item{nest}{If \code{TRUE}, relabel cluster ids to enforce nesting within strata.}

\item{check_strata}{If \code{TRUE}, check that clusters are nested in strata.}

\item{weights}{Variables specifying weights (inverse of probability).}

\item{pps}{"brewer" to use Brewer's approximation for PPS sampling without replacement.
"overton" to use Overton's approximation. An object of class HR to use the Hartley-Rao
approximation. An object of class ppsmat to use the Horvitz-Thompson estimator.}

\item{variance}{For pps without replacement, use variance="YG" for the Yates-Grundy estimator
instead of the Horvitz-Thompson estimator}

\item{uid}{Required for databases only, variables that uniquely identify the
observations of your survey.}
}
\value{
An object of class \code{tbl_svy}
}
\description{
Create a survey object with a survey design.
}
\details{
If provided a data.frame, it is a wrapper
around \code{\link[survey]{svydesign}}. All survey variables must be included
in the data.frame itself. Variables are selected by using bare column names, or
convenience functions described in \code{\link[dplyr]{select}}.
\code{as_survey_design_} is the standard evaluation counterpart to
\code{as_survey_design}.

If provided a \code{survey.design2} object from the survey package,
it will turn it into a srvyr object, so that srvyr functions will work with it

There is also limited and experimental support for databases using dplyr's \code{tbl_sql}
objects. Not all operations are available for these objects. See
\code{vignette("databases", package = "dplyr")} for more information on setting
up databases in dplyr.
}
\examples{
# Examples from ?survey::svydesign
library(survey)
data(api)

# stratified sample
dstrata <- apistrat \%>\%
  as_survey_design(strata = stype, weights = pw)

# one-stage cluster sample
dclus1 <- apiclus1 \%>\%
  as_survey_design(dnum, weights = pw, fpc = fpc)

# two-stage cluster sample: weights computed from population sizes.
dclus2 <- apiclus2 \%>\%
  as_survey_design(c(dnum, snum), fpc = c(fpc1, fpc2))

## multistage sampling has no effect when fpc is not given, so
## these are equivalent.
dclus2wr <- apiclus2 \%>\%
  dplyr::mutate(weights = weights(dclus2)) \%>\%
  as_survey_design(c(dnum, snum), weights = weights)

dclus2wr2 <- apiclus2 \%>\%
  dplyr::mutate(weights = weights(dclus2)) \%>\%
  as_survey_design(c(dnum), weights = weights)

## syntax for stratified cluster sample
## (though the data weren't really sampled this way)
apistrat \%>\% as_survey_design(dnum, strata = stype, weights = pw,
                           nest = TRUE)

## PPS sampling without replacement
data(election)
dpps <- election_pps \%>\%
  as_survey_design(fpc = p, pps = "brewer")

## as_survey_design_ uses standard evaluation
strata_var <- "stype"
weights_var <- "pw"
dstrata2 <- apistrat \%>\%
  as_survey_design_(strata = strata_var, weights = weights_var)

}
