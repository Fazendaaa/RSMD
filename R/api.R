#' Eratosthenes Sieve
#'
#' @description
#'
#' @section Maintainers:
#' Fazendaaa
#'
#' @author Fazendaaa
#'
#' @param limit - upper limit to check for
#'
#' @examples
#' \dontrun{
#'     eratosthenesSieve(1)
#'     eratosthenesSieve(10)
#'     eratosthenesSieve(100)
#' }
#'
#' @return the primes numbers up to limit
#'
#' @importFrom curl curl_fetch_memory
#'
#' @keywords internal
#'
eratosthenesSieve <- function(limit) {
  con <- if ('' == Sys.getenv('SIEVE_CON')) 'http' else Sys.getenv('SIEVE_CON')
  host <- if ('' == Sys.getenv('SIEVE_HOST')) '127.0.0.1' else Sys.getenv('SIEVE_HOST')
  request <- paste0(con, '://', host, '/sieve?limit=', limit)
  response <- rawToChar(curl_fetch_memory(request)[['content']])
  values <- gsub('\\[|\\]', '', response)
  values <- unlist(strsplit(values, ','))

  return (as.integer(values))
}
