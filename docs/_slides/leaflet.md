---
editor_options: 
  chunk_output_type: console
---

## What's a Leaflet?

leaflet produces maps have controls to zoom, pan and toggle layers on and off, and can combine local data with base layers from web mapping services. 

Maps will appear in RStudio's Viewer pane, and can also be viewed in a web browser and saved as html files.

===

The `leaflet()` function creates an empty leaflet map to which layers can be added using the pipe (`%>%`) operator. The `addTiles()` functions adds a base tiled map; by default, it uses tiles made from [OpenStreetMap](https://www.openstreetmap.org/) data. Center and set an initial zoom level the map with `setView()`. Switch to the "Viewer" tab in RStudio to see the result.


~~~r
library(leaflet)

leaflet() %>%
    addTiles() %>%
    setView(lng = -76.505206, lat = 38.9767231, zoom = 7)
~~~
{:.text-document title="worksheet-1.R"}


===

Add a new layer with a point marker using `addMarkers()`, with a custom message that displays when the marker is clicked. 


~~~r
leaflet() %>%
  addTiles() %>%
  setView(lng = -76.505206, lat = 38.9767231, zoom = 7) %>%
  addMarkers(lng = -76.505206, lat = 38.9767231, popup = "I am here!")
~~~
{:.text-document title="worksheet-1.R"}


===

In addition to OSM, there are many other data providers that make sets of tiles available to use as basemaps. There is a R list object called `providers` with the names of these options. 


~~~r
leaflet() %>%
  addProviderTiles(providers$Esri.WorldImagery) %>%
  setView(lng = -76.505206, lat = 38.9767231, zoom = 7) %>%
  addMarkers(lng = -76.505206, lat = 38.9767231, popup = "I am here!")
~~~
{:.text-document title="worksheet-1.R"}


===

Zoom all the way out. What projection does it look like this map is using? 

![dragons]({{ site.baseurl }}/images/dragons.png | width = "400px")
