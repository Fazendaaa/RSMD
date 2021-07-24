#' Histogram Model
#'
#' @description
#' As the previous implementations had no modification to the number of breaks
#' provided by the user, this function acts just as a "identity function". But
#' if any logic related to changing this value is to be implemented, it would
#' be done right here.
#'
#' @section Maintainers:
#' Fazendaaa
#'
#' @author Fazendaaa
#'
#' @param breaks - number of breaks
#'
#' @examples
#' histogramModel(1)
#' histogramModel(10)
#' histogramModel(100)
#'
#' @return The breaks number
#'
#' @keywords internal
#'
histogramModel <- function(breaks) breaks
