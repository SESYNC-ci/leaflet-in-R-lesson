---
editor_options: 
  chunk_output_type: console
---

## Layers Control

Layers can be assigned to named **groups** which can be toggled on and off by the user. *baseGroups* are selected with radio buttons (can only choose one at a time), and *overlayGroups* get checkboxes. 

To implement layers control, add group names to individual layers with the `group =` argument **AND** add the layers control layer using `addLayersControl()`. 



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

~~~
Error in loadNamespace(name): there is no package called 'webshot'
~~~
{:.output}


===

Another type of tile layer is avaible through many web mapping services (WMS), such as the real-time weather radar data from the [Iowa Environmental Mesonet](https://mesonet.agron.iastate.edu/ogc/).


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

~~~
Error in loadNamespace(name): there is no package called 'webshot'
~~~
{:.output}


===

or USGS topographic maps from the [National Map](https://viewer.nationalmap.gov/help/HowTo.htm): 


~~~r
nhd_wms_url <- "https://basemap.nationalmap.gov/arcgis/services/USGSTopo/MapServer/WmsServer"

leaflet() %>% 
  setView(lng = -111.846061, lat = 36.115847, zoom = 12) %>%
  addWMSTiles(nhd_wms_url, layers = "0")
~~~
{:.text-document title="worksheet-1.R"}

~~~
Error in loadNamespace(name): there is no package called 'webshot'
~~~
{:.output}


Thanks USGS! Check out more USGS R packages for accessing, processing, and modeling data on [github](https://github.com/USGS-R).

===

In addition to tile layers and markers, many other map features can be added and customized with `add*()` functions. Refer to the help documentation (eg. `?addMiniMap`) to see all of the customization options and learn the default settings. 


~~~r
leaflet() %>% 
  setView(lng = -111.846061, lat = 36.115847, zoom = 12) %>%
  addWMSTiles(nhd_wms_url, layers = "0") %>%
  addMiniMap(zoomLevelOffset = -4)
~~~
{:.text-document title="worksheet-1.R"}

~~~
Error in loadNamespace(name): there is no package called 'webshot'
~~~
{:.output}


===

Add layers with common map elements and customize them with `add*`. Even more new features coming soon! 


~~~r
leaflet() %>% 
  setView(lng = -111.846061, lat = 36.115847, zoom = 12) %>%
  addWMSTiles(nhd_wms_url, layers = "0") %>%
  addMiniMap(zoomLevelOffset = -4) %>%
  addGraticule() %>%
  addTerminator() %>% 
  addMeasure() %>%
  addScaleBar()
~~~
{:.text-document title="worksheet-1.R"}

~~~
Error in loadNamespace(name): there is no package called 'webshot'
~~~
{:.output}



===

Trigger custom javascript logic with *EasyButtons*. 


~~~r
leaflet() %>%
  addTiles() %>% 
  addEasyButton(easyButton(
    icon="fa-crosshairs", title = "Locate me", 
    onClick=JS("function(btn, map){ map.locate({setView: true}); }")))
~~~
{:.text-document title="worksheet-1.R"}


The fine print: Note that RStudio's viewer pane or external window does not always behave the same as a web brower. 
