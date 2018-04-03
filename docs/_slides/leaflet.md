---
---

## Interactive maps with Leaflet

*leaflet* produces interactive maps, with controls to zoom, pan and toggle layers and combine local data with base layers from web mapping services.

===

The `leaflet()` function creates an empty leaflet map to which layers can be added using the pipe (`%>%`) operator. The `addTiles` functions adds a base tiled map; by default, it imports tiles made from  [OpenStreetMap](https://www.openstreetmap.org/) data. We center and set an initial zoom level the map with `setView`. 


~~~r
library(leaflet)
leaflet() %>%
      addTiles() %>%
      setView(lng = -76.505206, lat = 38.9767231, 
                    zoom = 7)
~~~
{:.text-document title="worksheet-1.R"}


===

Switch to the "Viewer" tab in RStudio to see the result.

<!-- ![leaflet1]({{ site.baseurl }}/images/leaflet1.png) -->

===

add marker


~~~r
leaflet() %>%
  addTiles() %>%
  setView(lng = -76.505206, lat = 38.9767231, zoom = 7) %>%
  addMarkers(lng = -76.505206, lat = 38.9767231, popup = "I am here!")
~~~
{:.text-document title="worksheet-1.R"}


===

use provider tiles


~~~r
leaflet() %>%
  addProviderTiles(providers$Esri.WorldImagery) %>%
  setView(lng = -76.505206, lat = 38.9767231, zoom = 7) %>%
  addMarkers(lng = -76.505206, lat = 38.9767231, popup = "I am here!")
~~~
{:.text-document title="worksheet-1.R"}


===

