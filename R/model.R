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

#' Has Eratosthenes
#'
#' @description
#' Goes throught the given set of values and check whether or not contains any
#' prime number in it.
#'
#' @section Maintainers:
#' Fazendaaa
#'
#' @author Fazendaaa
#'
#' @param set - provide values to check for primes in it
#'
#' @examples
#' \dontrun{
#'    hasEratosthenes(1:10)
#'    hasEratosthenes(1:100)
#'    hasEratosthenes(1:1000)
#' }
#'
#' @return whether or not primes are presented
#'
#' @keywords internal
#'
hasEratosthenes <- function(set) {
  primes <- eratosthenesSieve(max(set))

  return (0 < length(intersect(set, primes)))
}
