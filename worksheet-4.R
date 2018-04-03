# worksheet 4
# leaflet in shiny with leaflet proxy

library(shiny)
library(RColorBrewer)

ui <- fluidPage(
  leafletOutput("map", height = 800),
  absolutePanel(top = 10, right = 10, draggable = TRUE,
                selectInput(inputId = "colors",
                            label = "Color Scheme",
                            choices = row.names(brewer.pal.info))
  ))

server <- function(input, output) {

  output$map <- renderLeaflet({
    
    pal <- ...(input$colors, wbd_reg2$AREA)

    leaflet() %>%
      addTiles() %>%
      setView(lng = -76.505206, lat = 38.9767231, zoom = 7) %>%
      addPolygons(data = wbd_reg2, fill = TRUE, 
                  color = "black", weight =1,
                  fillColor = ~pal(AREA),
                  fillOpacity = 0.8,
                  popup = ~HUC_NAME) %>%
      addLegend(position = "bottomright", pal = pal, values = wbd_reg2$AREA)
  })
  
  # # remember to comment out the pal defn earlier
  # observe({
  #   pal <- colorNumeric(input$colors, wbd_reg2$AREA)
  # 
  #   ...("map") %>%
  #     ... %>%
  #     addPolygons(data = wbd_reg2, fill = TRUE,
  #                 color = "black", weight =1,
  #                 fillColor = ~pal(AREA),
  #                 fillOpacity = 0.8,
  #                 popup = ~HUC_NAME) %>%
  #     addLegend(position = "bottomright", pal = pal, values = wbd_reg2$AREA)
  # 
  # })


}

shinyApp(ui, server)