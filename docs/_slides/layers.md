---
---

## Layers

about layers 

===

layers


~~~r
leaflet() %>%
  addTiles(group = "OSM") %>%
  addProviderTiles(providers$Esri.WorldImagery, group = "Esri World Imagery") %>%
  setView(lng = -76.505206, lat = 38.9767231, zoom = 7) %>%
  addMarkers(lng = -76.505206, lat = 38.9767231, popup = "I am here!", group = "SESYNC") %>%
  addLayersControl(baseGroups = c("OSM", "Esri World Imagery"), 
                   overlayGroups = c("SESYNC"),
                   options = layersControlOptions(collapsed = FALSE))
~~~
{:.text-document title="worksheet-1.R"}


===

To show how leaflet can access open data from various web mapping services (WMS), we add real-time weather radar data from the [Iowa Environmental Mesonet](https://mesonet.agron.iastate.edu/ogc/).


~~~r
leaflet() %>%
  addTiles() %>%
  setView(lng = -76.505206, lat = 38.9767231, zoom = 5) %>%
  addWMSTiles(
    "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi",
    layers = "nexrad-n0r-900913", 
    options = WMSTileOptions(format = "image/png", transparent = TRUE),
    attribution = "Weather data © 2012 IEM Nexrad"
  ) 
~~~
{:.text-document title="worksheet-1.R"}


===

web mapping services for the USGS national map


~~~r
nhd_wms_url <- "https://basemap.nationalmap.gov/arcgis/services/USGSTopo/MapServer/WmsServer"

leaflet() %>% 
  setView(lng = -111.846061, lat = 36.115847, zoom = 12) %>%
  addWMSTiles(nhd_wms_url, layers = "0")
~~~
{:.text-document title="worksheet-1.R"}


===

mini map


~~~r
leaflet() %>% 
  setView(lng = -111.846061, lat = 36.115847, zoom = 12) %>%
  addWMSTiles(nhd_wms_url, layers = "0") %>%
  addMiniMap(zoomLevelOffset = -4)
~~~
{:.text-document title="worksheet-1.R"}


===

extra features


~~~r
# graticules, daynight shading, measuring tool

leaflet() %>% 
  setView(lng = -111.846061, lat = 36.115847, zoom = 12) %>%
  addWMSTiles(nhd_wms_url, layers = "0") %>%
  addMiniMap(zoomLevelOffset = -4) %>%
  addGraticule() %>%
  addTerminator() %>% 
  addMeasure()
~~~
{:.text-document title="worksheet-1.R"}



===

custom javascript


~~~r
leaflet() %>%
  addTiles() %>% 
  addEasyButton(easyButton(
    icon="fa-crosshairs", title = "Locate me", 
    onClick=JS("function(btn, map){ map.locate({setView: true}); }")))
~~~
{:.text-document title="worksheet-1.R"}


