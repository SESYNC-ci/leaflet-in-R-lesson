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
library(webshot)
leaflet() %>%
    addTiles() %>%
    setView(lng = -76.505206, lat = 38.9767231, zoom = 7)
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}
<div class="figure">
<!--html_preserve--><div id="htmlwidget-197cb05491414d38e0bb" style="width:504px;height:504px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-197cb05491414d38e0bb">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]}],"setView":[[38.9767231,-76.505206],7,[]]},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption"> </p>
</div>

===

Add a new layer with a point marker using `addMarkers()`, with a custom message that displays when the marker is clicked. 



~~~r
leaflet() %>%
  addTiles() %>%
  setView(lng = -76.505206, lat = 38.9767231, zoom = 7) %>%
  addMarkers(lng = -76.505206, lat = 38.9767231, popup = "I am here!")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}
<div class="figure">
<!--html_preserve--><div id="htmlwidget-cb9bdfbd39d8ba6280aa" style="width:504px;height:504px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-cb9bdfbd39d8ba6280aa">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addMarkers","args":[38.9767231,-76.505206,null,null,null,{"interactive":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},"I am here!",null,null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"setView":[[38.9767231,-76.505206],7,[]],"limits":{"lat":[38.9767231,38.9767231],"lng":[-76.505206,-76.505206]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption"> </p>
</div>

===

In addition to OSM, there are many other data providers that make sets of [tiles](https://wiki.openstreetmap.org/wiki/Tiles) available to use as basemaps. There is a R list object called `providers` with the names of these options. 



~~~r
leaflet() %>%
  addProviderTiles(providers$Esri.WorldImagery) %>%
    setView(lng = -76.505206, lat = 38.9767231, zoom = 7) %>%
      addMarkers(lng = -76.505206, lat = 38.9767231, popup = "I am here!")
~~~
{:title="{{ site.data.lesson.handouts[0] }}" .text-document}
<div class="figure">
<!--html_preserve--><div id="htmlwidget-6a0367b630e7e79cded4" style="width:504px;height:504px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-6a0367b630e7e79cded4">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addProviderTiles","args":["Esri.WorldImagery",null,null,{"errorTileUrl":"","noWrap":false,"detectRetina":false}]},{"method":"addMarkers","args":[38.9767231,-76.505206,null,null,null,{"interactive":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},"I am here!",null,null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"setView":[[38.9767231,-76.505206],7,[]],"limits":{"lat":[38.9767231,38.9767231],"lng":[-76.505206,-76.505206]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
<p class="caption"> </p>
</div>

===

Zoom all the way out. What projection does it look like this map is using? 
![dragons]({% include asset.html path="images/dragons.png" %}){:height="200%"}

Read more about the [intracacies of web mercator](https://www.researchgate.net/publication/265895464_Implications_of_Web_Mercator_and_Its_Use_in_Online_Mapping) e.g. why it is [considered unsuitable for geospatial intelligence purposes](https://www.slideshare.net/NGA_GEOINT/ngas-position-on-webmercator). Learn how to define a custom leaflet CRS [here](https://rstudio.github.io/leaflet/projections.html).make
