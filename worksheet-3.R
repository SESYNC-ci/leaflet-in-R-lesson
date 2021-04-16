# worksheet 3
# leaflet in shiny

library(shiny)

# Basic shiny app example
# Define the user interface
ui <- navbarPage(title = 'Hello, Shiny World!')

# define the server component
server <- function(input, output){}

# Create the app
shinyApp(ui = ui, server = server)


ui <- fluidPage(h1("Hello Shiny!") # add a comma when you add more
  # ...("...", height = 800)
)

# ui <- fluidPage(
#     leafletOutput("map", height = 800),
#       absolutePanel(top = 100, right = 10, draggable = TRUE,
#               ...("dateinput", "Imagery Date", value = "2018-03-28"
#                     )
# ))

server <- function(input, output) {

  # output$map <- ...({
  #   # leaflet map is defined here with tiles, initial view, and layer control options
  #   leaflet() %>%
  #     addTiles(group = "OSM") %>%
  #     addProviderTiles(..., 
  #                      group = "Modis",
  #                      # options = providerTileOptions(time = ...)) %>%
  #                      options = ...(time = "2018-01-05")) %>%
  #     setView(lng = -76.505206, lat = 38.9767231, zoom = 7) %>%
  #     addLayersControl(baseGroups = c("Modis", "OSM"),
  #                      options = layersControlOptions(collapsed = FALSE)
  #     )
  # })

}

shinyApp(ui, server)