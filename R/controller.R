#' Histogram Controller
#'
#' @description
#' Adds desired the desired number of breaks to Mongos's dabase if `HAS_DB` is
#' configured then return the histogram containing the density.
#'
#' @details
#' If `HAS_DB` is not configured, it will just return the graphic. And if
#' `HAS_API` is configured, it will use it to configure the breaks values.
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
  newBreaks <- if ('TRUE' == Sys.getenv('HAS_API')) breaks else histogramModel(breaks)

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
#' If `HAS_DB` is not configured, it will just provide message saying that.
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
  if ('TRUE' == Sys.getenv('HAS_DB')) {
    return (dbFindAll())
  }

  return (list(breaks = 'Sem BD disponivel -- configure um para rodar'))
}
