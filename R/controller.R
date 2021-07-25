#' Histogram Controller
#'
#' @description
#' Adds desired the desired number of breaks to Mongos's database.
#'
#' @section Maintainers:
#' Fazendaaa
#'
#' @author Fazendaaa
#'
#' @inheritParams histogramModel
#'
#' @examples
#' histogramController(20)
#' histogramController(200)
#' histogramController(2000)
#'
#' @return Number of breaks
#'
#' @keywords internal
#'
histogramController <- function(breaks) {
  newBreaks <- histogramModel(breaks)

  if ('TRUE' == Sys.getenv('HAS_DB')) {
    dbInsert(list(breaks = newBreaks))
  }

  return (newBreaks)
}

#' Database Controller
#'
#' @description
#' Fecthes the saved content from Mongo's Database if `HAS_DB` is set.
#'
#' @details
#' If `HAS_DB` is not configured, it will just provide message saying that. And
#' if `HAS_API` is configured, it will use it to check whether or not the values
#' contains prime numbers in it.
#'
#' @section Maintainers:
#' Fazendaaa
#'
#' @author Fazendaaa
#'
#' @examples
#' dbController()
#'
#' @return The saved content
#'
#' @keywords internal
#'
dbController <- function() {
  response <- list(breaks = 'Sem BD disponivel -- configure um para rodar')

  if ('TRUE' == Sys.getenv('HAS_DB')) {
    response <- dbFindAll()
  }
  if ('TRUE' == Sys.getenv('HAS_API')) {
    print(paste0('Does the database has primes values in it? Anwser: ',
                  hasEratosthenes(unlist(response))))
  }

  return (response)
}
