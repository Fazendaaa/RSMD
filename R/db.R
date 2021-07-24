#' Database Connection
#'
#' @description
#' Creates a new MongoDB's connection by reading the following environment
#' variables:
#'
#' \itemize{
#'     \item DB_URI
#'     \item DB_USERNAME
#'     \item DB_PASSWORD
#'     \item DB_HOST
#'     \item DB_PORT
#'     \item DB_NAME
#' }
#'
#' @section Maintainers:
#' Fazendaaa
#'
#' @author Fazendaaa
#'
#' @examples
#' \dontrun{
#'     dbConnection()
#' }
#'
#' @return mongo's connection object
#'
#' @importFrom mongolite mongo
#'
#' @keywords internal
#'
dbConnection <- function() {
  url <- paste0(Sys.getenv('DB_URI'), '://',
                Sys.getenv('DB_USERNAME'), ":",
                Sys.getenv('DB_PASSWORD'), "@",
                Sys.getenv('DB_HOST'), ":",
                Sys.getenv('DB_PORT'), "/")

  return (mongo(Sys.getenv('DB_NAME'), url = url))
}

#' Database Find All
#'
#' @description
#' Goes through the whole database fetching all of its content.
#'
#' @details
#' This is allowed in our case due to only using on database, collection and
#' content saved to it.
#'
#' @section Maintainers:
#' Fazendaaa
#'
#' @author Fazendaaa
#'
#' @examples
#' \dontrun{
#'    dbFindAll()
#' }
#'
#' @return The read content
#'
#' @keywords internal
#'
dbFindAll <- function() {
  connection <- dbConnection()

  if (TRUE != is.null(connection)) {
    return (connection[['find']]('{}'))
  }

  return (list())
}

#' Database Insert
#'
#' @description
#' Save content to Mongo's database.
#'
#' @inherit dbFindAll details
#'
#' @section Maintainers:
#' Fazendaaa
#'
#' @author Fazendaaa
#'
#' @param values - content to add to database.
#'
#' @examples
#' \dontrun{
#'     dbInsert(list(foo = 'bar'))
#' }
#'
#' @return The saved data
#'
#' @keywords internal
#'
dbInsert <- function(values) {
  connection <- dbConnection()

  if (TRUE != is.null(connection)) {
    return (connection[['insert']](values))
  }

  return (list())
}
