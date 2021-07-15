# worksheet 1
# leaflet without data

library(leaflet)

# set viewing area
leaflet() %>%
  addTiles() %>%
  ...(lng = -76.505206, lat = 38.9767231, ... = 7)

# add marker
leaflet() %>%
  addTiles() %>%
  setView(lng = -76.505206, lat = 38.9767231, zoom = 7) %>%
  ...(lng = -76.505206, lat = 38.9767231, ... = "I am here!")

# other base map tiles
leaflet() %>%
  ...(providers$...) %>%
  setView(lng = -76.505206, lat = 38.9767231, zoom = 7) %>%
  addMarkers(lng = -76.505206, lat = 38.9767231, popup = "I am here!")

# layers control
leaflet() %>%
  addTiles(... = "OSM") %>%
  addProviderTiles(providers$Esri.WorldImagery, ... = "Esri World Imagery") %>%
  setView(lng = -76.505206, lat = 38.9767231, zoom = 7) %>%
  addMarkers(lng = -76.505206, lat = 38.9767231, popup = "I am here!", ... = "SESYNC") %>%
  ...(baseGroups = c("OSM", "Esri World Imagery"), 
                   overlayGroups = c("SESYNC"),
                   options = layersControlOptions(collapsed = FALSE))

# Web mapping service tiles

leaflet() %>%
  addTiles() %>%
  setView(lng = -76.505206, lat = 38.9767231, zoom = 5) %>%
  ...(
    "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi",
    ... = "nexrad-n0r-900913", 
    options = ...(format = "image/png", ... = TRUE),
    attribution = "Weather data © 2012 IEM Nexrad"
  ) 


nhd_wms_url <- "https://basemap.nationalmap.gov/arcgis/services/USGSTopo/MapServer/WmsServer"

leaflet() %>% 
  setView(lng = -111.846061, lat = 36.115847, zoom = 12) %>%
  ...(..., layers = "0")

# mini map

leaflet() %>% 
  setView(lng = -111.846061, lat = 36.115847, zoom = 12) %>%
  addWMSTiles(nhd_wms_url, layers = "0") %>%
  ...

# graticules, daynight shading, measuring tool

leaflet() %>% 
  setView(lng = -111.846061, lat = 36.115847, zoom = 12) %>%
  addWMSTiles(nhd_wms_url, layers = "0") %>%
  addMiniMap(zoomLevelOffset = -4) %>%
  ... 
  ...
  ...
  ...
  
# custom javascript button
# run in browser
leaflet() %>%
  addTiles() %>% 
  ...(easyButton(
    icon="fa-crosshairs", title = "Locate me", 
    onClick=JS("function(btn, map){ ...({setView: true}); }")))


