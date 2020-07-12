library(rbokeh)
library(mongolite)
library(shiny)
library(shinyPWA)
library(shinydashboard)

# Caso não tenham sido disponibilizado, nenhuma operação com bd será feita
db <- NULL

# Verificador de usuário e senha para o bd
if ("" != Sys.getenv('DB_USERNAME') &&
    "" != Sys.getenv('DB_PASSWORD')) {
    url <- paste0("mongodb://",
                  Sys.getenv('DB_USERNAME'), ":",
                  Sys.getenv('DB_PASSWORD'), "@",
                  Sys.getenv('DB_HOST'), ":",
                  Sys.getenv('DB_PORT'), "/")
    db <- mongo("rsmd", url = url)
}

shinyPWA(list(
    
))

# "Site" em si
ui <- dashboardPage(
    dashboardHeader(title = "RSMD demo"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Dashboard",
                     tabName = "dashboard",
                     icon = icon("dashboard")),
            menuItem("Banco de Dados",
                     tabName = "banco_de_dados",
                     icon = icon("th"))
        )
    ),
    dashboardBody(
        tabItems(
            tabItem(tabName = "dashboard",
                fluidRow(
                    rbokehOutput("rbokeh",
                                 width = 500,
                                 height = 540),

                    box(
                        title = "Controles",
                        sliderInput("breaks",
                                    "Número de quebras:",
                                    1, 100, 20)
                    )
                )
            ),
            tabItem(tabName = "banco_de_dados",
                h2("Banco de Dados"),
                tableOutput('db')
            )
        )
    )
)

# Lógica feita para rodar os códigos
server <- function(input, output, session) {
    output$rbokeh <- renderRbokeh({
        if (TRUE != is.null(db)) {
            db$insert(list(breaks = input$breaks))
        }

        figure() %>% 
            ly_hist(eruptions,
                    data = faithful,
                    breaks = input$breaks,
                    freq = FALSE) %>%
            ly_density(eruptions,
                       data = faithful)
    })

    output$db <- renderTable({
        if (TRUE != is.null(db)) {
            db$find('{}')
        } else {
            list(breaks = "Sem BD disponivel -- configure um para rodar")
        }
    })
}

shinyApp(ui, server)
