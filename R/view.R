#' Histogram View
#'
#' @description
#' Handles the histogram view page.
#'
#' @section Maintainers:
#' Fazendaaa
#'
#' @author Fazendaaa
#'
#' @param input - Object containing page defined values
#' @param output - Object to write response to it
#' @param session - Session related information
#'
#' @examples
#' \dontrun{
#'    histogramView()
#' }
#'
#' @importFrom plotly renderPlotly plot_ly add_histogram add_trace layout
#'
#' @return Histogram's page
#'
#' @export
#'
histogramView <- function(input, output, session) renderPlotly({
  modfiedBreaks <- histogramController(input[['breaks']])

  dens <- stats::density(faithful$eruptions)

  plot_ly() %>%
    add_histogram(data = faithful,
                  x = ~eruptions,
                  nbinsx = modfiedBreaks,
                  histnorm = "probability density",
                  name = "Histogram",
                  marker = list(color = 'rgba(68, 68, 68, 0.5)')) %>%
    add_trace(x = dens$x,
              y = dens$y,
              type = "scatter",
              mode = "lines",
              name = "Density",
              line = list(color = 'red')) %>%
    layout(xaxis = list(title = "eruptions"),
           yaxis = list(title = "density"))
})

#' Database View
#'
#' @description
#' Handles the database view page.
#'
#' @section Maintainers:
#' Fazendaaa
#'
#' @author Fazendaaa
#'
#' @inheritParams histogramView
#'
#' @examples
#' \dontrun{
#'    dbView()
#' }
#'
#' @importFrom shiny renderTable
#'
#' @return Database's view
#'
#' @export
#'
dbView <- function(input, output, session) renderTable(dbController())

#' Header View
#'
#' @description
#' Handles the header component.
#'
#' @section Maintainers:
#' Fazendaaa
#'
#' @author Fazendaaa
#'
#' @examples
#' \dontrun{
#'    headerView()
#' }
#'
#' @importFrom shinydashboard dashboardHeader
#'
#' @return Header's component
#'
#' @export
#'
headerView <- function() dashboardHeader(title = 'RSMD demo')

#' Sidebar View
#'
#' @description
#' Handles the sidebar component.
#'
#' @section Maintainers:
#' Fazendaaa
#'
#' @author Fazendaaa
#'
#' @examples
#' \dontrun{
#'    sidebarView()
#' }
#'
#' @importFrom shinydashboard dashboardSidebar sidebarMenu menuItem
#'
#' @return Sidebars's component
#'
#' @export
#'
sidebarView <- function() dashboardSidebar(
  sidebarMenu(
    menuItem('Dashboard',
              tabName = 'dashboard',
              icon = icon('dashboard')),
    menuItem('Banco de Dados',
              tabName = 'banco_de_dados',
              icon = icon('th'))
  )
)

#' Body View
#'
#' @description
#' Handles the body component.
#'
#' @section Maintainers:
#' Fazendaaa
#'
#' @author Fazendaaa
#'
#' @examples
#' \dontrun{
#'     bodyView()
#' }
#'
#' @importFrom shiny fluidRow
#' @importFrom shinyPWA shinyPWA
#' @importFrom shinydashboard dashboardBody tabItems tabItem box
#' @importFrom plotly plotlyOutput
#'
#' @return Body's component
#'
#' @export
#'
bodyView <- function() dashboardBody(
  shinyPWA(list(
    hasIcons = TRUE,
    version = 'v1',
    shortname = 'RSMD',
    name = 'R + Shiy + Mongo + Docker',
    display = 'standalone',
    backgroundcolor = '#fdfdfd',
    themecolor = '#db4938',
    orientation = 'portrait-primary'
  )),
  tabItems(
    tabItem(tabName = 'dashboard',
      fluidRow(
        plotlyOutput('plotly',
                     width = 500,
                     height = 540),
        box(
            title = 'Controles',
            sliderInput('breaks',
                        'Número de quebras:',
                        1, 100, 20)
        )
      )
    ),
    tabItem(tabName = 'banco_de_dados',
      h2('Banco de Dados'),
      tableOutput('db')
    )
  )
)
