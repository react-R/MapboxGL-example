library(shiny)
library(MapboxGL)
library(reactR)
library(shinydashboard)
library(DT)

taco_joints <- data.frame(
  name = c("Tyson's Tacos", "Torchy's Tacos", "Veracruz All Natural Food Truck", "Papalote Taco House", "Tacodeli"),
  lat = c(30.309630, 30.245420, 30.257940, 30.243570, 30.258467),
  long = c(-97.715240, -97.751590, -97.726030, -97.781850, -97.787582)
)

taco_features <- apply(taco_joints, 1, function(row) {
  component("Feature", list(
    properties = list(name = row[['name']]),
    coordinates = list(row[['long']], row[['lat']])
  ))
})

ui <- dashboardPage(
  dashboardHeader(disable = TRUE),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    fluidRow(
      box(
        width = 12,
        tags$h3("The Best Tacos in Austin according to Caitlin Hudon")
      )
    ),
    fluidRow(
      box(
        width = 8,
        solidHeader = TRUE,
        MapboxGLOutput('widgetOutput')
      ),
      box(
        width = 4,
        DTOutput("taco_joints")
      )
    )
  )
)

server <- function(input, output, session) {
  output$taco_joints <- renderDT(taco_joints)
  output$widgetOutput <- renderMapboxGL(
    MapboxGL(
      React$Map(
        accessToken = "pk.eyJ1IjoiYWxhbmRpcGVydCIsImEiOiJjamUydnEzc2s2bjFhMnFwMHFna3dkZ2plIn0.3bGyNVqMXQmNLldoigHPMw",
        style = "mapbox://styles/mapbox/streets-v11",
        containerStyle = list(
          height = "500px",
          width = "100%"
        ),
        center = c(-97.7431, 30.2672),
        zoom = list(12),
        component(
          "Layer",
          append(
            list(
              type = "symbol",
              id = "marker",
              layout = list(
                `icon-image` = "restaurant-15",
                `icon-size` = 2,
                `text-field` = '{name}',
                `text-offset` = list(0,-2.5)
              )
            ),
            taco_features[input$taco_joints_rows_current]
          )
        )
      )
    )
  )
}

shinyApp(ui, server)
