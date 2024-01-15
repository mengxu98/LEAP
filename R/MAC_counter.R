#' compute
#'
#' @param data data frame of gene expression data
#' @param max_lag_prop maximum lag to consider
#' @param MAC_cutoff minimum MAC value to consider
#' @param file_name name of file to write results to
#' @param lag_matrix whether to write lag matrix to file
#' @param symmetric whether to compute MACs for both symmetric and asymmetric lags
#'
#' @importFrom stats cor
#' @importFrom utils write.csv
#'
#' @return MACs and lags
#' @export
#'
#' @examples
#' library(LEAP)
#' data(example_data)
#' results <- MAC_counter(
#'   data = example_data,
#'   max_lag_prop = 1 / 3,
#'   MAC_cutoff = 0.2,
#'   lag_matrix = T
#' )
MAC_counter <- function(
    data,
    max_lag_prop = 1 / 3,
    MAC_cutoff = 0.2,
    file_name = FALSE,
    lag_matrix = TRUE,
    symmetric = FALSE) {
  results <- MAC_lags(data, max_lag_prop = max_lag_prop, symmetric = FALSE)

  results_MACs <- results[, 1:nrow(data)]
  results_lags <- results[, -(1:nrow(data))]

  # write files
  if (file_name != FALSE) {
    if (symmetric == FALSE) {
      if (lag_matrix == TRUE) {
        lag_name <- paste(c("lag_", file_name, ".csv"), sep = "", collapse = "")
        write.csv(results_lags, file = lag_name, row.names = FALSE)
      }

      MAC_name <- paste(
        c("MAC_", file_name, ".csv"),
        sep = "", collapse = ""
      )
      write.csv(results_MACs, file = MAC_name, row.names = FALSE)
    } else {
      # write files

      if (lag_matrix == TRUE) {
        lag_name <- paste(
          c("lag_symmetric_", file_name, ".csv"),
          sep = "", collapse = ""
        )
        write.csv(results_lags, file = lag_name, row.names = FALSE)
      }

      MAC_name <- paste(
        c("MAC_symmetric_", file_name, ".csv"),
        sep = "", collapse = ""
      )
      write.csv(results_MACs, file = MAC_name, row.names = FALSE)
    }
  }

  final_results <- c()

  # cors <- sort(as.matrix(abs(results_MACs)), decreasing = TRUE, na.last = NA)
  # max_cors <- cors[which(cors >= MAC_cutoff)]
  # unique_cors <- unique(max_cors)

  ind_cor <- which(abs(results_MACs) >= MAC_cutoff)
  ind_rc <- which(abs(results_MACs) >= MAC_cutoff, arr.ind = TRUE)

  data_inds <- cbind(
    abs(results_MACs[ind_cor]),
    results_MACs[ind_cor],
    results_lags[ind_cor],
    ind_rc[, 1], ind_rc[, 2]
  )

  final_results <- data_inds[order(data_inds[, 1], decreasing = TRUE), -1]

  colnames(final_results) <- c(
    "Correlation", "Lag", "Row gene index", "Column gene index"
  )

  return(final_results)
}
