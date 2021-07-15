# worksheet 4
# leaflet in shiny with leafletProxy

library(shiny)
library(leaflet)
library(RColorBrewer)
library(sf)
library(dplyr)

# read in data for 
# watershed boundaries downloaded from 
# https://water.usgs.gov/GIS/metadata/usgswrd/XML/huc250k.xml
# filtered to northeast region 
wbd_reg2 <- st_read("https://raw.githubusercontent.com/khondula/leaflet-in-R-shinydemo2/master/data/wbd_reg2.geojson") %>%
  filter(REG == "02") %>%
  st_transform(4326)

# user interface with map and color scheme widget
ui <- fluidPage(
  leafletOutput("map", height = 800),
  absolutePanel(top = 10, right = 10, draggable = TRUE,
                selectInput(inputId = "colors",
                            label = "Color Scheme",
                            choices = row.names(brewer.pal.info))
  ))


# server definition
server <- function(input, output) {
  
  output$map <- renderLeaflet({
    
    pal <- colorNumeric("BrBG", wbd_reg2$AREA) # use this line with leafletproxy for default colors
  
    # map with polygons and legend
    leaflet() %>%
      addTiles() %>%
      setView(lng = -76.505206, lat = 38.9767231, zoom = 7) %>%
      addPolygons(data = wbd_reg2, 
                  fill = TRUE,
                  color = "black", 
                  weight =1,
                  fillColor = ~pal(AREA), # color is function of the wbd AREA column
                  fillOpacity = 0.8,
                  popup = ~HUC_NAME) %>%
      addLegend(position = "bottomright", pal = pal, values = wbd_reg2$AREA)
  })
  
  # update map using leaflet proxy instead of recreating the whole thing
  # use observe to color layer as needed
  observe({
    # color palette is defined according to the user's input
    pal <- colorNumeric(input$colors, wbd_reg2$AREA)
    
    leafletProxy("map") %>%
      clearShapes() %>% clearControls() %>%
      addPolygons(data = wbd_reg2, fill = TRUE,
                  color = "black", weight =1,
                  fillColor = ~pal(AREA),
                  fillOpacity = 0.8,
                  popup = ~HUC_NAME) %>%
      addLegend(position = "bottomright", pal = pal, values = wbd_reg2$AREA)
  })
}

shinyApp(ui, server)