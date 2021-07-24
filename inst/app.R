#' User Iterface
#'
#' @description
#' Handles the main Shiny's User Interface definition.
#'
#' @section Maintainers:
#' Fazendaaa
#'
#' @author Fazendaaa
#'
#' @importFrom shiny dashboardPage
#' @importFrom RSMD headerView sidebarView bodyView
#'
#' @return The UI component
#'
#' @keywords internal
#'
ui <- shinydashboard::dashboardPage(
  RSMD::headerView(),
  RSMD::sidebarView(),
  RSMD::bodyView()
)

#' Server
#'
#' @description
#' Handles the main Shiny's server definition.
#'
#' @section Maintainers:
#' Fazendaaa
#'
#' @author Fazendaaa
#'
#' @inheritParams histogramView
#'
#' @importFrom RSMD histogramView dbView
#'
#' @return The server component
#'
#' @keywords internal
#'
server <- function(input, output, session) {
  output[['rbokeh']] <- RSMD::histogramView(input, output, session)
  output[['db']] <- RSMD::dbView(input, output, session)
}

shiny::shinyApp(ui, server)
