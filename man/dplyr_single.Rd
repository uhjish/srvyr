% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/manip.r
\name{dplyr_single}
\alias{dplyr_single}
\alias{mutate}
\alias{mutate_}
\alias{transmute}
\alias{transmute_}
\alias{select}
\alias{select_}
\alias{rename}
\alias{rename_}
\alias{filter}
\alias{filter_}
\title{Single table verbs from dplyr}
\description{
These are data manipulation functions designed to work on \code{tbl_svy} objects.
}
\details{
\code{mutate} and \code{transmute} can add or modify variables. See
\code{\link[dplyr]{mutate}} for more details.

\code{select} and \code{rename} keep or rename variables. See
\code{\link[dplyr]{select}} for more details.

\code{filter} keeps certain observaions. See \code{\link[dplyr]{filter}}
for more details.

\code{arrange} is not implemented for \code{tbl_svy} objects. Nor are any
two table verbs such as \code{bind_rows}, \code{bind_cols} or any of the
joins (\code{full_join}, \code{left_join}, etc.). These data manipulations
may require modifications to the survey variable specifications and so
cannot be done automatically. Instead, use dplyr to perform them while the
data is still stored in data.frames.
}
